package com.kh.classLink.model.vo;

import lombok.*;


import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class ConsultApplication {

    private int consultAppNo; // 상담신청번호
    private String consultAppContent; // 상담 신청 사유
    private Timestamp consultTime; // 신청일
    private String status; // 신청상태
    private String refusal; // 반려사유
    private Date createTime; // 생성일
    private Date updateTime; // 수정일
    private int consultAppMemberNo; // 상담신청자 번호 외래키로 가져옴
    private int consultMemberNo; // 상담자 번호 외래키로 가져옴
    private String memberName; // 상담 신청한 사람(학생)조인 컬럼
}
