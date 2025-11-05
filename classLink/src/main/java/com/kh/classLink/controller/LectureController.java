package com.kh.classLink.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LectureController {

     /** 강사 출결관리
     * @return
     */
    @GetMapping("/leAttendance.co")
    public String lectureAttendance() {
        return "lecture/leAttendance";
    }

    /** 강사 출결정정 승인/반려 여부 페이지
     * @return
     */
    @GetMapping("/leAttendanceCorrection.co")
    public String lectureAttendanceCorrection() {
        return "lecture/leAttendanceCorrection";
    }

    /** 강사 출결정정목록 페이지
     * @return
     */
    @GetMapping("/leAttendanceList.co")
    public String lectureAttendanceList() {
        return "lecture/leAttendanceList";
    }

    /** 강사 일정목록 페이지
     * @return
     */
    @GetMapping("/leCalender.co")
    public String lectureCalender() {
        return "lecture/leCalender";
    }

    /** 강사 일정추가 페이지
     * @return
     */
    @GetMapping("/leCalenderPlus.co")
    public String lectureCalenderPlus() {
        return "lecture/leCalenderAdd";
    }

    /** 강사 상담신청목록 페이지
     * @return
     */
    @GetMapping("/leConsult.co")
    public String lectureConsult() {
        return "lecture/leConsult";
    }

    /** 강사 상담신청 승인/반려 페이지
     * @return
     */
    @GetMapping("/leConsultCorrection.co")
    public String lectureConsultCorrection() {return "lecture/leConsultCorrection";}

    /** 강사 대시보드
     * @return
     */
    @GetMapping("/leDashboard.co")
    public String lectureDashboard() {return "lecture/leDashboard";}

    /** 강사 성적입력 페이지
     * @return
     */
    @GetMapping("/leGrade.co")
    public String lectureGradeCheck() {return "lecture/leGradeCheck";}

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leGraph.co")
    public String lectureGraph() {return "lecture/leGraph";}

    /** 강사 강의만족도 결과 확인 페이지
     * @return
     */
    @GetMapping("/leFeedback.co")
    public String lectureFeedback() {return "lecture/leFeedback";}

}
