package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {

    private final MemberService memberService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public MemberController(MemberService memberService, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberService = memberService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    /**
     * 로그인
     * @return
     */
    @GetMapping("/login.co")
    public String login() {
        return "common/login";
    }

    /**
     * 비밀번호 찾기
     * @return
     */
    @GetMapping("/findPassword.co")
    public String findPassword() {
        return "common/findPassword";
    }

    /**
     * 비밀번호 변경
     * @return
     */
    @GetMapping("/changePassword.co")
    public String changePassword() {
        return "common/changePassword";
    }

    /** 관리자/강사 생성
     * @return
             */
    @GetMapping("/adminRegister.co")
    public String adminRegister(){
        return "common/adminRegister";
    }

    @GetMapping("/stRegister.co")
    public String stRegister() {
        //학생 회원가입
        return "student/stRegister";
    }

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    @GetMapping("/idDupiCheck.co")
    @ResponseBody
    public String idDupiCheck(@RequestParam String memberId) {
        System.out.println("memberId:"+memberId);
        int count = memberService.getMemberCountById(memberId);

        return count > 0 ? "NNNNN" : "NNNNY";
    }

    /**
     * 회원 가입
     * @param member
     * @param session
     * @param model
     * @return
     */
    @PostMapping("/insertMember.co")
    public String  insertMember(Member member, HttpSession session, Model model) {

        String pwd = bCryptPasswordEncoder.encode(member.getMemberPassword());
        member.setMemberPassword(pwd);

        int result = memberService.insertMember(member);

        if (result > 0) {
            session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
            return "redirect:/";
        }

    }


}
