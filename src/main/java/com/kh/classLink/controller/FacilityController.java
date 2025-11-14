package com.kh.classLink.controller;

import com.kh.classLink.model.mapper.MemberMapper;
import com.kh.classLink.model.vo.Device;
import com.kh.classLink.model.vo.DeviceLog;
import com.kh.classLink.model.vo.DeviceRentAtt;
import com.kh.classLink.model.vo.Member;
import com.kh.classLink.service.FacilityService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FacilityController {
    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private FacilityService facilityService;
    /**
     * 관리자 기자재관리
     * @return
     */
   @GetMapping("/adminFacility.co")
   public String adminFacility(Model model) {
       List<Device> deviceList = facilityService.getDeviceStatusList();
       model.addAttribute("deviceList", deviceList);

       return "admin/adminFacility";
    }

    /**
     * 관리자 기자재추가
     * @return
     */
    @GetMapping("/adminFacilityDetail.co") // 완료
    public String adminFacilityDetail(){
        return "admin/adminFacilityDetail";
    }


//    @GetMapping("/stFacility.co")
//    public String stFacility() {
//        //학생 기자재
//       return "student/stFacility";
//    }
    @PostMapping("/insert.di") // 완료
    public String insertFacility(
            @RequestParam("deviceKind") String deviceKind,
            @RequestParam("deviceCount") int deviceCount, HttpSession session){






        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            loginMember = memberMapper.selectMemberByNo(1);
            session.setAttribute("loginMember", loginMember);
        }
        if("ADMIN".equals(loginMember.getRole())){
           int result = facilityService.insertDevice(deviceKind,deviceCount);

           if(result>0){
               return "redirect:/adminFacility.co";
           } else{
               return "admin/adminFacilityDetail";
           }
        }else{
            return "admin/adminFacilityDetail";
        }
    }


    @GetMapping("/stFacility.co") // 완료
    public String FacilityCategories(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,Model model){

        List<Device> device = facilityService.getDevice();
        List<DeviceRentAtt> deviceRentAtt = facilityService.getDeviceRentAtt();

        model.addAttribute("device", device);
        model.addAttribute("deviceRentAtt", deviceRentAtt);

        Map<String, Object> result = facilityService.getAttendList(currentPage);

        model.addAttribute("deviceRentAtt", result.get("deviceRentAtt"));
        model.addAttribute("pi",  result.get("pi"));

        return "student/stFacility";
    }
    @PostMapping("/device.in") // 완료
    public String FacilityAttendInsert(@RequestParam("deviceId") int deviceId,
                                       @RequestParam("attendAmount") int attendAmount, @RequestParam("endTime") Date endTime,@RequestParam(value = "cpage", defaultValue = "1") int currentPage, HttpSession session, Model model){
        Member loginMember = (Member) session.getAttribute("loginMember");
        System.out.println("memberNo"+loginMember);
        if (loginMember == null) {
            System.out.println("test");
            loginMember = memberMapper.selectMemberByNo(2);
            session.setAttribute("loginMember", loginMember);
        }

        int memberNo = 0 ;
        memberNo = loginMember.getMemberNo();

        int result = 0;
        result = facilityService.insertAttend(deviceId, attendAmount,endTime, memberNo);

        List<Device> device = facilityService.getDevice();
        List<DeviceRentAtt> deviceRentAtt = facilityService.getDeviceRentAtt();
        Map<String, Object> resul = facilityService.getAttendList(currentPage);

        model.addAttribute("device", device);
        model.addAttribute("deviceRentAtt", deviceRentAtt);

        model.addAttribute("deviceRentAtt", resul.get("deviceRentAtt"));
        model.addAttribute("pi",  resul.get("pi"));

        return "student/stFacility";
    }
//
//   @GetMapping("/stFacility.cl")
//    public String selectAttendList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, Model model) {
//        Map<String, Object> result = facilityService.getAttendList(currentPage);
//
//        model.addAttribute("deviceRentAtt", result.get("deviceRentAtt"));
//        model.addAttribute("pi",  result.get("pi"));
//
//        return "student/stFacility";
//    }

    @GetMapping("/getDeviceCards") // 완료
    @ResponseBody
    public Map<String, Object> getDeviceCards(@RequestParam(value="cpage", defaultValue="1") int currentPage) {
        Map<String, Object> result = facilityService.getBoardList(currentPage);

        List<DeviceRentAtt> list = (List<DeviceRentAtt>) result.get("list");
        list.forEach(d -> {
            Member m = memberMapper.selectMemberByNo(d.getMemberNo());
            d.setMemberName(m.getMemberName());
        });

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("pi", result.get("pi"));
        return map;
    }

    @PostMapping("/updateDeviceStatus") // 완료
    @ResponseBody
    public String updateDeviceStatus(@RequestParam int deviceRentAttId,
                                     @RequestParam String status) {

        int result = facilityService.updateDeviceStatus(deviceRentAttId, status);
        if (result <= 0) return "0";

        if ("APPROVAL".equals(status)) {
            boolean approved = facilityService.approveDeviceRent(deviceRentAttId);
            if (!approved) return "0";
        }

        return "1";
    }


    @GetMapping("/getDeviceStatus") // 완료
    @ResponseBody
    public List<Device> getDeviceStatus() {
        // DEVICE_COUNT는 그대로, 남은 개수만 계산
        return facilityService.getDeviceListWithRemain();
    }








}
