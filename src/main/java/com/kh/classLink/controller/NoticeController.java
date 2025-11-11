package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Notice;
import com.kh.classLink.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
public class NoticeController {

    private NoticeService noticeService;
    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    /**
     * 공지사항 이동
     * @return
     */
    @GetMapping("/notice.co")
    public String notice(@RequestParam(value="currentPage", defaultValue = "1") int currentPage, Model model) {
        //리스트 조회 필요
        String selectNoticeType = "";
        Map<String,Object> map = noticeService.selectNoticeList(currentPage,selectNoticeType);


        model.addAttribute("noticeList",map.get("noticeList"));
        model.addAttribute("pi",map.get("pi"));
        model.addAttribute("selectNoticeType",selectNoticeType);

        return "common/notice";
    }

    /**
     * 공지사항 검색
     * @param currentPage
     * @param model
     * @param selectNoticeType
     * @return
     */
    @GetMapping("/searchNotice.co")
    public String searchNotice(@RequestParam(value="currentPage", defaultValue = "1") int currentPage,
                               Model model,
                               @RequestParam(value = "selectNoticeType", defaultValue = "") String selectNoticeType) {
        //리스트 조회 필요
        Map<String,Object> map = noticeService.selectNoticeList(currentPage,selectNoticeType);
        model.addAttribute("noticeList",map.get("noticeList"));
        model.addAttribute("pi",map.get("pi"));
        model.addAttribute("selectNoticeType",selectNoticeType);

        return "common/notice";
    }

    /**
     * 공지사항 상세보기
     * @return
     */
    @GetMapping("/noticeDetail.co")
    public String noticeDetail(@RequestParam("noticeNo") int noticeNo, Model model) {
        Map<String,Object> noticeDetail = noticeService.selectNoticeByNoticeNo(noticeNo);

        model.addAttribute("noticeDetail",noticeDetail.get("notice"));
        model.addAttribute("fileList",noticeDetail.get("fileList"));

        return "common/noticeDetail";
    }

    /**
     * 공지사항 입력
     * @return
     */
    @GetMapping("/noticeEnrollForm.co")
    public String noticeEnrollForm(Model model) {
        //반별 공지용 반 이름 / 번호 조회
        ArrayList<Class> classList = noticeService.selectNoticeClassList();
        model.addAttribute("classList",classList);

        return "common/noticeEnrollForm";
    }

    /**
     * 공지사항 수정페이지 이동
     * @param noticeNo
     * @param model
     * @return
     */
    @GetMapping("/noticeUpdateForm.no")
    public String noticeUpdateForm(@RequestParam(value="noticeNo") int  noticeNo, Model model) {
        System.out.println(":::::::::::::::::noticeUpdateForm:::::::::::::::::::");
        Map<String,Object> noticeDetail = noticeService.selectNoticeByNoticeNo(noticeNo);
        //반별 공지용 반 이름 / 번호 조회
        ArrayList<Class> classList = noticeService.selectNoticeClassList();
        model.addAttribute("classList",classList);

        model.addAttribute("noticeDetail",noticeDetail.get("notice"));
        model.addAttribute("fileList",noticeDetail.get("fileList"));

        return "common/noticeUpdateForm";
    }


    /**
     * 공지사항 등록
     * @param notice
     * @param session
     * @param model
     * @param upfile
     * @param classNoList
     * @return
     */
    @PostMapping("/insertNotice.co")
    public String insertNotice(Notice notice, HttpSession session, Model model,
                               @RequestParam(value="upFile" , required = false) MultipartFile upfile,
                               @RequestParam(value = "classNoList" ,required = false) String[] classNoList) {
        //멤버 번호 호출 필요 로그인되면
        session.getAttribute("loginMember");
        notice.setMemberNo(6);
        int result = noticeService.insertNotice(notice,upfile,classNoList);

        if (result > 0) {
            session.setAttribute("alertMsg","공지사항이 등록되었습니다.");
            return "redirect:/notice.co";
        } else {
            model.addAttribute("errorMsg","공지사항 등록에 실패하였습니다.");
            return "redirect:/notice.co";
        }
    }

    /**
     * 공지사항 삭제
     * @param noticeNo
     * @param session
     * @param model
     * @return
     */
    @GetMapping("/deleteNotice.no")
    public String deleteNotice(@RequestParam("noticeNo") int noticeNo, HttpSession session, Model model) {
        int result = noticeService.deleteNotice(noticeNo);

        if (result > 0) {
            session.setAttribute("alertMsg","공지사항이 삭제되었습니다.");
            return "redirect:/notice.co";
        } else {
            model.addAttribute("errorMsg","공지사항 삭제에 실패하였습니다.");
            return "redirect:/notice.co";
        }

    }

    /**
     * 공지사항 수정
     * @param notice
     * @param model
     * @param session
     * @param upFile
     * @return
     */
    @PostMapping("/updateNotice.no")
    public String  updateNotice(Notice notice , Model model, HttpSession session,
                                @RequestParam(value = "upFile" ,required = false) MultipartFile upFile,
                                @RequestParam(value = "classNoList" ,required = false) String[] classNoList) {
        System.out.println(":::::::updateNotice::::::::::::");
        System.out.println("notice:::::::"+notice);
        System.out.println("classNoList:::::::"+classNoList);
        notice.setMemberNo(6);
        int result = noticeService.updateNotice(notice,upFile,classNoList);

        if (result > 0) {
            session.setAttribute("alertMsg","공지사항이 수정되었습니다.");
            return "redirect:/notice.co";
        } else {
            model.addAttribute("errorMsg","공지사항 수정에 실패하였습니다.");
            return "redirect:/notice.co";
        }
    }




}