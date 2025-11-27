package com.kh.classLink.model.vo;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Notification {
    private int notificationNo;
    private String notificationTitle;
    private String notificationContents;
    private boolean notificationBoolean;
    private int memberNo;
    private Date createDate;
    private Date updateDate;

}
