package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ConsultController {
    /** 강사 상담신청목록 페이지
     * @return
     */
    @GetMapping("/lectureConsult.co")
    public String lectureConsult() {
        return "lecture/leConsult";
    }

    /** 강사 상담신청 승인/반려 페이지
     * @return
     */
    @GetMapping("/lectureConsultCorrection.co")
    public String lectureConsultCorrection() {return "lecture/leConsultCorrection";}


    /** 학생 상담신청 페이지
     * @return
     */
    @GetMapping("/stConsult.co")
    public String stConsult() {return "student/stConsult";}


}
