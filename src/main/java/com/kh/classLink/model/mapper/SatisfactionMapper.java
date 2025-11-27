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

    Integer selectStudentNo(int memberNo);

    String selectClassName(int studentNo);

    List<Map<String, Object>> selectStudentLectureList(int studentNo);

    int checkSatisfactionSubmit(Map<String, Object> map);

    List<Integer> selectLectureClassList(int memberNo);

    LectureSatisfaction selectLectureSatisfaction(int classLectureNo);

    int selectCommentCount(int classLectureNo);

    List<Satisfaction> selectCommentPage(Map<String, Object> map);

    String selectLectureName(int classLectureNo);
}
