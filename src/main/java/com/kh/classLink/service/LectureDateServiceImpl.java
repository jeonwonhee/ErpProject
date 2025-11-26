package com.kh.classLink.service;

import com.kh.classLink.model.mapper.LectureDateMapper;
import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.LectureDate;
import com.kh.classLink.model.vo.LectureDateApprovalList;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class LectureDateServiceImpl implements LectureDateService {

    private final LectureDateMapper lectureDateMapper;

    /* 전체 일정 조회 */
    @Override
    public List<LectureDate> selectLectureDateList(int classLectureNo) {
        return lectureDateMapper.selectLectureDateList(classLectureNo);
    }

    /* 특정 반(CLASS_LECTURE_NO)의 일정 조회 */
    @Override
    public List<ClassLecture> selectClassLectureList(int memberNo) {
        return lectureDateMapper.selectClassLectureList(memberNo);
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

    @Override
    public int updateApprovalStatus(int lectureDateNo, String status, String reason, int approvedBy) {
        return lectureDateMapper.updateApprovalStatus(lectureDateNo, status, reason, approvedBy);
    }

    @Override
    public LectureDateApprovalList selectLectureDateApprovalDetail(int lectureDateNo) {
        return lectureDateMapper.selectLectureDateApprovalDetail(lectureDateNo);
    }

    @Override
    public List<LectureDateApprovalList> selectLectureDateListPaged(Map<String, Object> map) {
        return lectureDateMapper.selectLectureDateListPaged(map);
    }

    @Override
    public int getLectureDateListCount() {
        return lectureDateMapper.getLectureDateListCount();
    }

    @Override
    public int getLectureDateListCount(String keyword) {
        return lectureDateMapper.getLectureDateListCount(keyword);
    }

    @Override
    public int getLectureDateCount(int classLectureNo) {
        return lectureDateMapper.getLectureDateCount(classLectureNo);
    }

    @Override
    public List<LectureDate> selectLectureDatePaged(Map<String, Object> map) {
        return lectureDateMapper.selectLectureDatePaged(map);
    }

    // =========================
    // 학생용 일정 조회
    // =========================
    @Override
    public List<LectureDate> selectLectureDateListStudent(int memberNo) {
        return lectureDateMapper.selectLectureDateListStudent(memberNo);
    }

    @Override
    public String getClassNameByStudent(int memberNo) {
        return lectureDateMapper.selectClassNameByStudent(memberNo);
    }

    // 일정 중복 조회
    @Override
    public int checkDateOverlap(LectureDate lectureDate) {
        return lectureDateMapper.checkDateOverlap(lectureDate);
    }
}
