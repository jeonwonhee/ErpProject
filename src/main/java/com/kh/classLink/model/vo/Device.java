package com.kh.classLink.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Device {
    private int deviceId; // 기자재 일련번호
    private String deviceName; // 기자재 이름
    private int amount; // 기자재 수량
    private String status; // 기자재 현재 상태
    private String memo; // 기자재 신청시 작성하는 메모장
}
