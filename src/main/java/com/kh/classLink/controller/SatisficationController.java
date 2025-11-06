package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SatisficationController {

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leGraph.co")
    public String lectureGraph() {return "lecture/leGraph";}

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leFeedback.co")
    public String lectureFeedback() {return "lecture/leFeedback";}

    @GetMapping("/stSatisfication.co")
    public String stSatisfication() {
        //강의 만족도
        return "student/stSatisfication";
    }

}
