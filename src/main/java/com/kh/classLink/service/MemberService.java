package com.kh.classLink.service;

import com.kh.classLink.model.vo.Member;

public interface MemberService {

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    public int getMemberCountById(String memberId);

    /**
     * 회원 가입
     * @param member
     * @return
     */
    public int insertMember(Member member);
}
