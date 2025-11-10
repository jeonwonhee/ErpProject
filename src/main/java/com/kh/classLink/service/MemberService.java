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


    /**
     * 아이디 + 역할로 회원 조회 (로그인용)
     */
    Member getMemberByIdAndRole(String memberId, String role);

    /**
     * 아이디로 회원 조회 (단일 조회용)
     */
    Member getMemberById(String memberId);
}