package com.kh.classLink.service;

import com.kh.classLink.model.vo.Device;
import com.kh.classLink.model.vo.DeviceLog;
import com.kh.classLink.model.vo.DeviceRentAtt;
import com.kh.classLink.model.vo.Member;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface FacilityService {

    List<Device> getDevice();
    List<DeviceLog> getDeviceLogs();
    List<DeviceRentAtt> getDeviceRentAtt();
    List<Device>getDeviceStatusList();

    /**
     * 관리자 기자재 추가
     *
     * @return
     */
    public int insertDevice(String deviceKind, int deviceCount);
    public int insertAttend(int deviceId, int attendAmount, Date endTime, int memberNo);
    public Map<String, Object> getBoardList(int currentPage);
    public Map<String, Object> getAttendList(int currentPage);
    public int updateDeviceStatus(int deviceRentAttId, String status);
//    public List<DeviceRentAtt> selectDeviceRentAtt();
//    public int decreaseDeviceCount(int rentAttNo);
    public List<Device> getDeviceListWithRemain();
    //public int approveDeviceRent(int rentAttNo);
//    public DeviceRentAtt getDeviceRentAttById(int deviceRentAttId);
//    public Device getDeviceById(int deviceId);
    public boolean approveDeviceRent(int deviceRentAttId);

}
