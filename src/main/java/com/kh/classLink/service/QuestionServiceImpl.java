package com.kh.classLink.service;


import com.kh.classLink.model.mapper.QuestionMapper;

import com.kh.classLink.model.vo.PageInfo;
import com.kh.classLink.model.vo.Question;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionMapper  questionMapper;
    @Autowired
    public QuestionServiceImpl(QuestionMapper questionMapper) {
        this.questionMapper = questionMapper;
    }


    /**
     * 문의 조회
     * @param currentPage
     * @param questionMember
     * @return
     */
    @Override
    public Map<String,Object> selectQuestionList(int currentPage,int questionMember) {
        //추후 권한 추가하여 where절 권한 분기 - 강사 관리자용 따로 만들기
        int questionCnt = questionMapper.selectQuestionCount(questionMember);
        PageInfo pi = new PageInfo(currentPage, questionCnt, 5, 5);
        int offset = (currentPage - 1) * pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Question> list = questionMapper.selectQuestionList(rowBounds);
        Map<String,Object> map = new HashMap<>();
        map.put("list",list);
        map.put("pi",pi);

        return map;
    }

    /**
     * 문의 상세조회
     * @param questionNo
     * @return
     */
    @Override
    public Question selectQuestionByNo(int questionNo) {
        Question question = questionMapper.selectQuestionByNo(questionNo);
        
        return question;
    }

    /**
     * 문의 등록
     * @param question
     * @return
     */
    @Override
    public int insertQuestion(Question question) {
        int result = questionMapper.insertQuestion(question);
        return result;
    }

    /**
     * 문의 답변
     * @param question
     * @return
     */
    @Override
    public int updateQuestion(Question question) {
        int result = questionMapper.updateQuestion(question);
        return result;
    }
}
