package com.kh.classLink.controller;

import com.kh.classLink.model.vo.PageInfo;
import com.kh.classLink.model.vo.Question;
import com.kh.classLink.service.QuestionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
public class QuestionController {

    private QuestionService questionService;
    @Autowired
    public void setQuestionService(QuestionService questionService) {
        this.questionService = questionService;
    }

    /**
     * 문의 목록
     * @return
     */
    @GetMapping("/questionManage.co")
    public String questionManage(){
        return "common/questionManage";
    }


    /**
     * 학생 문의 페이지
     * @param currentPage
     * @param model
     * @return
     */
    @GetMapping("/stQuestion.co")
    public String stQuestion(@RequestParam(value = "currentPage",defaultValue = "1") int currentPage,Model model) {
        int memberNo = 6;
        Map<String, Object> map = questionService.selectQuestionList(currentPage,memberNo);

        model.addAttribute("questionList",map.get("list"));
        model.addAttribute("pi",map.get("pi"));
        //학생 문의 신청
        return "student/stQuestion";
    }


    /**
     * 문의 상세조회
     * @param questionNo
     * @param model
     * @return
     */
    @GetMapping("/stQuestionDetail.co")
    public String stQuestionDetail(@RequestParam(value="questionNo") int questionNo,Model model) {
        Question question = questionService.selectQuestionByNo(questionNo);

        if (question != null) {
            model.addAttribute("question",question);
            return "student/stQuestionDetail";
        } else {
            
            return "student/stQuestionDetail";
        }

    }

    /**
     * 문의 상세보기
     * @return
     */
    @GetMapping("/questionDetail.co")
    public String questionDetail(){
        return "common/questionDetail";
    }

    @GetMapping("/stQuestionWrite.co")
    public String stQuestionWrite() {
        //문의 신청 글쓰기
        return "student/stQuestionWrite";
    }

    /**
     * 문의 답변
     * @return
     */
    @GetMapping("/questionEnrollForm.co")
    public String questionEnrollForm(){
        return "common/questionEnrollForm";
    }


    /**
     * 문의 등록
     * @param question
     * @param session
     * @param model
     * @return
     */
    @PostMapping("/insertQuestion.qu")
    public String insertQuestion(Question question , HttpSession session, Model model){
        //추후 로그인 완성시 세션으로 불러오기
        question.setQuestionMember(6);
        int result = questionService.insertQuestion(question);

        if (result > 0) {
            session.setAttribute("alertMsg", "문의 등록에 성공하였습니다.");
            return "redirect:/stQuestion.co";
        } else {
            model.addAttribute("errorMsg", "문의 등록에 실패하였습니다.");
            return "redirect:/stQuestion.co";
        }

    }

}
