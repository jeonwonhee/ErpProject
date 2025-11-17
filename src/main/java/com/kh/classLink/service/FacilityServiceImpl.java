package com.kh.classLink.service;

import com.kh.classLink.model.mapper.DeviceMapper;
import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Device;
import com.kh.classLink.model.vo.DeviceLog;
import com.kh.classLink.model.vo.DeviceRentAtt;
import com.kh.classLink.model.vo.PageInfo;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FacilityServiceImpl implements FacilityService{
    private final DeviceMapper deviceMapper;

    @Override
    public List<Device> getDevice() {
        return deviceMapper.selectDevice();
    }

    @Override
    public List<DeviceLog> getDeviceLogs() {

        return deviceMapper.selectDeviceLogs();
    }

    @Override
    public List<DeviceRentAtt> getDeviceRentAtt() {
        return deviceMapper.selectDeviceRentAtt();
    }

    public FacilityServiceImpl(DeviceMapper deviceMapper) {
        this.deviceMapper = deviceMapper;
    }

    @Override
    @Transactional
    public int insertDevice(String deviceName, int amount){
        int result = 0;
        Device device = new Device();
        device.setDeviceKind(deviceName);
        device.setDeviceCount(amount);
        result = deviceMapper.insertDevice(device);
        return result;
    }

    @Override
    @Transactional
    public int insertAttend(int deviceId, int attendAmount, Date endTime,int memberNo) {
        int result = 0;
        DeviceRentAtt deviceRentAtt = new DeviceRentAtt();
        deviceRentAtt.setDeviceId(deviceId);
        deviceRentAtt.setAttendAmount(attendAmount);
        deviceRentAtt.setEndTime(endTime);
        deviceRentAtt.setMemberNo(memberNo);
        System.out.println("deviceRentAtt "+deviceRentAtt);
        result = deviceMapper.insertAttend(deviceRentAtt);
        return result;

    }
    @Override
    @Transactional
    public Map<String, Object> getBoardList(int currentPage) {
        int listCount = deviceMapper.selectBoardListCount();

        PageInfo pi = new PageInfo(currentPage, listCount, 5, 5);

        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<DeviceRentAtt> list = (ArrayList)deviceMapper.selectBoardList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", pi);

        return map;
    }
    @Override
    @Transactional
    public Map<String, Object> getAttendList(int currentPage) {
        int listCount = deviceMapper.selectAttendListCount();

        PageInfo pi = new PageInfo(currentPage, listCount, 5, 13);

        int offset = (currentPage - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<DeviceRentAtt> deviceRentAtt = (ArrayList)deviceMapper.selectAttendList(rowBounds);

        Map<String, Object> map = new HashMap<>();
        map.put("deviceRentAtt", deviceRentAtt);
        map.put("pi", pi);

        return map;
    }
    @Override
    public int updateDeviceStatus(int deviceRentAttId, String status) {
        Map<String, Object> map = new HashMap<>();
        map.put("deviceRentAttId", deviceRentAttId);
        map.put("status", status);
        return deviceMapper.updateDeviceStatus(map);
    }
//    @Override
//    public List<DeviceRentAtt> selectDeviceRentAtt() {
//        return deviceMapper.selectDeviceRentAtth();  // Mapper 메서드 이름과 맞춤
//    }
    @Override
    public List<Device> getDeviceStatusList() {
        return deviceMapper.selectDeviceStatusList();
    }
//    @Transactional
//    public int decreaseDeviceCount(int rentAttNo) {
//        return deviceMapper.decreaseDeviceCount(rentAttNo);
//    }
    @Override
    public List<Device> getDeviceListWithRemain(){
        return deviceMapper.getDeviceListWithRemain();
    }
//    @Transactional
//    public int approveDeviceRent(int rentAttNo) {
//        // DEVICE_REMAIN 컬럼이 없으면, 그냥 DEVICE_LOG에서 남은 수량 계산
//        // 만약 컬럼이 있다면 UPDATE DEVICE SET DEVICE_REMAIN = DEVICE_REMAIN - ATTEND_COUNT WHERE ...
//
//        // 여기서는 단순히 성공 여부만 반환
//        return deviceMapper.approveDeviceRent(rentAttNo);
//    }

//    public DeviceRentAtt getDeviceRentAttById(int deviceRentAttId){
//        return deviceMapper.getDeviceRentAttById(deviceRentAttId);
//    }
//    public  Device getDeviceById(int deviceId){
//        return deviceMapper.getDeviceById(deviceId);
//    }

    @Override
    @Transactional
    public boolean approveDeviceRent(int deviceRentAttId) {
        // 1. 신청 정보 가져오기
        DeviceRentAtt rent = deviceMapper.getDeviceRentAttById(deviceRentAttId);
        int deviceId = rent.getDeviceId();
        int attendAmount = rent.getAttendAmount();

        // 2. 남은 수량 확인
        int deviceRemain = deviceMapper.getDeviceRemain(deviceId);
        if (deviceRemain < attendAmount) {
            return false;
        }

        // 3. DEVICE_LOG insert
        int logResult = deviceMapper.insertDeviceLog(deviceRentAttId);
        if (logResult == 0) return false;

        // 4. DEVICE 남은 수량 차감
        int updateResult = deviceMapper.updateDeviceRemain(deviceId, attendAmount);
        return updateResult > 0;
    }

}
