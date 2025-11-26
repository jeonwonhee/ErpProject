package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor

public class Consult {
    private int consultNo; // 상담 번호
    private String consultContent; // 상담 내용
    private Date startTime; // 생성일
    private Date updateTime; // 수정일
    private int consultAppNo; // 상담 신청 번호 외래키

}
