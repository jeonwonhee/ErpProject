package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Notification;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface NotificationMapper {

    /**
     * 안 읽은 알람 조회
     * @param memberNo
     * @return
     */
    ArrayList<Notification> selectNotiToMember(int memberNo);

    /**
     * 알림 읽음 처리
     * @param notification
     * @return
     */
    int readNoti(Notification notification);

    /**
     * 알람 갯수 조회
     * @param memberNo
     * @return
     */
    int selectNotiCountByMember(int memberNo);

    /**
     * 알람 발생
     * @param notification
     * @return
     */
    int insertNoti(Notification notification);

}
