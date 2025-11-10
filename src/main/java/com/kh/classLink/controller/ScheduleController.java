package com.kh.classLink.controller;

import com.kh.classLink.service.LectureDateService;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.Member;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class ScheduleController {

    private final LectureDateService lectureDateService;

    /**
     *
     * 일정 컨트롤러
     */

    @GetMapping("/stLectureDate.co")
    public String stLectureDate() {
        //학생 일정조회
        return "student/stLectureDate";
    }

    /**
     * 관리자 일정관리
     * @return
     */
    @GetMapping("/adminCalenderManage.co")
    public String adminCalenderManage(){
        return "admin/adminCalenderManage";
    }

    /**
     * 관리자 일정관리 상세
     * @return
     */
    @GetMapping("/adminCalenderDetail.co")
    public String adminCalenderDetail(){
        return "admin/adminCalenderDetail";
    }

    /** 강사 일정목록 페이지
     * @return
     */
    @GetMapping("/lecture/leCalender.co")
    public String lectureCalender() {
        return "lecture/leCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/lecture/leCalenderPlus.co")
    public String lectureCalenderPlus() {
        return "lecture/leCalenderAdd";
    }

    /*
    * 강사 일정 추가
    * */
    @PostMapping("/lecture/insertLectureDate.bo")
    public String lecturedateAdd(@ModelAttribute LectureDate lectureDate,
                                 HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        int classLectureNo = lectureDateService.getClassLectureNoByMemberNo(loginUser.getMemberNo());

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

    @GetMapping("/testLogin")
    public String testLogin(HttpSession session) {
        Member fakeTeacher = new Member();
        fakeTeacher.setMemberNo(1);            // DB에 존재하는 MEMBER_NO
        fakeTeacher.setMemberId("teacher01");
        fakeTeacher.setMemberName("김강사");
        fakeTeacher.setRole("TEACHER");

        session.setAttribute("loginUser", fakeTeacher);
        System.out.println("✅ 임시 로그인 완료: " + fakeTeacher);

        return "redirect:/lecture/leCalenderPlus.co?classLectureNo=1";
    }

}
