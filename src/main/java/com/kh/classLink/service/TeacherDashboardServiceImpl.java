package com.kh.classLink.service;

import com.kh.classLink.model.mapper.TeacherDashboardMapper;
import com.kh.classLink.model.vo.ClassAvgScore;
import com.kh.classLink.model.vo.RecentApplication;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeacherDashboardServiceImpl implements TeacherDashboardService {

    private final TeacherDashboardMapper teacherDashboardMapper;

    public TeacherDashboardServiceImpl(TeacherDashboardMapper teacherDashboardMapper) {
        this.teacherDashboardMapper = teacherDashboardMapper;
    }

    @Override
    public double getTeacherAttendanceRate(int teacherNo) {
        Double rate = teacherDashboardMapper.getTeacherAttendanceRate(teacherNo);
        return (rate == null) ? 0.0 : rate;
    }

    @Override
    public List<ClassAvgScore> getTeacherClassAvgScores(int teacherNo) {
        List<ClassAvgScore> list = teacherDashboardMapper.getTeacherClassAvgScores(teacherNo);
        return (list == null) ? List.of() : list;
    }

    @Override
    public List<RecentApplication> getRecentApplications(int teacherNo) {
        List<RecentApplication> list = teacherDashboardMapper.getRecentApplications(teacherNo);
        return (list == null) ? List.of() : list;
    }
}