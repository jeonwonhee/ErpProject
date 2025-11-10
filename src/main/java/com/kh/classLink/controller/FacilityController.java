package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.FacilityService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
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
    @PostMapping("/insert.di")
    public String insertFacility(
            @RequestParam("deviceName") String deviceName,
            @RequestParam("amount") int amount, HttpSession session, Model model){

        Member loginMember = (Member) session.getAttribute("loginMember");
        if("ADMIN".equals(loginMember.getRole())){
           int result = FacilityService.insertFacility(deviceName,amount);

           if(result>0){
               return "admin/adminFacility";
           } else{
               return "admin/adminFacilityDetail";
           }
        }
    }

}
