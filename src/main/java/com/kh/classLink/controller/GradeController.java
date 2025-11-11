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
            @RequestParam(value = "classSelect", required = false) Integer classNo,
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

        // 4) 수강반을 아직 선택 안 하고 처음 들어온 경우 → 여기서 끝
        if (classNo == null) {
            return "lecture/leGradeCheck";
        }

        //수강반에 소속된 학생 조회
        List<Class> selectStudentsByClassNo = classService.selectStudentsByClassNo(classNo);
        model.addAttribute("studentList", selectStudentsByClassNo);
        model.addAttribute("selectedClassNo", classNo);
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

    @GetMapping("/stScore.co")
    public String stScore(HttpSession session, Model model) {
             //학생 성적 조회
            Member login = (Member) session.getAttribute("loginMember");
            if (login == null) return "redirect:/login.co";

            // 성적이 있는 과목(강의) 목록
            List<Lecture> subjectList = gradeService.findLecturesByStudent(login.getMemberNo());
            model.addAttribute("subjectList", subjectList);

            return "student/stScore";
        }

}
