package com.kh.classLink.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DeviceRentAtt {
    private int DeviceRentAttId;
    private Date CreateTime;
    private Date StartTime;
    private Date EndTime;
    private Date UpdateTime;
    private int AttendAmount;
    private int DeviceId; // 외래키 컬럼
    private int MemberId; // 외래키 컬럼

}
