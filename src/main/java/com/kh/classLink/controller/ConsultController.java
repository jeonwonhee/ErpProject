package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Consult;
import com.kh.classLink.model.vo.ConsultApplication;
import com.kh.classLink.model.vo.DeviceRentAtt;
import com.kh.classLink.service.ConsultService;
import com.kh.classLink.service.FacilityService;
import jakarta.servlet.http.HttpSession;
import oracle.sql.TIMESTAMP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Member;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ConsultController {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private ConsultService consultService;
    /** 강사 상담신청목록 페이지
     * @return
     */
    @GetMapping("/lectureConsult.co")
    public String lectureConsult(@RequestParam(value="cpage", defaultValue="1") int currentPage,HttpSession session,Model model) {

        Map<String, Object> result = consultService.getBoardList(currentPage);
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            loginMember = memberMapper.selectMemberByNo(1);
            session.setAttribute("loginMember", loginMember);
        }

        model.addAttribute("consultApplicationList", result.get("consultApplicationList"));
        model.addAttribute("pi",  result.get("pi"));


        return "lecture/leConsult";
    }

    /** 강사 상담신청 승인/반려 페이지
     * @return
     */
    @GetMapping("/lectureConsultCorrection.co")
    public String lectureConsultCorrection(@RequestParam("consultAppNo") int consultNo,Model model) {
        ConsultApplication consultApplication = consultService.getConsultApplicationById(consultNo);
        model.addAttribute("consultApplication", consultApplication);


        return "lecture/leConsultCorrection";}


    /** 학생 상담신청 페이지
     * @return
     */
    @GetMapping("/stConsult.co")
    public String stConsult(Model model) {
        List<ConsultApplication> consultApplicationList = consultService.getConsultApplication();
        model.addAttribute("consultApplicationList", consultApplicationList);
        return "student/stConsult";}

    @PostMapping("/consult.at")
    public String attendConsult(
            @RequestParam("topic") String topic,
            @RequestParam("date") String date,
            @RequestParam("time") String time,
            @RequestParam("content") String content,
            HttpSession session,
            Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            loginMember = memberMapper.selectMemberByNo(1);
            session.setAttribute("loginMember", loginMember);
        }

        ConsultApplication app = new ConsultApplication();
        app.setConsultAppContent(content);

        // 날짜 + 시간 -> Timestamp
        String fullDateTime = date.trim() + " " + time.trim() + ":00";
        app.setConsultTime(Timestamp.valueOf(fullDateTime));

        app.setStatus("REQUESTED");
        app.setConsultAppMemberNo(loginMember.getMemberNo());

        consultService.insertConsult(app);

        // 모든 상담 내역 조회 후 JSP에 전달
        List<ConsultApplication> consultApplicationList = consultService.getConsultApplication();
        model.addAttribute("consultApplicationList", consultApplicationList);

        return "student/stConsult";
    }

    @PostMapping("/lectureConsultUpdate.co")
    public String lectureConsultUpdate(
            @RequestParam("consultAppNo") int consultAppNo,
            @RequestParam("status") String status,
            @RequestParam(value="refusal", required=false) String refusal,
            HttpSession session
    ) {
        // 서비스 호출
        Member loginMember = (Member) session.getAttribute("loginMember");

        int result = consultService.updateConsultStatus(consultAppNo, status, refusal, loginMember.getMemberNo());
        if(result>0){
            return "redirect:/lectureConsult.co";
        }else{
            return "lecture/leConsultCorrection";
        }
    }

    //상담 해주는 곳
    @PostMapping("/lectureConsultInsert.co")
    public String lectureConsultInsert(
            @RequestParam("consultAppNo") int consultAppNo,
            @RequestParam("content") String content
    ) {
        int result = consultService.insertConsultation(consultAppNo, content);
        if(result>0){
            int re = consultService.updateConsultInsertStatus(consultAppNo);
            if(re>0){
                return "redirect:/lectureConsult.co";
            }else{
                return "lecture/leConsultCorrection";
            }
        }
        return "lecture/leConsultCorrection";
    }

    @GetMapping("/lectureConsultApprove.co")
    public String lectureConsultApprove(@RequestParam("consultAppNo") int consultNo,Model model) {
        ConsultApplication consultApplication = consultService.getConsultApplicationById(consultNo);
        model.addAttribute("consultApplication", consultApplication);

        return "lecture/leConsultApproved";

    }








}
