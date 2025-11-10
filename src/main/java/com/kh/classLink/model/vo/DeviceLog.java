package com.kh.classLink.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class DeviceLog {
    private int DeviceLogId;
    private int DeviceGiveCount; // 기자재 배정 개수
    private Date CreateTime;
    private Date ReturnTime;
    private int MemberId; // 외래키 컬럼
    private int ClassId; // 외래키 컬럼
    private int RentDeviceId; // 외래키 컬럼

}
