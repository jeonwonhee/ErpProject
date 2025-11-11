package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface AttendMapper {

    /**
     * 직원수 체크
     * @return
     */
    int selectEmpCount();

    /**
     * 직원 관리 조회
     * @param rowBounds
     * @return
     */
    ArrayList<Member> selectEmpList(RowBounds rowBounds);

    /**
     * 금일 내 수업을 듣는 반 리스트
     * @param memberNo
     * @return
     */
    ArrayList<Class> selectTodayLectureClass(int memberNo);

    /**
     * 선택한 반 정보
     * @param classNo
     * @return
     */
    ArrayList<Class> selectClassInfo(int classNo);

    /**
     * 선택한 반의 학생 정보
     * @param classNo
     * @return
     */
    ArrayList<Attend> selectAttendStudentList(int classNo);

    /**
     * 학생 출석 처리
     * @param attend
     * @return
     */
    int studentAttendMan(Attend attend);

    /**
     * 출석 일괄 처리
     * @param attendClassAllList
     * @return
     */
    int attendClassAll(List<Map<String,Object>> attendClassAllList);

    /**
     * 전체 학생 이번주 출결 데이터
     * @param attend
     * @return
     */
    ArrayList<Attend> selectStWeekAttendData(Attend attend);

    /**
     * 전체 학생 전체 출결 데이터
     * @param attend
     * @return
     */
    ArrayList<Attend> selectStAllAttendData(Attend attend);

    /**
     * 전체 학생 월 별 출결 데이터
     * @param attend
     * @return
     */
    ArrayList<Attend> selectStMonthAttendData(Attend attend);

}
