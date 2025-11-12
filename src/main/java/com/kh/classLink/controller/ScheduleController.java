package com.kh.classLink.controller;

import com.kh.classLink.model.vo.LectureDateApproval;
import com.kh.classLink.model.vo.LectureDateApprovalList;
import com.kh.classLink.service.LectureDateService;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.Member;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ScheduleController {

    private final LectureDateService lectureDateService;

    /**
     *
     * 일정 컨트롤러
     */

    @GetMapping("/stLectureDate.co")
    public String stLectureDate(Model model, HttpSession session) {
        //학생 일정조회
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();
        List<LectureDate> events = lectureDateService.selectLectureDateList(memberNo);
        model.addAttribute("events", events);

        return "student/stLectureDate";
    }

    /**
     * 관리자 일정관리
     */
//    @GetMapping("/adminCalenderManage.co")
//    public String adminCalenderManage(Model model) {
//        List<LectureDateApprovalList> approvalList = lectureDateService.selectLectureDateApprovalList();
//        model.addAttribute("approvalList", approvalList);
//
//        return "admin/adminCalenderManage";
//    }

    @GetMapping("/adminCalenderManage.co")
    public String adminCalenderManage(
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {

        // 전체 데이터 개수 조회
        int listCount = lectureDateService.getLectureDateListCount();

        // 한 페이지에 보여줄 데이터 개수, 하단 페이지 버튼 개수 설정
        int boardLimit = 10;
        int pageLimit = 5;

        // 페이징 계산
        int maxPage = (int) Math.ceil((double) listCount / boardLimit);
        int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) endPage = maxPage;

        int startRow = (currentPage - 1) * boardLimit;
        int endRow = startRow + boardLimit;

        // 매퍼에 보낼 범위
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("startRow", startRow);
        paramMap.put("endRow", endRow);

        // 목록 조회
        List<LectureDateApprovalList> approvalList = lectureDateService.selectLectureDateListPaged(paramMap);

        // JSP로 전달
        model.addAttribute("approvalList", approvalList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "admin/adminCalenderManage";
    }

    /**
     * 관리자 일정관리 상세
     */
    @GetMapping("/adminCalenderDetail.co")
    public String adminCalenderDetail(@RequestParam("lectureDateNo") int lectureDateNo,
                                      Model model) {
        LectureDateApprovalList detail = lectureDateService.selectLectureDateApprovalDetail(lectureDateNo);
        model.addAttribute("detail", detail);

        return "admin/adminCalenderDetail";
    }

    /** 강사 일정목록 페이지
     * @return
     */
    @GetMapping("/leCalender.co")
    public String lectureCalender(Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();
        List<LectureDate> events = lectureDateService.selectLectureDateList(memberNo);
        model.addAttribute("events", events);

        return "lecture/leCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/leCalenderPlus.co")
    public String lectureCalenderPlus() {
        return "lecture/leCalenderAdd";
    }

    /*
    * 강사 일정 추가
    * */
    @PostMapping("/insertLectureDate.bo")
    public String lectureDateAdd(@ModelAttribute LectureDate lectureDate,
                                 HttpSession session) {
        Member lecture = (Member) session.getAttribute("loginMember");

        int classLectureNo = lectureDateService.getClassLectureNoByMemberNo(lecture.getMemberNo());

        lectureDate.setClassLectureNo(classLectureNo); // 로그인한 강사 번호 세팅

        int result = lectureDateService.insertLectureDate(lectureDate);

        if(result > 0) {
            session.setAttribute("alertMsg","일정 등록 성공");
            return "redirect:/lecture/leCalender.co";
        } else {
            session.setAttribute("alertMsg", "일정 등록 실패");
            return "redirect:/lecture/leCalenderPlus";
        }
    }

//    @GetMapping("/testLogin")
//    public String testLogin(HttpSession session) {
//        Member fakeTeacher = new Member();
//        fakeTeacher.setMemberNo(1);            // DB에 존재하는 MEMBER_NO
//        fakeTeacher.setMemberId("teacher01");
//        fakeTeacher.setMemberName("김강사");
//        fakeTeacher.setRole("TEACHER");
//
//        session.setAttribute("loginUser", fakeTeacher);
//        System.out.println("✅ 임시 로그인 완료: " + fakeTeacher);
//
//        return "redirect:/lecture/leCalenderPlus.co?classLectureNo=1";
//    }

    @PostMapping("/adminCalenderManage.co")
    @ResponseBody
    public String updateApprovalStatus(
            @RequestParam("lectureDateNo") int lectureDateNo,
            @RequestParam("status") String status,
            @RequestParam(value = "reason", required = false) String reason,
            HttpSession session) {

        Member admin = (Member) session.getAttribute("loginUser");
        int adminNo = admin != null ? admin.getMemberNo() : 0;

        try {
            int result = lectureDateService.updateApprovalStatus(lectureDateNo, status, reason, adminNo);
            return (result > 0) ? "success" : "fail";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

}
