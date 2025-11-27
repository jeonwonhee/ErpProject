package com.kh.classLink.service;

import com.kh.classLink.model.vo.ClassAvgScore;
import com.kh.classLink.model.vo.RecentApplication;

import java.util.List;

public interface TeacherDashboardService {

    double getTeacherAttendanceRate(int teacherNo);

    List<ClassAvgScore> getTeacherClassAvgScores(int teacherNo);

    List<RecentApplication> getRecentApplications(int teacherNo);
}
