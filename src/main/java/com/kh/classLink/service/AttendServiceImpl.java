package com.kh.classLink.service;



import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.classLink.model.mapper.AttendMapper;
import com.kh.classLink.model.vo.Attend;
import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.model.vo.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.ChronoField;
import java.util.*;

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

    /**
     * 관리자 출결 통계
     * @param dataSet
     * @return
     */
    @Override
    public Map<String, Object> attendStatistics(String dataSet) {
        LocalDate localDate = LocalDate.now();

        int day = localDate.get(ChronoField.DAY_OF_WEEK);
        LocalDate startDate = localDate.minusDays(day);
        LocalDate endDate = startDate.plusDays(6);

        Attend attend = new Attend();
        attend.setStartDate(Date.valueOf(startDate));
        attend.setEndDate(Date.valueOf(endDate));

        Map<String,Object> map = new HashMap<>();
        ArrayList<Attend> weekAttendData = new ArrayList<>();
        ArrayList<Attend> allAttendData =  new ArrayList<>();
        ArrayList<Attend> monthAttendData =  new ArrayList<>();
        String weekData = "";
        String allData = "";
        String monthData = "";

        if (dataSet.equals("student")) {
            weekAttendData = attendMapper.selectStWeekAttendData(attend);
            allAttendData = attendMapper.selectStAllAttendData(attend);
            monthAttendData = attendMapper.selectStMonthAttendData(attend);

        } else {


        }
        //주간 데이터 값이 0인 날이 있는 경우
        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
            Attend newAttend = null;
            for (Attend a :  weekAttendData) {
                if (a.getAttendDate() != null && a.getAttendDate().toLocalDate().equals(date)) {
                    newAttend = a;
                    break;
                }
            }
            if (newAttend == null) {
                newAttend = new Attend();
                newAttend.setAttendDate(Date.valueOf(date));
                newAttend.setAttendRate(0);
                weekAttendData.add(newAttend);
            }
        }
        //월별 데이터 데이터 0인경우 처리
        for (int j=1; j<13; j++) {
            Attend newAttend = null;
            for (int i=0; i<monthAttendData.size(); i++) {
                String monthAttend = monthAttendData.get(i).getAttendMonth().toString();

                if (monthAttend.length()>3 && Integer.parseInt(monthAttend.substring(5,7)) == j) {
                    newAttend = monthAttendData.get(i);
                    break;
                }
            }
            if (newAttend == null) {
                newAttend = new Attend();
                newAttend.setAttendMonth(String.valueOf(j));
                newAttend.setAttendRate(0);
                monthAttendData.add(newAttend);
            }

        }

        //데이터 json 형식으로 변경
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            weekData = objectMapper.writeValueAsString(weekAttendData);
            allData = objectMapper.writeValueAsString(allAttendData);
            monthData = objectMapper.writeValueAsString(monthAttendData);
        } catch (Exception e) {
            e.printStackTrace();
        }



        map.put("weekData", weekData);
        map.put("allData", allData);
        map.put("monthData", monthData);


        return map;
    }
}
