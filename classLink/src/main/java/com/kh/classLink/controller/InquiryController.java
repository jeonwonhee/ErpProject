package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InquiryController {


    /**
     *
     * @return
     */
    @GetMapping("/inquiryPopUp.co")
    public String inquiryPopUp(){
        return "common/inquiryPopUp";
    }

    /**
     * 문의 관리
     * @return
     */
    @GetMapping("/inquiryManage.co")
    public String inquiryManage(){
        return "common/inquiryManage";
    }

    /**
     * 문의 상세보기
     * @return
     */
    @GetMapping("/inquiryDetail.co")
    public String inquiryDetail(){
        return "common/inquiryDetail";
    }


    /**
     * 문의 답변
     * @return
     */
    @GetMapping("/inquiryEnrollForm.co")
    public String inquiryEnrollForm(){
        return "common/inquiryEnrollForm";
    }

}
