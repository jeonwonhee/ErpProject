package com.kh.classLink.service;

import com.kh.classLink.model.mapper.LectureDateMapper;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.LectureDateApprovalList;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class LectureDateServiceImpl implements LectureDateService {

    private final LectureDateMapper lectureDateMapper;

    /* 전체 일정 조회 */
    @Override
    public List<LectureDate> selectLectureDateList() {
        log.info("[LectureDateService] 전체 일정 조회 실행");
        return lectureDateMapper.selectLectureDateList();
    }

    /* 특정 반(CLASS_LECTURE_NO)의 일정 조회 */
    @Override
    public List<LectureDate> selectLectureDateByClass(int classLectureNo) {
        log.info("[LectureDateService] 반 번호 {} 일정 조회 실행", classLectureNo);
        return lectureDateMapper.selectLectureDateByClass(classLectureNo);
    }

    /* 일정 등록 (INSERT) */
    @Override
    @Transactional // 💡 트랜잭션 관리 (성공 시 커밋, 실패 시 롤백)
    public int insertLectureDate(LectureDate lectureDate) {
        // 1. 일정 등록
        int result = lectureDateMapper.insertLectureDate(lectureDate);

        // 2. 등록 성공 시 해당 일정번호로 승인 데이터 생성
        if (result > 0) {
            lectureDateMapper.insertLectureDateApproval(lectureDate.getLectureDateNo());
        }

        return result;
    }

    /* 일정 수정 (UPDATE) */
    @Override
    @Transactional
    public int updateLectureDate(LectureDate lectureDate) {
        log.info("[LectureDateService] 일정 수정 실행: {}", lectureDate);
        return lectureDateMapper.updateLectureDate(lectureDate);
    }

    /* 특정 반(CLASS_LECTURE_NO)의 일정 조회 */
    @Override
    @Transactional
    public int deleteLectureDate(int lectureDateNo) {
        log.info("[LectureDateService] 일정 삭제 실행 - 번호: {}", lectureDateNo);
        return lectureDateMapper.deleteLectureDate(lectureDateNo);
    }

    @Override
    public int getClassLectureNoByMemberNo(int memberNo) {
        return lectureDateMapper.selectClassLectureNoByMemberNo(memberNo);
    }

    @Override
    public int updateApprovalStatus(int lectureDateNo, String status, String reason, int approvedBy) {
        return lectureDateMapper.updateApprovalStatus(lectureDateNo, status, reason, approvedBy);
    }

    @Override
    public List<LectureDateApprovalList> selectLectureDateApprovalList() {
        return lectureDateMapper.selectLectureDateApprovalList();
    }

    @Override
    public LectureDateApprovalList selectLectureDateApprovalDetail(int lectureDateNo) {
        return lectureDateMapper.selectLectureDateApprovalDetail(lectureDateNo);
    }
}
