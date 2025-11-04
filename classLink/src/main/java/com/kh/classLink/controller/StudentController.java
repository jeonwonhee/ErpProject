package com.kh.classLink.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
/**
 * 학생 대시보드
 */
public class StudentController {

    @GetMapping("/studentMain.co")
    public String studentMain() {
        //학생 대시보드
        return "student/studentMain";
    }

    @GetMapping("/studentMyPage.co")
    public String studentMyPage() {
        //학생 마이페이지
        return "student/studentMyPage";
    }

    @GetMapping("/studentSatisfication.co")
    public String studentSatisfication() {
        //강의 만족도
        return "student/studentSatisfication";
    }

    @GetMapping("/studentScore.co")
    public String studentScore() {
        //강의 만족도
        return "student/studentScore";
    }
}
