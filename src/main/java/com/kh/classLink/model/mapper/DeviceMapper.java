package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Device;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DeviceMapper {
    //기자재 신청
    int insertDevice(Device device);
}
