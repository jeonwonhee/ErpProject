package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class adminController {

    /**
     * 관리자 대시보드
     * @return
     */
    @GetMapping("/adminDashboard.co")
    public String adminDashboard(){
        return "admin/adminDashboard";
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
     * 관리자 출결현황
     * @return
     */
    @GetMapping("/adminAttendanceDashboard.co")
    public String adminAttendanceDashboard(){
        return "admin/adminAttendanceDashboard";
    }

    /**
     * 관리자 학생관리
     * @return
     */
    @GetMapping("/adminStudentList.co")
    public String adminStudentList(){
        return "admin/adminStudentList";
    }

    /**
     * 관리자 직원관리
     * @return
     */
    @GetMapping("/adminLectureList.co")
    public String adminLectureList(){
        return "admin/adminLectureList";
    }

    /**
     * 관리자 일정관리 상세
     * @return
     */
    @GetMapping("/adminCalenderDetail.co")
    public String adminCalenderDetail(){
        return "admin/adminCalenderDetail";
    }
    
    /**
     * 관리자 기자재관리
     * @return
     */
    @GetMapping("/adminFacility.co")
    public String adminFacility(){
        return "admin/adminFacility";
    }

    /**
     * 관리자 기자재추가
     * @return
     */
    @GetMapping("/adminFacilityDetail.co")
    public String adminFacilityDetail(){
        return "admin/adminFacilityDetail";
    }
}
