package com.kh.classLink.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

//    @PostMapping("/consult.at")
//    public String attendConsult(
//            @RequestParam("topic") String topic,
//            @RequestParam("date") String date,
//            @RequestParam("time") String time,
//            @RequestParam("content") String content,
//            HttpSession session,
//            Model model) {
//
//        // 세션에서 로그인 학생 정보 가져오기
//        Member loginMember = (Member) session.getAttribute("loginMember");
//        if (loginMember == null) {
//            // 로그인 안 되어 있으면 로그인 페이지로
//            return "redirect:/login";
//        }
//
//        // 상담 객체 생성
//        Consult consult = new Consult();
//        consult.setMemberNo(loginMember.getMemberNo()); // 신청 학생 번호
//        consult.setTopic(topic);
//        consult.setDate(date);
//        consult.setTime(time);
//        consult.setContent(content);
//
//        // DB에 저장 (service 호출)
//        consultService.insertConsult(consult);
//
//        // 완료 후 확인 페이지로 이동 또는 다시 신청 페이지
//        model.addAttribute("message", "상담 신청이 완료되었습니다.");
//        return "student/attendConsult"; // JSP 경로
//    }


}
