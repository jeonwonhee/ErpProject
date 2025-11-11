package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
// 공지사항
public class NoticeFile {
    private int noticeFileNo; // 공지사항 파일 번호
    private String noticeFileOriName; // 공지사항 파일 원본명
    private String noticeFileName; // 공지사항 파일 명
    private String filePath; // 파일 경로
    private Date createDate; // 생성일
    private Date updateDate; // 수정일
    private int noticeNo; // 공지사항 번호


}
