package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.MemberService;
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

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MemberController {

    @Autowired
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
     * 로그인 처리 (역할별 분기)
     */
    @PostMapping("/login.co")
    public ModelAndView login(@RequestParam("memberId") String memberId,
                              @RequestParam("memberPassword") String memberPassword,
                              @RequestParam("role") String role,
                              HttpSession session,
                              ModelAndView mv) {

        // 1. ID와 역할로 회원 조회
        Member loginMember = memberService.getMemberByIdAndRole(memberId, role);

        // 2. ID 또는 역할이 잘못된 경우
        if (loginMember == null) {
            mv.addObject("errorMsg", "아이디 또는 역할이 일치하지 않습니다.");
            mv.setViewName("common/login");
            return mv;
        }

        // 3. 비밀번호 검증
        // if (!bCryptPasswordEncoder.matches(memberPassword, loginMember.getMemberPassword())) {
        if (!memberPassword.equals(loginMember.getMemberPassword())) {
            mv.addObject("errorMsg", "비밀번호를 확인해 주세요.");
            mv.setViewName("common/login");
            return mv;
        }

        // 4. 로그인 성공 - 세션 저장
        session.setAttribute("loginMember", loginMember);
        session.setAttribute("role", role);

        // 5. 역할별 대시보드로 이동
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


        /** 회원가입 페이지 이동 */
        @GetMapping("/stRegister.co")
        public String stRegister() {
            return "student/stRegister"; // JSP 보여주기
        }

        /** 회원가입 실제 처리 */
        @PostMapping("/stRegister.co")
        public String insertStudent(Member member, HttpSession session, Model model) {

            // 기본값 설정 (role/status)
            if (member.getRole() == null || member.getRole().isBlank()) {
                member.setRole("STUDENT");
            }
            if (member.getStatus() == null || member.getStatus().isBlank()) {
                member.setStatus("Y");
            }
            int result = memberService.insertMember(member);
            if (result > 0) {
                session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
                return "redirect:/";
            } else {
                model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
                return "redirect:/";
            }
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

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    @GetMapping("/idDuplicateCheck.co")
    @ResponseBody
    public String idDuplicateCheck(@RequestParam String memberId) {
        System.out.println("memberId:"+memberId);
        int count = memberService.getMemberCountById(memberId);

        return count > 0 ? "NNNNN" : "NNNNY";
    }




}
