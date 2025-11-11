package com.kh.classLink.service;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Notice;
import com.kh.classLink.model.vo.NoticeFile;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface NoticeService {

    /**
     * 공지사항 리스트
     * @return
     */
    public Map<String,Object> selectNoticeList(int currentPage,String noticeType,int memberNo, String role);


    /**
     * 반 별 공지사항
     * @return
     */
    public ArrayList<Class> selectNoticeClassList();


    /**
     * 공지사항 등록
     * @param notice
     * @return
     */
    public int insertNotice(Notice notice, MultipartFile file, String[] classNoList);

    /**
     * 공지사항 상세보기
     * @param noticeNo
     * @return
     */
    public Map<String,Object> selectNoticeByNoticeNo(int noticeNo);
    
    /**
     * 공지사항 수정
     * @param notice
     * @param file
     * @return
     */
    public int updateNotice(Notice notice, MultipartFile file,String[] classNoList);

    /**
     * 공지사항 삭제
     * @param noticeNo
     * @return
     */
    public int deleteNotice(int noticeNo);

}
