package com.kh.classLink.model.mapper;


import com.kh.classLink.model.vo.Question;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;


import java.util.ArrayList;


@Mapper
public interface QuestionMapper {

    /**
     * 문의 조회
     * @param rowBounds
     * @return
     */
    ArrayList<Question> selectQuestionList(RowBounds rowBounds, int questionMember);

    /**
     * 답변 필요 문의
     * @param rowBounds
     * @return
     */
    ArrayList<Question> selectAnswerList(RowBounds rowBounds,int questionMember, String listType);

    /**
     * 문의 갯수 조회
     * @param questionMember
     * @return
     */
    int selectQuestionCount(int questionMember);

    /**
     * 답변 필요 문의 갯수
     * @return
     */
    int selectAnswerCount(int questionMember,String listType);

    /**
     * 문의 상세조회
     * @param questionNo
     * @return
     */
    Question selectQuestionByNo(int questionNo);

    /**
     * 문의 등록
     * @param question
     * @return
     */
    int insertQuestion(Question question);

    /**
     * 문의 답변
     * @param question
     * @return
     */
    int updateQuestion(Question question);
}
