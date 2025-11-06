package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class QuestionController {

    /**
     * 문의 관리
     * @return
     */
    @GetMapping("/questionManage.co")
    public String questionManage(){
        return "common/questionManage";
    }

    /**
     * 문의 상세보기
     * @return
     */
    @GetMapping("/questionDetail.co")
    public String questionDetail(){
        return "common/questionDetail";
    }


    /**
     * 문의 답변
     * @return
     */
    @GetMapping("/questionEnrollForm.co")
    public String questionEnrollForm(){
        return "common/questionEnrollForm";
    }

}
