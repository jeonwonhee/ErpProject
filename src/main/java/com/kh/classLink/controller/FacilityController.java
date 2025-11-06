package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FacilityController {
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

    @GetMapping("/stFacility.co")
    public String stFacility() {
        //학생 기자재
        return "student/stFacility";
    }

}
