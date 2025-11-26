package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Consult;
import com.kh.classLink.model.vo.ConsultApplication;
import com.kh.classLink.model.vo.DeviceRentAtt;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface ConsultMapper {

    int insertConsult(ConsultApplication app);

    List<ConsultApplication> selectBoardList(RowBounds rowBounds);
    List<ConsultApplication> selectAllConsultApplications();
    int selectBoardListCount();
    ConsultApplication selectConsultApplicationById(int consultNo);
    int updateConsultStatus(int consultAppNo, String status, String refusal, int memberNo);
    int insertConsultation(Map<String, Object> param);
    int updateConsultInsertStatus(int consultAppNo);

    /**
     * 알람 발행용 상담신청자
     * @param consultAppNo
     * @return
     */
    int selectConsultMemberNo(int consultAppNo);

}
