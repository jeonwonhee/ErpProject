package com.kh.classLink.controller;

import com.kh.classLink.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ClassController {

    @Autowired
    ClassService classService;

    @GetMapping("/admin/className")
    @ResponseBody
    public String getClassName(@RequestParam int classNo) {
        return classService.selectClassNameByClassNo(classNo);
    }
}
