package com.kh.classLink.service;



import com.kh.classLink.model.mapper.AttendMapper;
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
}
