package com.kh.classLink.service;

import com.kh.classLink.model.vo.Class;

import java.util.List;

public interface ClassService {

    String selectClassNameByClassNo(int classNo);

    //수강반 리스트 가져오기
    List<Class> selectClassList();

}
