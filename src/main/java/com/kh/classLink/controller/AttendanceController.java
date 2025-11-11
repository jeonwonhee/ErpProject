package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.AttendUpdate;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.AttendService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AttendanceController {

    private AttendService attendService;

    public AttendanceController(AttendService attendService) {
        this.attendService = attendService;
    }


    /**
     * 관리자 출결현황
     * @return
     */
    @GetMapping("/AttendanceDashboard.co")
    public String adminAttendanceDashboard(@RequestParam(value="dataSet", defaultValue = "student") String dataSet,
                                           Model model) {

        Map<String,Object> map = attendService.attendStatistics(dataSet);

        model.addAttribute("weekData",map.get("weekData"));
        model.addAttribute("allData",map.get("allData"));
        model.addAttribute("monthData",map.get("monthData"));

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
    public String adminLectureList(@RequestParam(value="currentPage", defaultValue = "1") int currentPage, Model model){

        Map<String,Object> map = attendService.selectEmpList(currentPage);

        model.addAttribute("empList", map.get("empList"));
        model.addAttribute("pi", map.get("pi"));



        return "admin/adminLectureList";
    }

    /* 강사 출결관리 페이지*/
    @GetMapping("/lectureAttendanceList.co")
    public String lectureAttendanceList(HttpSession session, Model model) {

        Member teacher = (Member) session.getAttribute("loginMember");
        int teacherNo = teacher.getMemberNo();

        List<AttendUpdate> list = attendService.getAttendUpdateList(teacherNo);

        model.addAttribute("list", list);

        return "lecture/leAttendanceList";
    }

    /* 강사 출결정정 승인/반려 여부 페이지 */
    @GetMapping("/lectureAttendanceCorrection.co")
    public String lectureAttendanceCorrection(@RequestParam int attendUpdateNo, Model model) {

        AttendUpdate detail = attendService.getAttendUpdateDetail(attendUpdateNo);

        model.addAttribute("detail", detail);

        return "lecture/leAttendanceCorrection";
    }


    /* 강사 출결정정 승인/반려 */
    @PostMapping("/lectureAttendanceCorrection.co")
    public String lectureAttendanceCorrect(@RequestParam int attendUpdateNo,
                                           @RequestParam String status,
                                           @RequestParam(required=false) String refusal,
                                           HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 로그인 안되어있으면 로그인 페이지로
            return "redirect:/login.co";
        }

        int approverNo = loginUser.getMemberNo();

        attendService.updateAttendCorrect(attendUpdateNo, status, refusal, approverNo);

        return "redirect:/AttendanceList.co";
    }

    /**
     *
     * 학생/ 출석정정 신청 페이지     */

    @GetMapping("/stAtt.co")
    public String stAtt() {
        //츨석 정정
        return "student/stAtt";
    }


    /**
     * 선택 반 정보와 소속 학생 조회
     * @param classNo
     * @param model
     * @return
     */
    @GetMapping("/selectAttendClass.at")
    public String selectAttendClass(@RequestParam(value = "classNo") int classNo, Model model) {
        int memberNo = 6;
        Map<String,Object> map = attendService.selectAttendInfo(classNo,memberNo);


        model.addAttribute("classList", map.get("classList"));
        model.addAttribute("studentList", map.get("studentList"));
        model.addAttribute("classInfo", map.get("classInfo"));

        return "lecture/leAttendance";
    }

    /**
     * 학생 출석 처리
     * @param status
     * @param studentNo
     * @param sessionNo
     * @return
     */
    @GetMapping("/studentAttendMan.at")
    @ResponseBody
    public String studentAttendMan(@RequestParam(value = "status") String status,
                                   @RequestParam(value = "studentNo") int studentNo,
                                   @RequestParam(value = "sessionNo") int sessionNo) {
        Attend attend = new Attend();
        attend.setAttendStatus(status);
        attend.setStudentNo(studentNo);
        attend.setSessionNo(sessionNo);
        int result = attendService.studentAttendMan(attend);

        if (result > 0) {
            return "1";
        } else {
            return "0";
        }

    }

    /**
     * 반 전체 일괄 출설 처리 및 페이지 리로드
     * @param classNo
     * @param attendStatus
     * @param sessionNo
     * @param session
     * @param model
     * @return
     */
    @GetMapping("/attendClassAll.at")
    public  String attendClassAll(@RequestParam(value = "classNo") int classNo,
                                  @RequestParam(value = "attendStatus") String attendStatus,
                                  @RequestParam(value = "sessionNo") int sessionNo,
                                  HttpSession session,Model model) {
        Attend attend = new Attend();
        attend.setAttendStatus(attendStatus);
        attend.setSessionNo(sessionNo);
        attend.setClassNo(classNo);
        int memberNo = 6;

        int result = attendService.attendClassAll(attend,memberNo);

        if(result > 0) {
            session.setAttribute("alertMsg", "일괄 처리에 성공하였습니다.");
        } else {
            model.addAttribute("errorMsg", "일괄 처리에 실패하였습니다.");
        }

        return "redirect:/selectAttendClass.at?classNo="+classNo;
    }

}
