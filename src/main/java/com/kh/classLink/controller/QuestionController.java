package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class QuestionController {

    /**
     * 문의 목록
     * @return
     */
    @GetMapping("/questionManage.co")
    public String questionManage(){
        return "common/questionManage";
    }
    

    @GetMapping("/stQuestion.co")
    public String stQuestion() {
        //학생 문의 신청
        return "student/stQuestion";
    }

    @GetMapping("/stQuestionDetail.co")
    public String stQuestionDetail() {
        //문의 신청 디테일
        return "student/stQuestionDetail";
    }

    /**
     * 문의 상세보기
     * @return
     */
    @GetMapping("/questionDetail.co")
    public String questionDetail(){
        return "common/questionDetail";
    }

    @GetMapping("/stQuestionWrite.co")
    public String stQuestionWrite() {
        //문의 신청 글쓰기
        return "student/stQuestionWrite";
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
