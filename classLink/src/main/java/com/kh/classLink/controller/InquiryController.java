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
     *
     * @return
     */
    @GetMapping("/inquiryManage.co")
    public String inquiryManage(){
        return "common/inquiryManage";
    }

    /**
     *
     * @return
     */
    @GetMapping("/inquiryDetail.co")
    public String inquiryDetail(){
        return "common/inquiryDetail";
    }

}
