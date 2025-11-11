package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.MemberService;
import com.kh.classLink.service.CommuteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

    private final MemberService memberService;
    private final CommuteService commuteService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    public MemberController(MemberService memberService,
                            CommuteService commuteService,
                            BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberService = memberService;
        this.commuteService = commuteService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    /**
     * 로그인 페이지
     */
    @GetMapping("/login.co")
    public String login() {
        return "common/login";
    }

    /**
     * 로그인 처리 (역할별 분기 + 자동 출근 등록)
     */
    @PostMapping("/login.co")
    public ModelAndView login(@RequestParam("memberId") String memberId,
                              @RequestParam("memberPassword") String memberPassword,
                              @RequestParam("role") String role,
                              HttpSession session,
                              ModelAndView mv) {

        // 1. 아이디 + 역할로 회원 조회
        Member loginMember = memberService.getMemberByIdAndRole(memberId, role);

        if (loginMember == null) {
            mv.addObject("errorMsg", "아이디 또는 역할이 일치하지 않습니다.");
            mv.setViewName("common/login");
            return mv;
        }

        // 2. 비밀번호 검증
        if (!bCryptPasswordEncoder.matches(memberPassword, loginMember.getMemberPassword())) {
            mv.addObject("errorMsg", "비밀번호를 확인해 주세요.");
            mv.setViewName("common/login");
            return mv;
        }

        // 3. 세션 저장
        session.setAttribute("loginMember", loginMember);
        session.setAttribute("role", role);

        // 4. 강사/관리자 자동 출근 등록
        if (role.equalsIgnoreCase("TEACHER") || role.equalsIgnoreCase("ADMIN")) {
            commuteService.recordCommuteIn(loginMember.getMemberNo());
        }

        // 5. 역할별 페이지 분기
        switch (role.toUpperCase()) {
            case "STUDENT":
                mv.setViewName("redirect:/stMain.co");
                break;
            case "TEACHER":
                mv.setViewName("redirect:/lectureDashboard");
                break;
            case "ADMIN":
                mv.setViewName("redirect:/adminDashboard.co");
                break;
            default:
                mv.addObject("errorMsg", "잘못된 역할입니다.");
                mv.setViewName("common/login");
        }

        return mv;
    }

    /**
     * 로그아웃
     */
    @GetMapping("/logout.co")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login.co";
    }

    /**
     * 비밀번호 찾기 페이지
     */
    @GetMapping("/findPassword.co")
    public String findPassword() {
        return "common/findPassword";
    }

    /**
     * 비밀번호 변경 페이지
     */
    @GetMapping("/changePassword.co")
    public String changePassword() {
        return "common/changePassword";
    }

    /**
     * 관리자/강사 등록 페이지
     */
    @GetMapping("/adminRegister.co")
    public String adminRegister() {
        return "common/adminRegister";
    }

    /**
     * 학생 회원가입 페이지
     */
    @GetMapping("/stRegister.co")
    public String stRegister() {
        return "student/stRegister";
    }

    /**
     * 학생 회원가입 처리
     */
    @PostMapping("/stRegister.co")
    public String insertStudent(Member member, HttpSession session, Model model) {

        // 기본값 설정
        if (member.getRole() == null || member.getRole().isBlank()) {
            member.setRole("STUDENT");
        }
        if (member.getStatus() == null || member.getStatus().isBlank()) {
            member.setStatus("Y");
        }

        // 비밀번호 암호화
        String pwd = bCryptPasswordEncoder.encode(member.getMemberPassword());
        member.setMemberPassword(pwd);

        int result = memberService.insertMember(member);

        if (result > 0) {
            session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
            return "redirect:/login.co";
        } else {
            model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
            return "student/stRegister";
        }
    }

    /**
     * 일반 회원가입 처리 (관리자/강사용)
     */
    @PostMapping("/insertMember.co")
    public String insertMember(Member member, HttpSession session, Model model) {

        String pwd = bCryptPasswordEncoder.encode(member.getMemberPassword());
        member.setMemberPassword(pwd);

        int result = memberService.insertMember(member);

        if (result > 0) {
            session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
            return "redirect:/login.co";
        } else {
            model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
            return "common/adminRegister";
        }
    }

    /**
     * 아이디 중복 체크
     */
    @GetMapping("/idDuplicateCheck.co")
    @ResponseBody
    public String idDuplicateCheck(@RequestParam String memberId) {
        int count = memberService.getMemberCountById(memberId);
        return count > 0 ? "NNNNN" : "NNNNY";
    }
}
