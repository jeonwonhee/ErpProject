package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    int getMemberCountById(String memberId);

    /**
     * 회원가입
     * @param member
     * @return
     */
    int insertMember(Member member);

    /**
     * 수업 등록
     * @param member
     * @return
     */
    int insertLecture(Member member);
    
}
