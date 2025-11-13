package com.kh.classLink.service;

import com.kh.classLink.model.mapper.ClassStudentMapper;
import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired  // 생성자 하나면 이거 생략해도 됨
    public MemberServiceImpl(MemberMapper memberMapper,
                             ClassStudentMapper classStudentMapper) {
        this.memberMapper = memberMapper;
    }

    /**
     * ID로 회원 조회
     */
    @Override
    public Member getMemberById(String memberId) {
        return memberMapper.getMemberById(memberId);
    }

    /**
     * ID와 역할로 회원 조회 (로그인용)
     */
    @Override
    public Member getMemberByIdAndRole(String memberId, String role) {
        return memberMapper.getMemberByIdAndRole(memberId, role);
    }

    /**
     * 아이디 중복 체크
     */
    @Override
    public int getMemberCountById(String memberId) {
        return memberMapper.getMemberCountById(memberId);
    }

    /**

    /**
     * 회원가입
     */
    @Override
    @Transactional
    public int insertMember(Member member) {
        int result = memberMapper.insertMember(member);

        if ("STUDENT".equalsIgnoreCase(member.getRole())
                && member.getClassNo() != null
                && member.getClassNo() > 0) {

            memberMapper.insertClass(member);   // ★ 여기만 잘 있으면 OK
        }

        // 강사인 경우 LECTURE 테이블에도 INSERT
        if (result > 0 && "TEACHER".equals(member.getRole()) && member.getLectureName() != null) {
            result = memberMapper.insertLecture(member);
        }

        return result;
    }

    @Override
    public int insertClass(Member member) {
        int result = memberMapper.insertClass(member);

        if (result <= 0) return 0;

         // 🔹 여기가 핵심! role 변수를 먼저 꺼내와야 함!!!
        String role = member.getRole();

        if ("STUDENT".equalsIgnoreCase(role)
                && member.getClassNo() != null
                && member.getClassNo() > 0) {

            memberMapper.insertClass(member);   // ← 여기서 호출!
        }

        return result;
    }
    /**
     * 회원 탈퇴
     */
    @Override
    @Transactional
    public int deleteMember(long memberNo) {
        return memberMapper.deleteMember(memberNo);

    }
    @Override
    public int updatePassword(long memberNo, String newPassword) {
        return memberMapper.updatePassword(memberNo, newPassword);
    }
    /**
     * 정보 수정
     */
    @Override
    @Transactional
    public int updateInfo(Member member) {
        return memberMapper.updateInfo(member);
    }

}