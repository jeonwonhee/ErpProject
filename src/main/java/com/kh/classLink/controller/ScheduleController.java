package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ScheduleController {

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
    @GetMapping("/leCalender.co")
    public String lectureCalender() {
        return "lecture/leCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/leCalenderPlus.co")
    public String lectureCalenderPlus() {
        return "lecture/leCalenderAdd";
    }


}
