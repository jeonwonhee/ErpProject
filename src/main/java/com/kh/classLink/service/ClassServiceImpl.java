package com.kh.classLink.service;

import com.kh.classLink.model.mapper.ClassMapper;
import com.kh.classLink.model.mapper.ClassStudentMapper;
import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Class;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClassServiceImpl implements ClassService {

    private final ClassMapper classMapper;

    @Autowired  // 생성자 하나면 이거 생략해도 됨
    public ClassServiceImpl(ClassMapper classMapper) {
        this.classMapper = classMapper;
    }

    @Override
    public String selectClassNameByClassNo(int classNo) {
        return classMapper.selectClassNameByClassNo(classNo);
    }

    @Override
    public List<Class> selectClassList() {
        return classMapper.selectClassList();
    }

    //강사가 담당하고 있는 수강반 조회
    @Override
    public List<Class> selectClassByLecture(int memberNo, int lectureNo) {
        return classMapper.selectClassByLecture(memberNo,lectureNo);
    }

    @Override
    public List<Class> selectStudentsByClassNo(int classNo) {
        return classMapper.selectStudentsByClassNo(classNo);
    }
}

