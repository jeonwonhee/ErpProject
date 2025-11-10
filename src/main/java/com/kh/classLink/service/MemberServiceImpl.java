package com.kh.classLink.service;

import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Autowired

    public MemberServiceImpl(MemberMapper memberMapper) {
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
     * 회원가입
     */
    @Override
    @Transactional
    public int insertMember(Member member) {
        int result = memberMapper.insertMember(member);

        // 강사인 경우 LECTURE 테이블에도 INSERT
        if (result > 0 && "TEACHER".equals(member.getRole()) && member.getLectureName() != null) {
            result = memberMapper.insertLecture(member);
        }

        return result;
    }
}