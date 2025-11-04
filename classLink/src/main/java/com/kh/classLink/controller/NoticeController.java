package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Notice;
import com.kh.classLink.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class NoticeController {

    private final NoticeService noticeService;

    @Autowired
    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }


    /**
     * 공지사항 이동
     * @return
     */
    @GetMapping("/notice.co")
    public String notice() {
        //리스트 조회 필요

        return "common/notice";
    }

    /**
     * 공지사항 상세보기
     * @return
     */
    @GetMapping("/noticeDetail.co")
    public String noticeDetail() {
        return "common/noticeDetail";
    }

    /**
     * 공지사항 입력
     * @return
     */
    @GetMapping("/noticeEnrollForm.co")
    public String noticeEnrollForm() {
        return "common/noticeEnrollForm";
    }

    /**
     * 공지사항 수정
     * @return
     */
    @GetMapping("/noticeUpdateForm.co")
    public String noticeUpdateForm() {
        return "common/noticeUpdateForm";
    }



}
