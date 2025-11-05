package com.kh.classLink.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class OrderController {
    /**
     *
     * 신청 컨트롤러
     */

    @GetMapping("/studentAtt.co")
    public String studentAtt() {
        //츨석 정정
        return "student/studentAtt";
    }

    @GetMapping("/stConsult.co")
    public String stConsult() {
        //상담 신청
        return "student/stConsult";
    }

    @GetMapping("/studentInquiry.co")
    public String studentInquiry() {
        //문의 신청
        return "student/studentInquiry";
    }

    @GetMapping("/studentInquiryDetail.co")
    public String studentInquiryDetail() {
        //문의 신청
        return "student/studentInquiryDetail";
    }

    @GetMapping("/studentInquiryWrite.co")
    public String studentInquiryWrite() {
        //문의 신청
        return "student/studentInquiryWrite";
    }
}
