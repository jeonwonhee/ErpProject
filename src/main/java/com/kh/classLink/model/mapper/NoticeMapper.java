package com.kh.classLink.model.mapper;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.Notice;
import com.kh.classLink.model.vo.NoticeFile;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;


@Mapper
public interface NoticeMapper {

    /**
     * 공지사항 리스트
     * @return
     */
    ArrayList<Notice> selectNoticeList(RowBounds rowBounds,Notice notice);

    /**
     * 반별 공지사항
     * @return
     */
    ArrayList<Class> selectNoticeClassList();

    /**
     * 공지사항 갯수
     * @return
     */
    int selectNoticeCnt(Notice notice);

    /**
     * 공지사항 등록
     * @param notice
     * @return
     */
    int insertNotice(Notice notice);

    /**
     * 공지사항 상세보기
     * @param noticeNo
     * @return
     */
    Notice selectNoticeByNoticeNo(int noticeNo);

    /**
     * 공지사항 수정
     * @param notice
     * @return
     */
    int updateNotice(Notice notice);

    /**
     * 공지사항 삭제
     * @param notice
     * @return
     */
    int deleteNotice(int noticeNo);

    /**
     * 공지사항 파일 등록
     * @param noticeFile
     * @return
     */
    int insertNoticeFile(NoticeFile noticeFile);

    /**
     * 공지사항 파일 수정
     * @param noticeFile
     * @return
     */
    int updateNoticeFile(NoticeFile noticeFile);

    /**
     * 공지사항 첨부파일 조회
     * @param noticeNo
     * @return
     */
    ArrayList<NoticeFile> selectNoticeFileList(int noticeNo);

    /**
     * 공지사항 첨부파일 삭제
     * @param noticeNo
     * @param noticeFileNo
     * @return
     */
    int deleteNoticeFile(int noticeNo, int noticeFileNo);
}
