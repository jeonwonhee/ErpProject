package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface AttendMapper {

    /**
     * 직원수 체크
     * @return
     */
    int selectEmpCount();

    /**
     * 직원 관리 조회
     * @param rowBounds
     * @return
     */
    ArrayList<Member> selectEmpList(RowBounds rowBounds);

}
