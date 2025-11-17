package com.kh.classLink.service;

import com.kh.classLink.model.mapper.ClassStudentMapper;
import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.PasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

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

    /**
     * 강사 회원번호로 자신의 강의명 한 개 조회
     */
    @Override
    public String selectLectureNameByMemberNo(int memberNo) {
        return memberMapper.selectLectureNameByMemberNo(memberNo);
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
    public int updatePassword(long memberNo, String newPassword, String token) {
        int result = 0;
        if (token.equals("")) {
            result = memberMapper.updatePassword(memberNo, newPassword);
        } else {
            ArrayList<PasswordToken> tokenResult = memberMapper.checkToken(token);
            if (tokenResult.isEmpty()) {
                result = 0;
                return result;
            } else {
                memberNo = tokenResult.get(0).getMemberNo();
                result =  memberMapper.updatePassword(memberNo, newPassword);
                result = memberMapper.updateToken(token);
            }
        }
        return result;
    }
    /**
     * 정보 수정
     */
    @Override
    @Transactional
    public int updateInfo(Member member) {
        return memberMapper.updateInfo(member);
    }

    /**
     * 비밀번호 찾기 요청
     * @param member
     * @return
     */
    @Override
    public Map<String, Object> orderpasswordFind(Member member) {
        Map<String, Object> map = new HashMap<>();
        int emailCheck = memberMapper.memberEmailCheck(member);
        Member orderMember = memberMapper.getMemberById(member.getMemberId());
        if  (emailCheck > 0) {
            String token = UUID.randomUUID().toString();
            PasswordToken passwordToken = new PasswordToken();
            passwordToken.setMemberNo(orderMember.getMemberNo());
            passwordToken.setToken(token);
            System.out.println(passwordToken);
            int result = memberMapper.insertPasswordToken(passwordToken);
            map.put("token", token);
            map.put("result",1);
            map.put("memberId", member.getMemberId());
        } else {
            map.put("result",0);
        }

        return map;
    }

    @Override
    public int selectTokenInfo(String token) {
        ArrayList<PasswordToken> result = memberMapper.checkToken(token);
        if (result.isEmpty()) {
            return 0;
        } else {
            return 1;
        }

    }


}