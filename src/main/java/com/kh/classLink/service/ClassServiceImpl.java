package com.kh.classLink.service;

import com.kh.classLink.model.mapper.ClassMapper;
import com.kh.classLink.model.vo.Class;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClassServiceImpl implements ClassService {

    private final ClassMapper classMapper;

    @Override
    public String selectClassNameByClassNo(int classNo) {
        return classMapper.selectClassNameByClassNo(classNo);
    }

    @Override
    public List<Class> selectClassList() {
        return classMapper.selectClassList();
    }
}

