package com.kh.classLink.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.util.Date;

@Getter
@Setter
@ToString
public class LectureDateApproval {
    private int approvalNo;
    private int approvedBy;
    private String approvalReject;
    private Date approvalDate;
    private int lectureDateNo;
    private String status;
}
