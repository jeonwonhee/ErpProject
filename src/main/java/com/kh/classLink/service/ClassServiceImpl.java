package com.kh.classLink.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.classLink.model.mapper.ClassMapper;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.ClassLecture;
import com.kh.classLink.model.vo.Lecture;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /**
     * 반 정보 전체 조회
     * @return
     */
    @Override
    public ArrayList<Class> selectClassList(int classNo) {
        ArrayList<Class> classList = classMapper.selectClassInfoList(classNo);
        return classList;
    }

    /**
     * 수업 정보 조회
     * @return
     */
    @Override
    public Map<String,Object> selectLecture() {
        ArrayList<Lecture> result = classMapper.selectLecture();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String,Object> map = new HashMap<>();
        try {
            String jsonResult = objectMapper.writeValueAsString(result);
            map.put("result",jsonResult);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return map;
    }

    @Override
    public int insertClass(Class classInfo, ClassLecture classLecture) {
        int result = 0;
        result = classMapper.insertClass(classInfo);
        if (result > 0) {
            classLecture.setClassNo(classInfo.getClassNo());
            int lectureNo = 0;
            String classDesc = "";
            String [] lectureNolist = classLecture.getLectureNoList().split(",");
            String [] lectureDescList = classLecture.getClassDesc().split(",");
            for (int i=0;i<lectureNolist.length;i++) {
                lectureNo = Integer.parseInt(lectureNolist[i]);
                classDesc =  lectureDescList[i];
                classLecture.setLectureNo(lectureNo);
                classLecture.setClassDesc(classDesc);
                classLecture.setPlanStartDate(classInfo.getStartDate());
                classLecture.setPlanEndDate(classInfo.getEndDate());
                result += classMapper.insertClassLecture(classLecture);
            }

        }

        return result;
    }

    /**
     * 반 정보 및 배정 수업 정보 조회
     * @param classNo
     * @return
     */
    @Override
    public Map<String, Object> selectClassInfoByClassNo(int classNo) {
        ArrayList<Class> classInfo = classMapper.selectClassInfoList(classNo);
        ArrayList<Lecture> classLectureInfo = classMapper.selectClassLectureByClassNo(classNo);
        ArrayList<Lecture> lectureList = classMapper.selectLecture();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String,Object> map = new HashMap<>();
        String jsonLectureList = "";
        try {
            jsonLectureList =  objectMapper.writeValueAsString(lectureList);
            map.put("classInfo",classInfo);
            map.put("lectureInfo",classLectureInfo);
            map.put("lectureList",jsonLectureList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }

    /**
     * 반 정보 수정
     * @param classInfo
     * @param classLecture
     * @return
     */
    @Override
    public int updateClass(Class classInfo, ClassLecture classLecture) {
        int result = classMapper.updateClass(classInfo);
        System.out.println("classInfo:"+classInfo);
        System.out.println("classLecture:"+classLecture);
        if (result > 0) {
            result += classMapper.deleteClassLecture(classInfo.getClassNo());
            classLecture.setClassNo(classInfo.getClassNo());
            int lectureNo = 0;
            String classDesc = "";
            String [] lectureNolist = classLecture.getLectureNoList().split(",");
            String [] lectureDescList = classLecture.getClassDesc().split(",");
            for (int i=0;i<lectureNolist.length;i++) {
                lectureNo = Integer.parseInt(lectureNolist[i]);
                classDesc =  lectureDescList[i];
                classLecture.setLectureNo(lectureNo);
                classLecture.setClassDesc(classDesc);
                classLecture.setPlanStartDate(classInfo.getStartDate());
                classLecture.setPlanEndDate(classInfo.getEndDate());
                result += classMapper.insertClassLecture(classLecture);
            }

        }
        return result;
    }
}

