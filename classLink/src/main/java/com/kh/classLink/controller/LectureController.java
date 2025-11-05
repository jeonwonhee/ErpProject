package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LectureController {

     /** 강사 출결관리
     * @return
     */
    @GetMapping("/lectureAttendance.co")
    public String lectureAttendance() {
        return "lecture/lectureAttendance";
    }

    /** 강사 출결정정 승인/반려 여부 페이지
     * @return
     */
    @GetMapping("/lectureAttendanceCorrection.co")
    public String lectureAttendanceCorrection() {
        return "lecture/lectureAttendanceCorrection";
    }

    /** 강사 출결정정목록 페이지
     * @return
     */
    @GetMapping("/lectureAttendanceList.co")
    public String lectureAttendanceList() {
        return "lecture/lectureAttendanceList";
    }

    /** 강사 일정목록 페이지
     * @return
     */
    @GetMapping("/lectureCalender.co")
    public String lectureCalender() {
        return "lecture/lectureCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/lectureCalenderPlus.co")
    public String lectureCalenderPlus() {
        return "lecture/lectureCalender2";
    }

    /** 강사 상담신청목록 페이지
     * @return
     */
    @GetMapping("/lectureConsult.co")
    public String lectureConsult() {
        return "lecture/lectureConsult";
    }

    /** 강사 상담신청 승인/반려 페이지
     * @return
     */
    @GetMapping("/lectureConsultCorrection.co")
    public String lectureConsultCorrection() {return "lecture/lectureConsultCorrection";}

    /** 강사 대시보드
     * @return
     */
    @GetMapping("/lectureDashboard.co")
    public String lectureDashboard() {return "lecture/lectureDashboard";}

    /** 강사 성적입력 페이지
     * @return
     */
    @GetMapping("/lectureGrade.co")
    public String lectureGradeCheck() {return "lecture/lectureGradeCheck";}

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/lectureGraph.co")
    public String lectureGraph() {return "lecture/lectureGraph";}

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/lectureFeedback.co")
    public String lectureFeedback() {return "lecture/lectureFeedback";}

}
