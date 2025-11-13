package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {
    /**
     * 관리자 대시보드
     * @return
     */
    @GetMapping("/adminDashboard.co")
    public String adminDashboard(){
        return "admin/adminDashboard";
    }

    /** 강사 대시보드
     * @return
     */
    @GetMapping("/lectureDashboard")
    public String lectureDashboard() {return "lecture/leDashboard";}

    @GetMapping("/stMain.co")
    public String stMain() {
        //학생 대시보드
        return "student/stMain";
    }

}
