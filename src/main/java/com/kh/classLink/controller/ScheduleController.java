package com.kh.classLink.controller;

import com.kh.classLink.model.vo.*;
import com.kh.classLink.service.LectureDateService;
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

        String className = lectureDateService.getClassNameByStudent(memberNo);
        model.addAttribute("className", className);

        List<LectureDate> events = lectureDateService.selectLectureDateListStudent(memberNo);
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
    public String lectureCalender(@RequestParam(value="classLectureNo", required=false) Integer classLectureNo,
                                  @RequestParam(value="page", defaultValue="1") int currentPage,
                                  Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login.co";
        }

        int memberNo = loginMember.getMemberNo();

        // 1. 강사가 가진 반 전체
        List<ClassLecture> classList = lectureDateService.selectLectureDateByClass(memberNo);

        model.addAttribute("classList", classList);

        System.out.println("classList = " + classList);

        if(classLectureNo == null && !classList.isEmpty()) {
            classLectureNo = (Integer) classList.get(0).getClassLectureNo();
        }

        List<LectureDate> events = lectureDateService.selectLectureDateList(classLectureNo);
        model.addAttribute("events", events);
        model.addAttribute("selectedClassLectureNo", classLectureNo);

        // =====================
        //      페이징 처리
        // =====================
        int listCount = lectureDateService.getLectureDateCount(classLectureNo);

        int boardLimit = 5;   // 5개씩
        int pageLimit = 5;    // 페이지 버튼 5개

        int maxPage = (int) Math.ceil((double) listCount / boardLimit);
        int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) endPage = maxPage;

        int startRow = (currentPage - 1) * boardLimit;
        int endRow = startRow + boardLimit;

        Map<String, Object> param = new HashMap<>();
        param.put("classLectureNo", classLectureNo);
        param.put("startRow", startRow);
        param.put("endRow", endRow);

        List<LectureDate> upcomingList = lectureDateService.selectLectureDatePaged(param);

        model.addAttribute("upcomingList", upcomingList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "lecture/leCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/leCalenderPlus.co")
    public String lectureDatePlus(@RequestParam(value = "classLectureNo", required = false) Integer classLectureNo,
                                  HttpSession session,
                                  Model model) {

        Member login = (Member) session.getAttribute("loginMember");

        // 강사가 담당하는 모든 반 조회
        List<ClassLecture> classList = lectureDateService.selectLectureDateByClass(login.getMemberNo());

        model.addAttribute("classList", classList);
        model.addAttribute("selectedClassLectureNo", classLectureNo);

        return "lecture/leCalenderAdd";
    }

    /*
    * 강사 일정 추가
    * */
    @PostMapping("/insertLectureDate.bo")
    public String lectureDateAdd(@ModelAttribute LectureDate lectureDate,
                                 HttpSession session) {

        int result = lectureDateService.insertLectureDate(lectureDate);

        if(result > 0) {
            session.setAttribute("alertMsg","일정 등록 성공");
            return "redirect:/leCalender.co";
        } else {
            session.setAttribute("alertMsg", "일정 등록 실패");
            return "redirect:/leCalenderPlus";
        }
    }

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
