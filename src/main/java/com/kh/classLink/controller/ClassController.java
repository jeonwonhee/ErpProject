package com.kh.classLink.controller;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.Lecture;
import com.kh.classLink.service.ClassService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Map;

@Controller
public class ClassController {

    @Autowired
    ClassService classService;

    @GetMapping("/admin/className")
    @ResponseBody
    public String getClassName(@RequestParam int classNo) {
        return classService.selectClassNameByClassNo(classNo);
    }

    /**
     * 반 관리 화면
     * @param model
     * @return
     */
    @GetMapping("/adminClassManage.co")
    public String adminClassManage(Model model) {
        ArrayList<Class> classList = classService.selectClassList(0);
        model.addAttribute("classList", classList);
        return "admin/adminClassManage";
    }

    /**
     * 반 등록화면
     * @param model
     * @return
     */
    @GetMapping("/adminClassEnrollForm.co")
    public String adminClassEnrollForm(Model model) {
        Map<String,Object> lectureList = classService.selectLecture();
        model.addAttribute("lectureList", lectureList.get("result"));
        return "admin/adminClassEnrollForm";
    }

    /**
     * 반 정보 수정 화면
     * @param classNo
     * @param model
     * @return
     */
    @GetMapping("/adminClassUpdateForm.co")
    public String adminClassUpdateForm(@RequestParam(value = "classNo")int classNo,Model model) {
        Map<String, Object> map = classService.selectClassInfoByClassNo(classNo);
        System.out.println("map::::::::::::::::::::::::::::"+map);
        model.addAttribute("classInfo", map.get("classInfo"));
        model.addAttribute("lectureInfo", map.get("lectureInfo"));
        model.addAttribute("lectureList", map.get("lectureList"));

        return "admin/adminClassUpdateForm";
    }

    /**
     * 반 등록 및 수업 배정
     * @param classInfo
     * @param classLecture
     * @param model
     * @param session
     * @return
     */
    @GetMapping("/insertClass.cl")
    public String insertClass(Class classInfo, ClassLecture classLecture, Model model, HttpSession session) {

        int result = classService.insertClass(classInfo,classLecture);

        if (result > 0) {
            session.setAttribute("alertMsg","반이 등록되었습니다.");
            return "redirect:/adminClassManage.co";
        } else {
            model.addAttribute("errorMsg","반 등록에 실패하였습니다.");
            return "redirect:/adminClassManage.co";
        }

    }

    /**
     * 반 정보 수정
     * @param classInfo
     * @param classLecture
     * @param model
     * @param session
     * @return
     */
    @GetMapping("/updateClass.cl")
    public String updateClass(Class classInfo, ClassLecture classLecture, Model model, HttpSession session) {
        int result = classService.updateClass(classInfo,classLecture);

        if (result > 0) {
            session.setAttribute("alertMsg","반이 수정되었습니다.");
            return "redirect:/adminClassManage.co";
        } else {
            model.addAttribute("errorMsg","반 등록에 실패하였습니다.");
            return "redirect:/adminClassManage.co";
        }
    }
}
