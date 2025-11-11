package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.GradeDto;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.PasswordToken;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    String selectLectureNameByMemberNo(int memberNo);
    /**
     * 강사, 관리자 회원가입
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

    /**
     * 수업 등록
     * @param member
     * @return
     */
    int insertClass(Member member);

    /**
     *
     * @param member
     * @return
     */
    int selectLoginMember(Member member);


    //비밀번호 변경
    int updatePassword(@Param("memberNo") long memberNo,
                       @Param("encodedPassword") String encodedPassword);

    //회원 탈퇴
    int deleteMember(@Param("memberNo") long memberNo);

    //정보 수정
    int updateInfo(Member member);

    /**
     * 유저 이메일 체크
     * @param member
     * @return
     */
    int memberEmailCheck(Member member);

    /**
     * 비밀번호 찾기 요청 토큰 생성
     * @param passwordToken
     * @return
     */
    int insertPasswordToken(PasswordToken passwordToken);

    Member selectMemberByNo(int memberNo);


}