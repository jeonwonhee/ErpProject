package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.ClassAvgScore;
import com.kh.classLink.model.vo.RecentApplication;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TeacherDashboardMapper {

    // 강사 출석률 (도넛 그래프)
    Double getTeacherAttendanceRate(int teacherNo);

    // 반별 평균 성적 (막대 그래프 + 테이블)
    List<ClassAvgScore> getTeacherClassAvgScores(int teacherNo);

    // 최근 신청 리스트
    List<RecentApplication> getRecentApplications(int teacherNo);
}