package com.kh.classLink.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class DeviceLog {
    private int deviceLogId;
    private int deviceGiveCount; // 기자재 배정 개수
    private Date createTime;
    private Date returnTime;
    private int memberId; // 외래키 컬럼
    private int rentDeviceId; // 외래키 컬럼

    private String deviceKind;
    private String deviceCount;
    private int remainCount;// 조인 컬럼


}
