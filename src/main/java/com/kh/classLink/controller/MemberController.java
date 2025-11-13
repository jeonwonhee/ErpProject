package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.ClassService;
import com.kh.classLink.service.MemberService;
import com.kh.classLink.service.CommuteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
public class MemberController {

    private final MemberService memberService;
    private final CommuteService commuteService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final ClassService classService;


    @Autowired
    public MemberController(MemberService memberService,
                            CommuteService commuteService,
                            BCryptPasswordEncoder bCryptPasswordEncoder,
                            ClassService classService) {

        this.memberService = memberService;
        this.commuteService = commuteService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.classService = classService;
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

        // 1. ID와 역할로 회원 조회

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

    @GetMapping("/stMyPage.co")
    public String stMyPage(HttpSession session, Model model) {
        // 1) 세션에서 로그인 회원 정보 가져오기
        Member sessionMember = (Member) session.getAttribute("loginMember");

        // 2) 로그인 안 되어 있으면 로그인 페이지로
        if (sessionMember == null) {
            return "redirect:/login.co";
        }

        // 3) DB에서 최신 회원 정보(수강반 조인 포함) 다시 조회
        Member fresh = memberService.getMemberById(sessionMember.getMemberId());

        // 4) 세션도 최신 정보로 덮어쓰기
        session.setAttribute("loginMember", fresh);

        // 5) JSP에서 ${loginMember} 바로 쓰고 싶으면 모델에도 넣어주기
        model.addAttribute("loginMember", fresh);

        // 6) 마이페이지 JSP로 이동
        return "student/stMyPage";
    }
    //정보 수정
    /**
<<<<<<< Updated upstream
     * 비밀번호 변경 페이지
=======
     * 학생 정보 수정 (이메일, 전화번호만 수정)
>>>>>>> Stashed changes
     */
    @PostMapping("/stMyPage.co")
    public String updateInfo(@ModelAttribute Member member,
                                   HttpSession session,
                                   RedirectAttributes ra) {

        // 세션에서 현재 로그인한 회원 정보 가져오기
        Member loginMember = (Member) session.getAttribute("loginMember");

        // 로그인 정보가 없으면 로그인 페이지로 이동
        if (loginMember == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            ra.addFlashAttribute("alertType", "warn");
            return "redirect:/login.co";
        }

        member.setMemberNo(loginMember.getMemberNo());

        int result = memberService.updateInfo(member);

        if (result > 0) {
            // DB에서 최신 정보 재조회(수강반 조인 포함된 쿼리로!)
            Member fresh = memberService.getMemberById(loginMember.getMemberId());
            session.setAttribute("loginMember", fresh);

            ra.addFlashAttribute("alertMsg", "회원 정보가 성공적으로 수정되었습니다.");
            ra.addFlashAttribute("alertType", "success");
        } else {
            ra.addFlashAttribute("alertMsg", "회원 정보 수정에 실패했습니다.");
            ra.addFlashAttribute("alertType", "error");
        }

        return "redirect:/stMyPage.co";

    }

    //비밀번호 변경
   @GetMapping("/changePassword.co")
   public String changePasswordPage() {
       return "common/changePassword"; // JSP 경로
}
    // 실제 변경 처리
    @PostMapping("/changePassword.co")
    public String changePassword(@RequestParam("newPw") String newPw,
                                 @RequestParam("confirmPw") String confirmPw,
                                 @RequestParam("role") String role, // 탭에서 hidden으로 넘어옴
                                 HttpSession session,
                                 RedirectAttributes ra) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        String sessionRole = (String) session.getAttribute("role"); // 로그인 시 세션에 저장했던 역할

        if (loginMember == null || sessionRole == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용하세요.");
            ra.addFlashAttribute("alertType", "error");
            return "redirect:/login.co";
        }

        if (!newPw.equals(confirmPw)) {
            ra.addFlashAttribute("alertMsg", "비밀번호가 서로 일치하지 않습니다.");
            ra.addFlashAttribute("alertType", "error");
            return "redirect:/changePassword.co";
        }

        // BCrypt 해시
        String encoded = bCryptPasswordEncoder.encode(newPw);

        int result = memberService.updatePassword(loginMember.getMemberNo(), encoded);

        if (result > 0) {
            // 세션 객체 갱신(선택)
            loginMember.setMemberPassword(encoded);
            session.setAttribute("loginMember", loginMember);

            ra.addFlashAttribute("alertMsg", "변경이 완료되었습니다.");
            ra.addFlashAttribute("alertType", "success");

            // 역할별 대시보드 이동
            switch (role.toUpperCase()) {
                case "TEACHER": return "redirect:/lectureDashboard.co";
                case "ADMIN":   return "redirect:/adminDashboard.co";
                default:        return "redirect:/stMain.co";
            }
        } else {
            ra.addFlashAttribute("alertMsg", "변경에 실패했습니다. 잠시 후 다시 시도해 주세요.");
            return "redirect:/changePassword.co";
        }
    }

    @PostMapping("/delete.co")
    public String deleteMember(@RequestParam("memberPassword") String memberPassword,
                               HttpSession session,
                               RedirectAttributes ra) {

        Member sessionMember = (Member) session.getAttribute("loginMember");
        if (sessionMember == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용하세요.");
            return "redirect:/login.co";
        }

        // 1) 최신 회원정보 조회 (아이디로 조회 유지)
        Member fresh = memberService.getMemberById(sessionMember.getMemberId());
        if (fresh == null) {
            ra.addFlashAttribute("alertMsg", "계정을 찾을 수 없습니다.");
            session.invalidate();
            return "redirect:/login.co";
        }

        // 2) 비밀번호 검증 (BCrypt)
        if (!bCryptPasswordEncoder.matches(memberPassword, fresh.getMemberPassword())) {
            ra.addFlashAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
            return "redirect:/stMyPage.co";
        }

        try {
            int updated = memberService.deleteMember(fresh.getMemberNo());
            if (updated < 1) {
                ra.addFlashAttribute("alertMsg", "탈퇴 처리에 실패했습니다. 다시 시도해주세요.");
                return "redirect:/stMyPage.co";
            }
        } catch (DataIntegrityViolationException e) {
            ra.addFlashAttribute("alertMsg", "연결된 데이터가 있어 삭제할 수 없습니다. 관리자에게 문의하세요.");
            return "redirect:/stMyPage.co";
        }

        // 4) 세션 종료 후 완료 안내
        session.invalidate();
        ra.addFlashAttribute("alertMsg", "회원 탈퇴가 완료되었습니다.");
        ra.addFlashAttribute("alertType", "success");
        return "redirect:/login.co";
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

    public String stRegister(Model model) {

        // DB에서 수강반 목록 조회
        List<Class> classList = classService.selectClassList();

        System.out.println("🚀 classList size = " + classList.size());
        System.out.println("🚀 classList = " + classList);

        model.addAttribute("classList", classList);

        return "student/stRegister";
    }

    /**
     * 학생 회원가입 처리
     */
    @PostMapping("/stRegister.co")
        // 기본값 설정
    public String insertStudent(Member member,
                                @RequestParam("classNo") Integer classNo,
                                HttpSession session,
                                RedirectAttributes ra,
                                Model model) {

        if (member.getRole() == null || member.getRole().isBlank()) {
            member.setRole("STUDENT");
        }
        if (member.getStatus() == null || member.getStatus().isBlank()) {
            member.setStatus("Y");
        }

        member.setClassNo(classNo);

        // 비밀번호 암호화
        String pwd = bCryptPasswordEncoder.encode(member.getMemberPassword());
        member.setMemberPassword(pwd);

        int result = memberService.insertMember(member);

        if (result > 0) {
            ra.addFlashAttribute("alertMsg", "회원가입에 성공하였습니다.");
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
