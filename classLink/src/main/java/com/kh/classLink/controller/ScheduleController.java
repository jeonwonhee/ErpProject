package com.kh.classLink.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ScheduleController {

    /**
     *
     * 일정 컨트롤러
     */

    @GetMapping("/stLectureDate.co")
    public String stLectureDate() {
        //학생 일정조회
        return "student/stLectureDate";
    }
}
