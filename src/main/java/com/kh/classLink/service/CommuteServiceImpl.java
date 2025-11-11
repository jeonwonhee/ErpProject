package com.kh.classLink.service;

import com.kh.classLink.model.mapper.CommuteMapper;
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
}
