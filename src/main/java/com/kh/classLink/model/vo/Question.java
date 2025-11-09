package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Question {
    private int questionNo;
    private String questionType;
    private String questionTitle;
    private String questionContent;
    private String answer;
    private int questionMember;
    private int answerMember;
    private Date createDate;
    private Date updateDate;

    private String questionStatus;
    private String questionMemberName;
    private String answerMemberName;

    private String listType;
}
