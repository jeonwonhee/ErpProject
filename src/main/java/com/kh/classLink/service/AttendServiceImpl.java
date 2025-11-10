package com.kh.classLink.service;



import com.kh.classLink.model.mapper.AttendMapper;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AttendServiceImpl implements AttendService {

    private final AttendMapper  attendMapper;

    public AttendServiceImpl(AttendMapper attendMapper) {
        this.attendMapper = attendMapper;
    }

    /**
     * 직원 관리 조회
     * @param currentPage
     * @return
     */
    @Override
    public Map<String, Object> selectEmpList(int currentPage) {

        int empListCount = attendMapper.selectEmpCount();

        PageInfo pi = new PageInfo(currentPage, empListCount, 5, 5);
        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Member> empList = attendMapper.selectEmpList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("empList", empList);
        map.put("pi", pi);

        return map;
    }

    /**
     * 금일 내 수업을 듣는 반 리스트
     * @param memberNo
     * @return
     */
    @Override
    public ArrayList<Class> selectTodayLectureClass(int memberNo) {
        ArrayList<Class> classList = attendMapper.selectTodayLectureClass(memberNo);
        return classList;
    }

    /**
     * 선택한 반의 정보와 소속 학생 리스트
     * @param classNo
     * @return
     */
    @Override
    public Map<String, Object> selectAttendInfo(int classNo,int memberNo) {

        ArrayList<Class> classInfo = attendMapper.selectClassInfo(classNo);
        ArrayList<Attend> studentList = attendMapper.selectAttendStudentList(classNo);
        ArrayList<Class> classList = attendMapper.selectTodayLectureClass(memberNo);
        Map<String, Object> map = new HashMap<>();
        map.put("classList", classList);
        map.put("classInfo", classInfo);
        map.put("studentList", studentList);


        return map;
    }


    /**
     * 학생 출석 처리
     * @param attend
     * @return
     */
    @Override
    public int studentAttendMan(Attend attend) {
        int result = attendMapper.studentAttendMan(attend);
        return result;
    }

    /**
     * 반 일괄 출석 처리 및 페이지 리로드
     * @param attend
     * @param memberNo
     * @return
     */
    @Override
    public int attendClassAll(Attend attend, int memberNo) {
        ArrayList<Attend> studentList = attendMapper.selectAttendStudentList(attend.getClassNo());
        int result = 1;
        List<Map<String,Object>> attendClassAllList = new ArrayList<>();
        for (int i=0; i<studentList.size(); i++) {
            Map<String, Object> dataMap = new HashMap<>();
            if (studentList.get(i).getAttendStatus() == null) {
                Attend newAttend = new Attend();
                newAttend.setAttendStatus(attend.getAttendStatus());
                newAttend.setSessionNo(attend.getSessionNo());
                newAttend.setStudentNo(studentList.get(i).getStudentNo());
                dataMap.put("attend",newAttend);
                attendClassAllList.add(dataMap);
            }
        }
        System.out.println("attendClassAllList::::"+attendClassAllList);
        Map<String, Object> map = new HashMap<>();
        if (attendClassAllList.size() > 0) {
            result = attendMapper.attendClassAll(attendClassAllList);
        }

        return result;

    }
}
