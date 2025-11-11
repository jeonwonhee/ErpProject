package com.kh.classLink.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class DeviceRentAtt {
    private int deviceRentAttId;
    private Date createTime;
    private Date startTime;
    private Date endTime;
    private Date updateTime;
    private int attendAmount;
    private String status;
    private int deviceId; // 외래키 컬럼
    private Integer memberNo; // 외래키 컬럼


    private String memberName; // 조인 컬럼
    private String deviceKind; // 조인 컬럼

}
