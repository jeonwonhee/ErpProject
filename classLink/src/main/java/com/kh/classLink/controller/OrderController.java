package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderController {
    /**
     *
     * 신청 컨트롤러
     */

    @GetMapping("/stAtt.co")
    public String stAtt() {
        //츨석 정정
        return "student/stAtt";
    }

    @GetMapping("/stConsult.co")
    public String stConsult() {
        //상담 신청
        return "student/stConsult";
    }

    @GetMapping("/stQuestion.co")
    public String stQuestion() {
        //문의 신청
        return "student/stQuestion";
    }

    @GetMapping("/stQuestionDetail.co")
    public String stQuestionDetail() {
        //문의 신청
        return "student/stQuestionDetail";
    }

    @GetMapping("/stQuestionWrite.co")
    public String stQuestionWrite() {
        //문의 신청
        return "student/stQuestionWrite";
    }
}
