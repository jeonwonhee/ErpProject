package com.kh.classLink.service;

import com.kh.classLink.model.vo.Consult;
import com.kh.classLink.model.vo.ConsultApplication;

import java.util.List;
import java.util.Map;

public interface ConsultService {


    int insertConsult(ConsultApplication app);
    List<ConsultApplication> getConsultApplication();
    public Map<String, Object> getBoardList(int currentPage);

    ConsultApplication getConsultApplicationById(int consultNo);

    int updateConsultStatus(int consultAppNo, String status, String refusal);

    int insertConsultation(int consultAppNo, String consultContent);
    int updateConsultInsertStatus(int consultAppNo);


}
