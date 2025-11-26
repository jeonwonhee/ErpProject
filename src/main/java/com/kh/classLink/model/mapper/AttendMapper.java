package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.*;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.PageInfo;
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

    int getStudentCount();

    //관리자 학생 조회
    List<Member> findAllStudentsForAdmin(PageInfo pi);

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

    /*출결정정 요청 리스트*/
    List<AttendUpdate> selectAttendUpdateList(int teacherNo);

    /*출결정정 요청 데이터*/
    AttendUpdate selectAttendUpdateDetail(int attendUpdateNo);

    /*출결정정 승인 반려*/
    int updateAttendCorrect(Map<String, Object> param);
    /**
     * 정정신청 출결 정보
     * @param attendUpdate
     * @return
     */
    AttendUpdate selectOrderAttendInfo(AttendUpdate attendUpdate);

    /**
     * 출결 정정 신청
     * @param attendUpdate
     * @return
     */
    int insertAttendOrder(AttendUpdate attendUpdate);

    /**
     * 정정 신청 리스트
     * @param memberNo
     * @return
     */
    ArrayList<AttendUpdate> selectAttendOrderList(int memberNo);

    /**
     * 출결 정정 신청 파일 저장
     * @param attendUpdateFile
     * @return
     */
    int insertAttendFile(AttendUpdatefile attendUpdateFile);

    /**
     * 알람 발행용 멤버 넘버 조회
     * @param attendUpdateNo
     * @return
     */
    int selectAttendOrderMemberNo(int attendUpdateNo);

}
