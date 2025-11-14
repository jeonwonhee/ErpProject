package com.kh.classLink.controller;

import com.kh.classLink.model.vo.LectureSatisfaction;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.Satisfaction;
import com.kh.classLink.service.SatisfactionService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class SatisficationController {

    private final SatisfactionService satisfactionService;

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leGraph.co")
    public String lectureGraph(@RequestParam("lectureGraphNo") int classLectureNo,
                               @RequestParam(defaultValue = "1") int page,
                               Model model) {
        LectureSatisfaction data = satisfactionService.getLectureSatisfaction(classLectureNo);

        double classRating = data.getAvgClassRating();
        data.setAvgClassRating(Math.round(classRating * 10) / 10.0);

        double lectureRating = data.getAvgLectureRating();
        data.setAvgLectureRating(Math.round(lectureRating * 10) / 10.0);

        model.addAttribute("lectureData", data);

        int limit = 5;
        int start = (page - 1) * limit + 1;
        int end = page * limit;

        int total = satisfactionService.getCommentCount(classLectureNo);
        int maxPage = (int) Math.ceil((double) total / limit);

        List<Satisfaction> commentList = satisfactionService.getCommentPage(classLectureNo, start, end);

        model.addAttribute("commentList", commentList);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);

        return "lecture/leGraph";
    }

    /* 학생 의견 AJAX */
    @GetMapping("/ajax/comments")
    @ResponseBody
    public Map<String, Object> ajaxComments(
            @RequestParam int classLectureNo,
            @RequestParam(defaultValue = "1") int page) {

        int limit = 5;
        int start = (page - 1) * limit + 1;
        int end = page * limit;

        int total = satisfactionService.getCommentCount(classLectureNo);
        int maxPage = (int) Math.ceil((double) total / limit);

        List<Satisfaction> commentList = satisfactionService.getCommentPage(classLectureNo, start, end);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("page", page);
        map.put("maxPage", maxPage);

        return map; // JSON 자동 변환
    }

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leFeedback.co")
    public String lectureFeedback(HttpSession session, Model model) {

        Member login = (Member) session.getAttribute("loginMember");
        int memberNo = login.getMemberNo();

        List<Integer> classList = satisfactionService.getLectureClassList(memberNo);

        List<LectureSatisfaction> result = new ArrayList<>();

        for (int classLectureNo : classList) {
            LectureSatisfaction data = satisfactionService.getLectureSatisfaction(classLectureNo);

            double classRating = data.getAvgClassRating();
            data.setAvgClassRating(Math.round(classRating * 10) / 10.0);

            double lectureRating = data.getAvgLectureRating();
            data.setAvgLectureRating(Math.round(lectureRating * 10) / 10.0);

            result.add(data);
        }

        model.addAttribute("lectureList", result);

        return "lecture/leFeedback";
    }

    @GetMapping("/stSatisfication.co")
    public String stSatisfication(HttpSession session, Model model) {
        //강의 만족도
        Member login = (Member) session.getAttribute("loginMember");

        if (login == null) {
            return "redirect:/login.co";
        }

        int memberNo = login.getMemberNo();
        int studentNo = satisfactionService.getStudentNo(memberNo);
        int classLectureNo = satisfactionService.getClassLectureNo(studentNo);

        int already = satisfactionService.checkSubmit(studentNo);

        if (already > 0) {
            model.addAttribute("already", true);
        }

        String className = satisfactionService.getClassName(studentNo);
        model.addAttribute("className", className);

        // 제출 인원 수/전체 인원 수도 필요하면 추가
        int submitted = satisfactionService.countSatisfactionClass(classLectureNo);
        int total = satisfactionService.countTotalSatisfactionClass(classLectureNo);

        model.addAttribute("submittedCount", submitted);
        model.addAttribute("totalCount", total);

        return "student/stSatisfication";
    }

    @PostMapping("/stSatisfactionInsert.co")
    public String insertSatisfication(
            @RequestParam int classRating,
            @RequestParam int lectureRating,
            @RequestParam String suggestion,
            HttpSession session) {

        Member login = (Member) session.getAttribute("loginMember");

        int studentNo = satisfactionService.getStudentNo(login.getMemberNo());
        int classLectureNo = satisfactionService.getClassLectureNo(studentNo);

        // 중복 제출 방지
        if (satisfactionService.checkSubmit(studentNo) > 0) {
            session.setAttribute("alertMsg", "이미 만족도 조사를 제출했습니다.");
            return "redirect:/stSatisfication.co";
        }

        Satisfaction sat = new Satisfaction();
        sat.setClassRating(classRating);
        sat.setLectureRating(lectureRating);
        sat.setSuggestion(suggestion);
        sat.setEndDate(new Date(System.currentTimeMillis()));
        sat.setStudentNo(studentNo);
        sat.setClassLectureNo(classLectureNo);

        satisfactionService.insertSatisfaction(sat);

        session.setAttribute("alertMsg", "만족도 제출 완료!");

        return "redirect:/stSatisfication.co";
    }

}
