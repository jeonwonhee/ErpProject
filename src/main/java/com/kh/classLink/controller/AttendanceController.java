package com.kh.classLink.controller;

import com.kh.classLink.model.vo.*;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.AttendService;
import com.kh.classLink.service.StudentDashboardService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AttendanceController {

    private AttendService attendService;
    private StudentDashboardService studentDashboardService;

    public AttendanceController(AttendService attendService,
                                StudentDashboardService studentDashboardService) {

        this.attendService = attendService;
        this.studentDashboardService = studentDashboardService;
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
    public String adminStudentList(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                                   HttpSession session,Model model){

        // 로그인 체크
        if (session.getAttribute("loginMember") == null) {
            session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/login.co";
        }

        // 1) 전체 학생 수 조회
        int listCount = attendService.getStudentCount();

        // 2) PageInfo 생성 (한 페이지 10명, 페이징바 5개 예시)
        PageInfo pi = new PageInfo(currentPage, listCount, 5, 5);

        // 3) 페이징된 학생 목록 조회
        List<Member> studentList = attendService.findAllStudentsForAdmin(pi);

        for (Member m : studentList) {

            AttendanceStats stats = studentDashboardService.getMonthlyAttendance(m.getMemberNo());

            int rate = 0;
            if (stats != null) {
                rate = stats.getRate();   // 출석률 %
            }

            m.setAttendRate(rate);  // ⭐ 여기서 Member에 저장!
        }

        // JSP로 값 전달
        model.addAttribute("studentList", studentList);
        model.addAttribute("pi", pi);

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

    /** 강사 출결관리
     * @return
     */
    @GetMapping("/lectureAttendance.co")
    public String lectureAttendance(HttpSession session,Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        ArrayList<Class> list = attendService.selectTodayLectureClass(loginMember.getMemberNo());
        model.addAttribute("classList", list);

        return "lecture/leAttendance";
    }

    /* 강사 출결관리 페이지*/
    @GetMapping("/lectureAttendanceList.co")
    public String lectureAttendanceList(HttpSession session, Model model) {

        Member teacher = (Member) session.getAttribute("loginMember");
        int teacherNo = teacher.getMemberNo();

        List<AttendUpdate> list = attendService.getAttendUpdateList(teacherNo);
        System.out.println("TEST!!"+list);
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

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            // 로그인 안되어있으면 로그인 페이지로
            return "redirect:/login.co";
        }

        int approverNo = loginMember.getMemberNo();

        attendService.updateAttendCorrect(attendUpdateNo, status, refusal, approverNo);

        return "redirect:/lectureAttendanceList.co";
    }

    /**
     *
     * 학생/ 출석정정 신청 페이지     */

    @GetMapping("/stAtt.co")
    public String stAtt(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        ArrayList<AttendUpdate> result = attendService.selectAttendOrderList(loginMember.getMemberNo());
        model.addAttribute("result",result);
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
    public String selectAttendClass(@RequestParam(value = "classNo", defaultValue = "0") int classNo,HttpSession session ,Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memberNo = loginMember.getMemberNo();
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
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memberNo = loginMember.getMemberNo();

        int result = attendService.attendClassAll(attend,memberNo);

        if(result > 0) {
            session.setAttribute("alertMsg", "일괄 처리에 성공하였습니다.");
        } else {
            model.addAttribute("errorMsg", "일괄 처리에 실패하였습니다.");
        }

        return "redirect:/selectAttendClass.at?classNo="+classNo;
    }


    /**
     * 출석 정정 신청
     * @param attendUpdate
     * @param session
     * @param model
     * @return
     */
    @PostMapping("/insertAttendOrder.at")
    public String insertAttendOrder(AttendUpdate attendUpdate, HttpSession session, Model model,
                                    @RequestParam(value="upFile" , required = false) MultipartFile upfile) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memberNo = loginMember.getMemberNo();
        attendUpdate.setMemberNo(memberNo);
        int result = attendService.insertAttendOrder(attendUpdate,upfile);
        if (result > 0) {
            session.setAttribute("alertMsg", "정정 신청에 성공하였습니다.");
        } else {
            session.setAttribute("alertMsg", "해당 날짜에 출석 정보가 없습니다. 확인 바랍니다.");
        }
        return "redirect:/stAtt.co";
    }

}
