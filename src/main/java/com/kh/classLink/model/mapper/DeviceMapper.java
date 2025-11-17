package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Device;
import com.kh.classLink.model.vo.DeviceLog;
import com.kh.classLink.model.vo.DeviceRentAtt;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

@Mapper
public interface DeviceMapper {

    List<Device> selectDevice();

    List<DeviceLog> selectDeviceLogs();

    List<DeviceRentAtt> selectDeviceRentAtt();

    //기자재 신청
    int insertDevice(Device device);

    int insertAttend(DeviceRentAtt deviceRentAtt);

    List<DeviceRentAtt> selectBoardList(RowBounds rowBounds);
    List<DeviceRentAtt> selectAttendList(RowBounds rowBounds);

    int selectBoardListCount();
    int selectAttendListCount();

    int updateDeviceStatus(Map<String, Object> paramMap);

//    List<DeviceRentAtt> selectDeviceRentAtth();

    List<Device> selectDeviceStatusList();
//    int decreaseDeviceCount(int rentAttNo);
    List<Device> getDeviceListWithRemain();
    int insertDeviceLog(int rentAttNo);
    DeviceRentAtt getDeviceRentAttById(int deviceRentAttId);
//    Device getDeviceById(int deviceId);
    int updateDeviceRemain(int deviceId, int attendAmount);
//    int insertDeviceLog(int rentAttNo, int attendAmount);
    int getDeviceRemain(int deviceId);
}

