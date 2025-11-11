package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
// 공지사항
public class Notice {
    private int noticeNo; // 공지사항 번호
    private String noticeTitle; // 공지사항 제목
    private String noticeContents; // 공지사항 내용
    private Date createDate; // 생성일
    private Date updateDate; // 수정일
    private int memberNo; // 작성자
    private int classNo; //반 아이디
    private String noticeType; // 공지 타입 ('ALL', 'CLASS', 'SYSTEM', 'EVENT')


    private String className; //반 이름
    private String memberName; // 작성자 명
    private String role;

}
