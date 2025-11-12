package com.kh.classLink.service;

import com.kh.classLink.model.vo.Notification;

import java.util.ArrayList;
import java.util.Map;

public interface NotificationService {

    /**
     * 안 읽은 알람 조회
     * @param memberNo
     * @return
     */
    public Map<String, Object> selectNotiToMember(int memberNo);

    /**
     * 알림 읽음 처리
     * @param notification
     * @return
     */
    public int readNoti(Notification notification);

    /**
     * 알람 갯수 조회
     * @param memberNo
     * @return
     */
    public int selectNotiCountByMember(int memberNo);

}
