package com.kh.classLink.service;

import com.kh.classLink.model.mapper.GradeMapper;
import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GradeServiceImpl implements GradeService {
    private final GradeMapper gradeMapper;

    @Override
    public List<Lecture> findLecturesByStudent(int memberNo) {
        return gradeMapper.findLecturesByStudent(memberNo);
    }

    @Override
    public List<GradeDto> findLatestGrades(int memberNo, int lectureNo, int limit) {
        return gradeMapper.findLatestGrades(memberNo, lectureNo, limit);
    }
}
