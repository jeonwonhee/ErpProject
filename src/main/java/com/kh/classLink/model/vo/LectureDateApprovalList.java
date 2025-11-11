package com.kh.classLink.model.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class LectureDateApprovalList {
    // 🔹 LECTURE_DATE 테이블
    private int lectureDateNo;
    private String title;
    private String content;
    private String startDate;
    private String endDate;

    // 🔹 MEMBER 테이블 (작성자 이름)
    private String writer;

    // 🔹 LECTURE_DATE_APPROVAL 테이블
    private String status;        // IN_PROGRESS / APPROVED / REJECTED
    private String approvalDate;    // 승인 처리 날짜
}
