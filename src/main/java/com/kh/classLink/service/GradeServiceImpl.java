package com.kh.classLink.service;

import com.kh.classLink.model.mapper.GradeMapper;
import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Override
    public int findClassLectureNo(int classNo, int lectureNo) {
        return gradeMapper.selectClassLectureNo(classNo, lectureNo);
    }

    @Override
    public List<GradeDto> findGradesByStudentAndLecture(int studentNo, int lectureNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("studentNo", studentNo);
        param.put("lectureNo", lectureNo);
        return gradeMapper.findGradesByStudentAndLecture(param);
    }

    @Override
    public List<GradeDto> searchGradesForEdit(int classNo, String keyword, int lectureNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("classNo", classNo);
        param.put("keyword", keyword);
        param.put("lectureNo", lectureNo);

        return gradeMapper.searchGradesForEdit(param);
    }
    @Override
    public void insertGrades(List<GradeDto> gradeList) {
        for (GradeDto dto : gradeList) {
            gradeMapper.insertGrade(dto);
        }
    }
    @Override
    public List<String> findTestNamesByStudent(int memberNo){
        return gradeMapper.findTestNamesByStudent(memberNo);
    }

    @Override
    public int updateGrade(GradeDto gradeDto) {
        return gradeMapper.updateGrade(gradeDto);
    }
}
