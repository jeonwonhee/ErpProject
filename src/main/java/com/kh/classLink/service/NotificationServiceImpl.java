package com.kh.classLink.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.classLink.model.mapper.NotificationMapper;
import com.kh.classLink.model.vo.Notification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
public class NotificationServiceImpl implements NotificationService {

    private NotificationMapper notificationMapper;
    public NotificationServiceImpl(NotificationMapper notificationMapper) {
        this.notificationMapper = notificationMapper;
    }

    /**
     * 안 읽은 알람 조회
     * @param memberNo
     * @return
     */
    @Override
    public Map<String, Object> selectNotiToMember(int memberNo) {
        ArrayList<Notification> result = notificationMapper.selectNotiToMember(memberNo);

        String resultJson = "";
        Map<String, Object> map = new HashMap<>();
        if (!result.isEmpty()) {
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                resultJson = objectMapper.writeValueAsString(result);
            } catch (Exception e) {
                e.printStackTrace();
            }

            map.put("notiList", resultJson);

            map.put("result", "1");
        } else {
            map.put("result", "0");
        }


        return map;
    }

    /**
     * 알림 읽음 처리
     * @param notification
     * @return
     */
    @Override
    public int readNoti(Notification notification) {
        int result =  notificationMapper.readNoti(notification);
        return result;
    }
}
