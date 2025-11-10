package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    /**
     * ID로 회원 조회
     */
    Member getMemberById(@Param("memberId") String memberId);

    /**
     * ID와 역할로 회원 조회 (로그인용)
     */
    Member getMemberByIdAndRole(@Param("memberId") String memberId,
                                @Param("role") String role);

    /**
     * 아이디 중복 체크
     * @param memberId
     * @return
     */
    int getMemberCountById(String memberId);

    /**
     * 강사, 관리자 회원가입
     * @param member
     * @return
     */
    int insertMember(Member member);

    /**
     * 학생 회원가입
     * @param member
     * @return
     */
    int insertStudent(Member member);

    /**
     * 수업 등록
     * @param member
     * @return
     */
    int insertLecture(Member member);
    
}
