package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class adminController {

    /**
     *
     * @return
     */
    @GetMapping("/adminDashboard.co")
    public String adminDashboard(){
        return "admin/adminDashboard";
    }

    /**
     *
     * @return
     */
    @GetMapping("/adminCalenderManage.co")
    public String adminCalenderManage(){
        return "admin/adminCalenderManage";
    }

    /**
     *
     * @return
     */
    @GetMapping("/adminAttendanceDashboard.co")
    public String adminAttendanceDashboard(){
        return "admin/adminAttendanceDashboard";
    }

    /**
     *
     * @return
     */
    @GetMapping("/adminStudentList.co")
    public String adminStudentList(){
        return "admin/adminStudentList";
    }

    /**
     *
     * @return
     */
    @GetMapping("/adminLectureList.co")
    public String adminLectureList(){
        return "admin/adminLectureList";
    }
}
