package com.kh.classLink.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Device {
    private int deviceId; // 기자재 일련번호
    private String deviceKind; // 기자재 이름
    private int deviceCount; // 기자재 수량
    private String status;
    private int deviceRemain; // 기자재 현재 상태
}
