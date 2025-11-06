package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {

    /**
     * 로그인
     * @return
     */
    @GetMapping("/login.co")
    public String login() {
        return "common/login";
    }

    /**
     * 비밀번호 찾기
     * @return
     */
    @GetMapping("/findPassword.co")
    public String findPassword() {
        return "common/findPassword";
    }

    /**
     * 비밀번호 변경
     * @return
     */
    @GetMapping("/changePassword.co")
    public String changePassword() {
        return "common/changePassword";
    }

    /** 관리자/강사 생성
     * @return
             */
    @GetMapping("/adminRegister.co")
    public String adminRegister(){
        return "common/adminRegister";
    }

    @GetMapping("/stRegister.co")
    public String stRegister() {
        //학생 회원가입
        return "student/stRegister";
    }

}
