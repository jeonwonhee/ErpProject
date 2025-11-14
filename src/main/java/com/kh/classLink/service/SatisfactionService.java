package com.kh.classLink.service;

import com.kh.classLink.model.vo.LectureSatisfaction;
import com.kh.classLink.model.vo.Satisfaction;

import java.util.List;

public interface SatisfactionService {

    int insertSatisfaction(Satisfaction satisfaction);

    int countSatisfactionClass(int classLectureNo);

    int countTotalSatisfactionClass(int classLectureNo);

    int getClassLectureNo(int studentNo);

    String getClassName(int studentNo);

    int getStudentNo(int memberNo);

    int checkSubmit(int studentNo);

    List<Integer> getLectureClassList(int memberNo);

    LectureSatisfaction getLectureSatisfaction(int classLectureNo);

    int getCommentCount(int classLectureNo);

    List<Satisfaction> getCommentPage(int classLectureNo, int start, int end);

}
