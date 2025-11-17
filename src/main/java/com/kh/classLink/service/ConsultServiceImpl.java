package com.kh.classLink.service;

import com.kh.classLink.model.mapper.AttendMapper;
import com.kh.classLink.model.mapper.ConsultMapper;
import com.kh.classLink.model.vo.Consult;
import com.kh.classLink.model.vo.ConsultApplication;
import com.kh.classLink.model.vo.DeviceRentAtt;
import com.kh.classLink.model.vo.PageInfo;
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

    public ConsultServiceImpl(ConsultMapper consultMapper) {
        this.consultMapper = consultMapper;
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
    public int updateConsultStatus(int consultAppNo, String status, String refusal) {
        return consultMapper.updateConsultStatus(consultAppNo, status, refusal);
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
