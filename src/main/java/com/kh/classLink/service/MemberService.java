package com.kh.classLink.service;

import com.kh.classLink.model.vo.Member;
import org.springframework.stereotype.Service;

import java.util.Map;

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
     *
     * @param member
     * @return
     */
    public int insertClass(Member member);



    //비밀번호 변경
    int updatePassword(long memberNo, String encodedPassword);

    /**
     * 회원 삭제
     * @param memberNo
     * @return
     */
     int deleteMember(long memberNo);


    /**
     * 아이디 + 역할로 회원 조회 (로그인용)
     */
    Member getMemberByIdAndRole(String memberId, String role);

    /**
     * 아이디로 회원 조회 (단일 조회용)
     */
    Member getMemberById(String memberId);

    /**
     * 정보 수정
     * @param member
     * @return
     */
    int updateInfo(Member member);

    /**
     * 비밀번호 찾기
     * @param member
     * @return
     */
    Map<String,Object> orderpasswordFind(Member member);


}