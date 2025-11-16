package com.kh.classLink.service;

import com.kh.classLink.model.vo.LectureSatisfaction;
import com.kh.classLink.model.vo.Satisfaction;

import java.util.List;

public interface SatisfactionService {

    int insertSatisfaction(Satisfaction satisfaction);

    int countSatisfactionClass(int classLectureNo);

    int countTotalSatisfactionClass(int classLectureNo);

    List<Integer> getStudentLectureList(int studentNo);

    String getClassName(int studentNo);

    int getStudentNo(int memberNo);

    int checkSatisfactionSubmit(int studentNo, int classLectureNo);

    List<Integer> getLectureClassList(int memberNo);

    LectureSatisfaction getLectureSatisfaction(int classLectureNo);

    int getCommentCount(int classLectureNo);

    List<Satisfaction> getCommentPage(int classLectureNo, int start, int end);

    String getLectureName(int classLectureNo);

}