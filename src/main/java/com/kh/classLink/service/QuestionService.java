package com.kh.classLink.service;


import com.kh.classLink.model.vo.Question;
import org.apache.ibatis.session.RowBounds;


import java.util.ArrayList;
import java.util.Map;


public interface QuestionService {

    /**
     * 문의 조회
     * @param currentPage
     * @return
     */
    public Map<String,Object> selectQuestionList(int currentPage, int questionMember);

    /**
     * 문의 상세조회
     * @param questionNo
     * @return
     */
    public Question selectQuestionByNo(int questionNo);

    /**
     * 문의 등록
     * @param question
     * @return
     */
    public int insertQuestion(Question question);

    /**
     * 문의 답변
     * @param question
     * @return
     */
    public int updateQuestion(Question question);
    
}
