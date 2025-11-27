package com.kh.classLink.service;

import com.kh.classLink.model.mapper.AttendMapper;
import com.kh.classLink.model.mapper.ConsultMapper;
import com.kh.classLink.model.mapper.NotificationMapper;
import com.kh.classLink.model.vo.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ConsultServiceImpl implements ConsultService {

    @Autowired
    private final ConsultMapper consultMapper;

    private NotificationMapper notificationMapper;

    public ConsultServiceImpl(ConsultMapper consultMapper, NotificationMapper notificationMapper) {
        this.consultMapper = consultMapper;
        this.notificationMapper = notificationMapper;
    }

    @Override
    public int insertConsult(ConsultApplication app) {
        return consultMapper.insertConsult(app);
    }
    @Override
    public List<ConsultApplication> getConsultApplication() {
        return consultMapper.selectAllConsultApplications();
    }

    @Override
    @Transactional
    public Map<String, Object> getBoardList(int currentPage) {
        int listCount = consultMapper.selectBoardListCount();

        PageInfo pi = new PageInfo(currentPage, listCount, 5, 3);

        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<ConsultApplication> consultApplicationList = (ArrayList)consultMapper.selectBoardList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("consultApplicationList", consultApplicationList);
        map.put("pi", pi);

        return map;
    }

    @Override
    public ConsultApplication getConsultApplicationById(int consultNo) {
        return consultMapper.selectConsultApplicationById(consultNo);
    }
    @Override
    @Transactional
    public int updateConsultStatus(int consultAppNo, String status, String refusal, int memberNo) {
        int result = consultMapper.updateConsultStatus(consultAppNo, status, refusal, memberNo);
        System.out.println("consultAppNo = " + consultAppNo);
        int consultMemberNo = consultMapper.selectConsultMemberNo(consultAppNo);

        if (result > 0) {
            Notification no = new Notification();
            no.setNotificationTitle("상담 신청 처리");
            no.setNotificationContents("상담 신청 처리가 완료되었습니다.");
            no.setMemberNo(consultMemberNo);
            result = notificationMapper.insertNoti(no);
        }
        return result;
    }
    @Override
    @Transactional
    public int updateConsultInsertStatus(int consultAppNo){
        return consultMapper.updateConsultInsertStatus(consultAppNo);
    }

    @Override
    @Transactional
    public int insertConsultation(int consultAppNo, String consultContent) {
        Map<String, Object> map = new HashMap<>();
        map.put("consultAppNo", consultAppNo);
        map.put("consultContent", consultContent);
        return consultMapper.insertConsultation(map);
    }
}
