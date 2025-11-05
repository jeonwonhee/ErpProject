package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
/**
 * 학생 대시보드
 */
public class StudentController {

    @GetMapping("/stMain.co")
    public String stMain() {
        //학생 대시보드
        return "student/stMain";
    }

    @GetMapping("/stMyPage.co")
    public String stMyPage() {
        //학생 마이페이지
        return "student/stMyPage";
    }

    @GetMapping("/stSatisfication.co")
    public String stSatisfication() {
        //강의 만족도
        return "student/stSatisfication";
    }

    @GetMapping("/stScore.co")
    public String stScore() {
        //학생 성적 조회
        return "student/stScore";
    }

    @GetMapping("/stRegister.co")
    public String stRegister() {
        //학생 회원가입
        return "student/stRegister";
    }

    @GetMapping("/stFacility.co")
    public String stFacility() {
        //학생 기자재
        return "student/stFacility";
    }
}
