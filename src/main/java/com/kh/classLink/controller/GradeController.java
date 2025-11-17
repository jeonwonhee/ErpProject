package com.kh.classLink.controller;

import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Lecture;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.ClassService;
import com.kh.classLink.service.GradeService;
import com.kh.classLink.service.LectureService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.kh.classLink.model.vo.Class;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
public class GradeController {

    private GradeService gradeService;
    private final ClassService classService;
    private LectureService lectureService;

    @Autowired
    public GradeController(GradeService gradeService, ClassService classService,
                           LectureService lectureService) {
        this.gradeService = gradeService;
        this.classService = classService;
        this.lectureService = lectureService;
    }

    /** 강사 성적입력 페이지
     * @return
     */
    @GetMapping("/leGrade.co")
    public String lectureGradeCheck(
            @RequestParam(value = "tab", defaultValue = "input") String tab,
            @RequestParam(value = "classSelect", required = false) Integer classNo,
            @RequestParam(value = "keyword", required = false) String keyword,
            HttpSession session,
            Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();
        int lectureNo = lectureService.getLectureNoByMemberNo(memberNo);


        // 강사가 담당하는 반들 (특정 lectureNo 기준)
        List<Class> selectClassByLecture = classService.selectClassByLecture(memberNo, lectureNo);
        model.addAttribute("classList", selectClassByLecture);

        model.addAttribute("activeTab", tab);

        // =======================
        // 탭 1) 성적 입력
        // =======================
        if ("input".equals(tab)) {

            if (classNo != null) {
                List<Class> studentList = classService.selectStudentsByClassNo(classNo);
                model.addAttribute("studentList", studentList);
                model.addAttribute("selectedClassNo", classNo);
            }

            return "lecture/leGradeCheck";
        }

        // =======================
        // 탭 2) 성적 수정
        // =======================
        if ("edit".equals(tab)) {

            model.addAttribute("selectedClassNo", classNo);

            // 시험 검색한 경우
            if (classNo != null && keyword != null && !keyword.isEmpty()) {

                List<GradeDto> list =
                        gradeService.searchGradesForEdit(classNo, keyword, lectureNo);

                model.addAttribute("gradeEditList", list);
                model.addAttribute("keyword", keyword);
            }

            return "lecture/leGradeCheck";
        }

        return "lecture/leGradeCheck";
    }

    @PostMapping("/leGradeSave.co")
    public String saveGradeCheck(@RequestParam("classNo") int classNo,
                                 @RequestParam("testName") String testName,
                                 @RequestParam("studentNo") List<Integer> studentNoList,
                                 @RequestParam("grade") List<Integer> gradeList,
                                 HttpSession session){
        // 1) 로그인 체크
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();
        int lectureNo = lectureService.getLectureNoByMemberNo(memberNo);

        // 2) CLASS_LECTURE_NO 구하기 (반 + 강의로)
        int classLectureNo = gradeService.findClassLectureNo(classNo, lectureNo);

        // 3) 학생별 성적 DTO 리스트 만들기
        List<GradeDto> gradeDtoList = new ArrayList<>();

        int size = Math.min(studentNoList.size(), gradeList.size());

        for (int i = 0; i < size; i++) {
            GradeDto dto = new GradeDto();
            dto.setStudentNo(studentNoList.get(i));  // 학생 번호
            dto.setGrade(gradeList.get(i));          // 점수
            dto.setClassLectureNo(classLectureNo);   // 수강반+강의 번호
            dto.setTestName(testName);               // ✅ 시험 이름 (공통)

            gradeDtoList.add(dto);
        }

        // 4) 서비스 호출해서 DB INSERT
        gradeService.insertGrades(gradeDtoList);

        session.setAttribute("alertMsg", "성적이 저장되었습니다.");

        // 다시 같은 반 선택된 상태로 목록 보여주기
        return "redirect:/leGrade.co?classSelect=" + classNo;
    }

    @PostMapping("/leGradeUpdate.co")
    public String updateGrade(@RequestParam("gradeNo") int gradeNo,
                              @RequestParam("newGrade") int newGrade,
                              @RequestParam("testName") String testName,
                              @RequestParam("classSelect") int classNo,   // 어떤 반에서 수정했는지
                              @RequestParam(value = "keyword", required = false) String keyword, // 시험이름 검색어
                              HttpSession session,
                              RedirectAttributes ra) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/login.co";
        }

        GradeDto dto = new GradeDto();
        dto.setGradeNo(gradeNo);     // WHERE GRADE_NO = #{gradeNo}
        dto.setGrade(newGrade);      // SET GRADE = #{grade}
        dto.setTestName(testName);   // SET TEST_NAME = #{testName}

        System.out.println("dto in controller = " + dto);
        int result = gradeService.updateGrade(dto);
        System.out.println("updateGrade result = " + result);

        if (result > 0) {
            session.setAttribute("alertMsg", "성적이 수정되었습니다.");

        } else {
            session.setAttribute("alertMsg", "성적 수정에 실패했습니다.");
        }

        // 다시 "성적 수정" 탭 + 선택했던 반 + 검색어 유지
        String redirectUrl = "redirect:/leGrade.co?tab=edit&classSelect=" + classNo;
        if (keyword != null && !keyword.isBlank()) {
            try {
                redirectUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, java.nio.charset.StandardCharsets.UTF_8);
            } catch (Exception e) {
                // 인코딩 실패해도 그냥 무시하고 넘어감
            }
        }
        return redirectUrl;
    }


    @GetMapping("/stScore.co")
    public String stScore(@RequestParam(value = "lectureNo", required = false) Integer lectureNo,
                          HttpSession session,
                          Model model) {

        // 1) 로그인 체크
        Member login = (Member) session.getAttribute("loginMember");
        if (login == null) {
            return "redirect:/login.co";
        }

        int studentNo = login.getMemberNo();

        // 2) 항상 과목 목록 조회
        List<Lecture> subjectList = gradeService.findLecturesByStudent(studentNo);
        model.addAttribute("subjectList", subjectList);

        // 3) 과목을 선택한 경우에만 성적 목록 조회
        if (lectureNo != null) {
            List<GradeDto> gradeList =
                    gradeService.findGradesByStudentAndLecture(studentNo, lectureNo);

            model.addAttribute("gradeList", gradeList);
            model.addAttribute("selectedLectureNo", lectureNo);
        }

        return "student/stScore";   // /WEB-INF/views/student/stScore.jsp
    }

    //학생 성적 정정페이지 이동
    @GetMapping("/gradeUpdate.co")
    public String gradeUpdate(Model model) {

        List<String> testNameList = gradeService.findTestNamesByStudent(1);

        model.addAttribute("testNameList", testNameList);

        return "student/gradeUpdate";
    }
}

