package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GradeController {

    /** 강사 성적입력 페이지
     * @return
     */
    @GetMapping("/leGrade.co")
    public String lectureGradeCheck() {return "lecture/leGradeCheck";}

    @GetMapping("/stScore.co")
    public String stScore() {
        //학생 성적 조회
        return "student/stScore";
    }

}
