package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Lecture;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.GradeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class GradeController {

    private GradeService gradeService;
    /** 강사 성적입력 페이지
     * @return
     */
    @GetMapping("/leGrade.co")
    public String lectureGradeCheck() {return "lecture/leGradeCheck";}


    @GetMapping("/stScore.co")
    public String stScore(HttpSession session, Model model) {
             //학생 성적 조회
            Member login = (Member) session.getAttribute("loginMember");
            if (login == null) return "redirect:/login.co";

            // 성적이 있는 과목(강의) 목록
            List<Lecture> subjectList = gradeService.findLecturesByStudent(login.getMemberNo());
            model.addAttribute("subjectList", subjectList);

            return "student/stScore";
        }

}
