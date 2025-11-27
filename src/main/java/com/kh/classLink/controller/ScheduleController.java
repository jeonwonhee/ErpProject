package com.kh.classLink.controller;

import com.kh.classLink.model.vo.*;
import com.kh.classLink.service.LectureDateService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ScheduleController {

    private final LectureDateService lectureDateService;

    /* 일정 컨트롤러 */
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

    /* 관리자 일정관리 */
    @GetMapping("/adminCalenderManage.co")
    public String adminCalenderManage(@RequestParam(value = "page", defaultValue = "1") int currentPage, Model model) {

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

    /* 관리자 일정관리 상세 */
    @GetMapping("/adminCalenderDetail.co")
    public String adminCalenderDetail(@RequestParam("lectureDateNo") int lectureDateNo, Model model) {
        LectureDateApprovalList detail = lectureDateService.selectLectureDateApprovalDetail(lectureDateNo);
        model.addAttribute("detail", detail);

        return "admin/adminCalenderDetail";
    }

    /* 관리자 일정관리 승인/반려 */
    @PostMapping("/adminCalenderManage.co")
    public String updateApprovalStatus(@RequestParam("lectureDateNo") int lectureDateNo,
                                       @RequestParam("status") String status,
                                       @RequestParam(value = "reason", required = false) String reason,
                                       @ModelAttribute LectureDateApproval lectureDateApproval,
                                       HttpSession session) {

        Member admin = (Member) session.getAttribute("loginMember");
        int adminNo = admin != null ? admin.getMemberNo() : 0;

        // ===== 반려 내용 검증 =====
        if (lectureDateApproval.getApprovalReject() != null && lectureDateApproval.getApprovalReject().length() > 200) {
            session.setAttribute("alertMsg", "반려 내용은 최대 200자까지 입력 가능합니다.");
            return "redirect:/leCalenderPlus.co";
        }

        lectureDateService.updateApprovalStatus(lectureDateNo, status, reason, adminNo);

        return "redirect:/adminCalenderManage.co";
    }

    /* 강사 일정목록 페이지 */
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
        List<ClassLecture> classList = lectureDateService.selectClassLectureList(memberNo);

        model.addAttribute("classList", classList);

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

    /* 강사 일정추가 페이지 */
    @GetMapping("/leCalenderPlus.co")
    public String lectureDatePlus(@RequestParam(value = "classLectureNo", required = false) Integer classLectureNo,
                                  HttpSession session,
                                  Model model) {

        Member login = (Member) session.getAttribute("loginMember");

        // 강사가 담당하는 모든 반 조회
        List<ClassLecture> classList = lectureDateService.selectClassLectureList(login.getMemberNo());

        model.addAttribute("classList", classList);
        model.addAttribute("selectedClassLectureNo", classLectureNo);

        return "lecture/leCalenderAdd";
    }

    /* 강사 일정 추가 */
    @PostMapping("/insertLectureDate.bo")
    public String lectureDateAdd(@ModelAttribute LectureDate lectureDate,
                                 HttpSession session) {

        // ===== 제목 검증 =====
        if (lectureDate.getTitle() == null || lectureDate.getTitle().trim().isEmpty()) {
            session.setAttribute("alertMsg", "제목을 입력하세요.");
            return "redirect:/leCalenderPlus.co";
        }

        if (lectureDate.getTitle().length() > 50) {
            session.setAttribute("alertMsg", "제목은 최대 50자까지 입력 가능합니다.");
            return "redirect:/leCalenderPlus.co";
        }

        // ===== 상세 내용 검증 =====
        if (lectureDate.getContent() != null && lectureDate.getContent().length() > 500) {
            session.setAttribute("alertMsg", "상세 내용은 최대 500자까지 입력 가능합니다.");
            return "redirect:/leCalenderPlus.co";
        }

        // ===== 날짜 존재 여부 검증 =====
        if (lectureDate.getStartDate() == null || lectureDate.getEndDate() == null ||
                lectureDate.getStartDate().isEmpty() || lectureDate.getEndDate().isEmpty()) {

            session.setAttribute("alertMsg", "시작일과 종료일을 선택하세요.");
            return "redirect:/leCalenderPlus.co";
        }

        // ===== 일정 중복 조회 =====
        int overlap = lectureDateService.checkDateOverlap(lectureDate);
        if (overlap > 0) {
            session.setAttribute("alertMsg", "해당 기간에 이미 일정이 존재합니다.");
            return "redirect:/leCalenderPlus.co";
        }

        // ===== 날짜 형식 검증 및 비교 =====
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false); // 잘못된 날짜(ex: 2025-13-50) 거부

            Date start = sdf.parse(lectureDate.getStartDate());
            Date end   = sdf.parse(lectureDate.getEndDate());

            if (end.before(start)) {
                session.setAttribute("alertMsg", "종료일은 시작일보다 빠를 수 없습니다.");
                return "redirect:/leCalenderPlus.co";
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertMsg", "날짜 형식이 올바르지 않습니다.");
            return "redirect:/leCalenderPlus.co";
        }

        int result = lectureDateService.insertLectureDate(lectureDate);

        if(result > 0) {
            session.setAttribute("alertMsg","일정 등록 성공");
            return "redirect:/leCalender.co";
        } else {
            session.setAttribute("alertMsg", "일정 등록 실패");
            return "redirect:/leCalenderPlus";
        }
    }



    @GetMapping("/ajax/adminCalender")
    @ResponseBody
    public Map<String, Object> ajaxAdminCalender(
            @RequestParam(defaultValue="1") int page,
            @RequestParam(required = false) String keyword) {

        if (keyword == null) keyword = "";

        int listCount = lectureDateService.getLectureDateListCount(keyword);

        int boardLimit = 10; // 한 페이지 당 10개
        int pageLimit = 5;   // 페이징 바 5개

        //  페이지 계산
        int maxPage = (int) Math.ceil((double) listCount / boardLimit);

        int startPage = ((page - 1) / pageLimit) * pageLimit + 1;
        int endPage = startPage + pageLimit - 1;
        if (endPage > maxPage) endPage = maxPage;

        //  rownum 계산
        int startRow = (page - 1) * boardLimit + 1;
        int endRow = page * boardLimit;

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("startRow", startRow);
        paramMap.put("endRow", endRow);
        paramMap.put("keyword", keyword);

        List<LectureDateApprovalList> approvalList =
                lectureDateService.selectLectureDateListPaged(paramMap);

        Map<String, Object> result = new HashMap<>();
        result.put("approvalList", approvalList);
        result.put("currentPage", page);
        result.put("startPage", startPage);
        result.put("endPage", endPage);
        result.put("maxPage", maxPage);

        return result;
    }

}
