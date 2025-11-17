package com.kh.classLink.model.vo;

public class RecentApplication {

    private String studentName;
    private String applyDate;
    private String reason;

    public RecentApplication() {}

    public RecentApplication(String studentName, String applyDate, String reason) {
        this.studentName = studentName;
        this.applyDate = applyDate;
        this.reason = reason;
    }

    public String getStudentName() {
        return studentName;
    }

    public String getApplyDate() {
        return applyDate;
    }

    public String getReason() {
        return reason;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public void setApplyDate(String applyDate) {
        this.applyDate = applyDate;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "RecentApplication{" +
                "studentName='" + studentName + '\'' +
                ", applyDate='" + applyDate + '\'' +
                ", reason='" + reason + '\'' +
                '}';
    }
}
