package com.kh.classLink.service;

import com.kh.classLink.model.vo.Device;
import com.kh.classLink.model.vo.Member;

public interface FacilityService {

    /**
     * 관리자 기자재 추가
     * @param device
     * @return
     */
    public int insertDevice(Device device);
}
