package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AttendanceController {
    /**
     * 관리자 출결현황
     * @return
     */
    @GetMapping("/AttendanceDashboard.co")
    public String adminAttendanceDashboard(){
        return "admin/adminAttendDashboard";
    }

    /**
     * 관리자 학생관리
     * @return
     */
    @GetMapping("/adminStudentList.co")
    public String adminStudentList(){
        return "admin/adminStudentList";
    }

    /**
     * 관리자 직원관리
     * @return
     */
    @GetMapping("/adminLectureList.co")
    public String adminLectureList(){
        return "admin/adminLectureList";
    }

    /** 강사 출결관리
     * @return
     */
    @GetMapping("/lectureAttendance.co")
    public String lectureAttendance() {
        return "lecture/leAttendance";
    }

    /** 강사 출결정정 승인/반려 여부 페이지
     * @return
     */
    @GetMapping("/lectureAttendanceCorrection.co")
    public String lectureAttendanceCorrection() {
        return "lecture/leAttendanceCorrection";
    }

    /** 강사 출결정정목록 페이지
     * @return
     */
    @GetMapping("/lectureAttendanceList.co")
    public String lectureAttendanceList() {
        return "lecture/leAttendanceList";
    }

    /**
     *
     * 학생/ 출석정정 신청 페이지     */

    @GetMapping("/stAtt.co")
    public String stAtt() {
        //츨석 정정
        return "student/stAtt";
    }

}
