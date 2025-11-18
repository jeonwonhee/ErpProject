package com.kh.classLink.service;

import com.kh.classLink.model.mapper.CommuteMapper;
import com.kh.classLink.model.vo.Commute;
import org.springframework.stereotype.Service;

import java.time.LocalTime;

@Service
public class CommuteServiceImpl implements CommuteService {

    private final CommuteMapper commuteMapper;

    public CommuteServiceImpl(CommuteMapper commuteMapper) {
        this.commuteMapper = commuteMapper;
    }

    @Override
    public void recordCommuteIn(int memberNo) {
        // 오늘 날짜에 이미 출근 기록이 있는지 확인
        int count = commuteMapper.checkTodayCommute(memberNo);

        if (count > 0) {
            System.out.println("이미 오늘 출근 기록이 있습니다.");
            return; // insert하지 않음
        }

        // 현재 시각 기준 출근 상태 결정
        LocalTime now = LocalTime.now();
        LocalTime standardTime = LocalTime.of(9, 0);

        String status = now.isAfter(standardTime) ? "LATE" : "IN";

        commuteMapper.insertCommuteIn(memberNo, status);
    }

    //  로그아웃 시 퇴근 처리
    @Override
    public void processLogoutCommute(int memberNo) {
        System.out.println("=== 🚩 LOGOUT COMMUTE START ===");
        System.out.println("memberNo = " + memberNo);

        Commute latest = commuteMapper.selectLatestCommute(memberNo);

        System.out.println("조회 결과 = " + latest);

        if (latest != null) {
            System.out.println("commuteNo to update = " + latest.getCommuteNo());
        }

        // 기존 처리
        if (latest != null &&
                ("IN".equals(latest.getCommuteStatus()) || "LATE".equals(latest.getCommuteStatus()))) {

            int result = commuteMapper.updateCommuteOut(latest.getCommuteNo());
            System.out.println("업데이트 결과 = " + result);
        } else {
            System.out.println("⚠ 퇴근 업데이트 불가 (조건 불일치 또는 조회 실패)");
        }

        System.out.println("=== 🚩 LOGOUT COMMUTE END ===");
    }
}
