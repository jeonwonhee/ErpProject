package com.kh.classLink.service;

import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Member;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {


    private final MemberMapper  memberMapper;

    public MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    @Override
    public int getMemberCountById(String memberId) {
        int count = memberMapper.getMemberCountById(memberId);
        return count;
    }

    /**
     * 회원가입
     * @param member
     * @return
     */
    @Override
    public int insertMember(Member member) {
        int result = 0;
        result = memberMapper.insertMember(member);
        if (member.getRole().equals("TEACHER")) {
            result = memberMapper.insertLecture(member);
        }
        return result;
    }

}
