package com.kh.classLink.service;

import com.kh.classLink.model.mapper.SatisfactionMapper;
import com.kh.classLink.model.vo.LectureSatisfaction;
import com.kh.classLink.model.vo.Satisfaction;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SatisfactionServiceImpl implements SatisfactionService {

    private final SatisfactionMapper mapper;

    @Override
    public int insertSatisfaction(Satisfaction satisfaction) {
        return mapper.insertSatisfaction(satisfaction);
    }

    @Override
    public int countSatisfactionClass(int classLectureNo) {
        return mapper.countSatisfactionClass(classLectureNo);
    }

    @Override
    public int countTotalSatisfactionClass(int classLectureNo) {
        return mapper.countTotalSatisfactionClass(classLectureNo);
    }

    @Override
    public int getClassLectureNo(int studentNo) {
        return mapper.selectClassLectureNo(studentNo);
    }

    @Override
    public String getClassName(int studentNo) {
        return mapper.selectClassName(studentNo);
    }

    @Override
    public int getStudentNo(int memberNo) {
        return mapper.selectStudentNo(memberNo);
    }

    @Override
    public int checkSubmit(int studentNo) {
        return mapper.checkSubmit(studentNo);
    }

    @Override
    public List<Integer> getLectureClassList(int memberNo) {
        return mapper.selectLectureClassList(memberNo);
    }

    @Override
    public LectureSatisfaction getLectureSatisfaction(int classLectureNo) {
        return mapper.selectLectureSatisfaction(classLectureNo);
    }

    @Override
    public int getCommentCount(int classLectureNo) {
        return mapper.selectCommentCount(classLectureNo);
    }

    @Override
    public List<Satisfaction> getCommentPage(int classLectureNo, int start, int end) {
        Map<String, Object> map = new HashMap<>();
        map.put("classLectureNo", classLectureNo);
        map.put("start", start);
        map.put("end", end);
        return mapper.selectCommentPage(map);
    }

}
