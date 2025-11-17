package com.kh.classLink.model.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LectureDateApproval {
    private int approvalNo;
    private int approvedBy;
    private String approvalReject;
    private Date approvalDate;
    private int lectureDateNo;
    private String status;
}
