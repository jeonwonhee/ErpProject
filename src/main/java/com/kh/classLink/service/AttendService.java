package com.kh.classLink.service;

import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface AttendService {

    /**
     * 관리자 직원 조회
     * @param currentPage
     * @return
     */
    Map<String,Object> selectEmpList(int currentPage);

    /**
     * 금일 내 수업을 듣는 반 리스트
     * @param memberNo
     * @return
     */
    ArrayList<Class> selectTodayLectureClass(int memberNo);


    /**
     * 선택한 반과 학생 리스트
     * @param classNo
     * @return
     */
    Map<String,Object> selectAttendInfo(int classNo,int memberNo);

    /**
     * 학생 출석 처리
     * @param attend
     * @return
     */
    int studentAttendMan(Attend attend);

    /**
     * 반 출석 체크 일괄처리 및 페이지 리로드
     * @param attend
     * @param memberNo
     * @return
     */
    int attendClassAll(Attend attend,int memberNo);

    /**
     * 관리자 출결현황
     * @param dataSet
     * @return
     */
    Map<String,Object> attendStatistics(String dataSet);
}
