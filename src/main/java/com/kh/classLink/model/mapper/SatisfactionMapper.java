package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.LectureSatisfaction;
import com.kh.classLink.model.vo.Satisfaction;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface SatisfactionMapper {

    int insertSatisfaction(Satisfaction satisfaction);

    int countSatisfactionClass(int classLectureNo);

    int countTotalSatisfactionClass(int classLectureNo);

    int selectClassLectureNo(int studentNo);

    String selectClassName(int studentNo);

    int selectStudentNo(int memberNo);

    int checkSubmit(int studentNo);

    List<Integer> selectLectureClassList(int memberNo);

    LectureSatisfaction selectLectureSatisfaction(int classLectureNo);

    int selectCommentCount(int classLectureNo);

    List<Satisfaction> selectCommentPage(Map<String, Object> map);
}
