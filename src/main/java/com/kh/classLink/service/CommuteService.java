package com.kh.classLink.service;

public interface CommuteService {

    // 출근 기록
    void recordCommuteIn(int memberNo);

    // 로그아웃 시 퇴근 처리 (가장 최근 IN 기록을 OUT으로 변경)
    void processLogoutCommute(int memberNo);
}