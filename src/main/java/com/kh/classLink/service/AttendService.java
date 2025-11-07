package com.kh.classLink.service;

import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface AttendService {

    /**
     * 관리자 직원 조회
     * @param currentPage
     * @return
     */
    Map<String,Object> selectEmpList(int currentPage);
}
