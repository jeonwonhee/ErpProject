package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.NotificationService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class NotificationController {

    private NotificationService notificationService;
    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    /**
     * 안 읽은 알람 조회
     * @param model
     * @param session
     * @return
     */
    @GetMapping("/selectNotiToMember.nt")
    @ResponseBody
    public Map<String,Object> selectNotiToMember(Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memberNo = loginMember.getMemberNo();
        Map<String, Object> map = notificationService.selectNotiToMember(memberNo);

        return map;

    }

}
