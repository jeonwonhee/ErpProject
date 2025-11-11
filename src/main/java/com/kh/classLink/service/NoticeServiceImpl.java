package com.kh.classLink.service;

import com.kh.classLink.model.vo.Class;
import com.kh.classLink.model.vo.NoticeFile;
import com.kh.classLink.model.vo.PageInfo;
import com.kh.classLink.service.NoticeService;
import com.kh.classLink.model.mapper.NoticeMapper;
import com.kh.classLink.model.vo.Notice;
import com.kh.classLink.utils.FileUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {

    private final NoticeMapper noticeMapper;
    @Autowired
    public NoticeServiceImpl(NoticeMapper noticeMapper) {
        this.noticeMapper = noticeMapper;
    }


    /**
     * 공지사항 리스트
     * @param currentPage
     * @return
     */
    @Override
    public Map<String,Object> selectNoticeList(int currentPage,String noticeType,int memberNo,String role) {
        Notice notice = new Notice();
        notice.setMemberNo(memberNo);
        notice.setRole(role);
        int noticeCount = noticeMapper.selectNoticeCnt(notice);
        System.out.println(noticeCount);
        PageInfo pi = new PageInfo(currentPage, noticeCount, 5, 5);
        int offset = (currentPage - 1) * pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        ArrayList<Notice> noticeList = noticeMapper.selectNoticeList(rowBounds,notice);
        Map<String,Object> map = new HashMap<>();
        map.put("noticeList",noticeList);
        map.put("pi",pi);
        
        return map;
    }

    /**
     * 반별 공지사항
     * @return
     */
    @Override
    public ArrayList<Class> selectNoticeClassList() {
        ArrayList<Class> classList = noticeMapper.selectNoticeClassList();
        return classList;
    }

    /**
     * 공지사항 등록
     * @param notice
     * @return
     */
    @Override
    @Transactional
    public int insertNotice(Notice notice, MultipartFile file,String[] classNoList) {
        int result = 0;
        //공지 타입이 반 별 공지 일 경우
        String noticeType = notice.getNoticeType();
        System.out.println("noticeType:"+noticeType);
        String filePath ="C:/workspace/ErpProject/src/main/webapp/resources/noticeFile/";
        if (noticeType.equals("CLASS")) {
            String savedFileName = null;
            //UI에서 선택한 반의 갯수 만큼 반복
            for (int i=0; i<classNoList.length; i++) {
                int classNo = Integer.parseInt(classNoList[i]);

                notice.setClassNo(classNo);

                noticeMapper.insertNotice(notice);
                result ++;

                if (result > 0 && file != null && !file.isEmpty()) {
                    NoticeFile nf =  new NoticeFile();
                    nf.setNoticeNo(notice.getNoticeNo());
                    nf.setNoticeFileOriName(file.getOriginalFilename());

                    nf.setFilePath("resources/noticeFile/");

                    // 첫 번째 반복일 때만 실제 저장
                    if (i == 0) {
                        savedFileName = FileUtils.saveFile(file, filePath);
                        nf.setNoticeFileName(savedFileName);
                        // 두 번째 이후부터는 기존 파일을 복제
                    } else {
                        String copiedName = FileUtils.copyFile(filePath, savedFileName);
                        nf.setNoticeFileName(copiedName);
                    }


                    noticeMapper.insertNoticeFile(nf);
                    result ++;
                }
            }
        } else {
            result = noticeMapper.insertNotice(notice);

            if (result > 0 && file != null && !file.isEmpty()) {
                NoticeFile nf =  new NoticeFile();
                nf.setNoticeNo(notice.getNoticeNo());
                nf.setNoticeFileOriName(file.getOriginalFilename());

                nf.setFilePath("resources/noticeFile/");
                nf.setNoticeFileName(FileUtils.saveFile(file,filePath));

                result = noticeMapper.insertNoticeFile(nf);
            }
        }



        return result;
    }

    /**
     * 공지사항 상세보기
     * @param noticeNo
     * @return
     */
    @Override
    public Map<String, Object> selectNoticeByNoticeNo(int noticeNo) {
        Notice notice = noticeMapper.selectNoticeByNoticeNo(noticeNo);
        ArrayList<NoticeFile> fileList = noticeMapper.selectNoticeFileList(noticeNo);

        Map<String,Object> map = new HashMap<>();
        map.put("notice",notice);
        map.put("fileList",fileList);
        return map;
    }


    /**
     * 공지사항 수정
     * @param notice
     * @param file
     * @return
     */
    @Override
    @Transactional
    public int updateNotice(Notice notice, MultipartFile file, String[] classNoList) {
        int result = 0;
        //기존 파일 호출
        ArrayList<NoticeFile> fileList = noticeMapper.selectNoticeFileList(notice.getNoticeNo());
        String noticeType = notice.getNoticeType();
        String filePath ="C:/workspace/ErpProject/src/main/webapp/resources/noticeFile/";
        //반별 공지사항으로 수정시
        if (noticeType.equals("CLASS")) {
            String savedFileName = null;
            for (int i=0; i<classNoList.length; i++) {
                int classNo = Integer.parseInt(classNoList[i]);
                notice.setClassNo(classNo);
                System.out.println("notice::::"+notice);
                if (i == 0) {
                    result = noticeMapper.updateNotice(notice);
                } else {
                    result = noticeMapper.insertNotice(notice);
                }

                //CLASS타입 선택시 신규 파일등록시
                if (result > 0 && file != null && !file.isEmpty()) {
                    NoticeFile nf =  new NoticeFile();
                    nf.setNoticeNo(notice.getNoticeNo());
                    nf.setNoticeFileOriName(file.getOriginalFilename());

                    nf.setFilePath("resources/noticeFile/");

                    // 첫 번째 반복일 때만 실제 저장
                    if (i == 0) {
                        savedFileName = FileUtils.saveFile(file, filePath);
                        nf.setNoticeFileName(savedFileName);
                        //기존 등록된 파일이 있을시 업데이트
                        if (fileList != null && !fileList.isEmpty()) {
                            noticeMapper.updateNoticeFile(nf);
                        } else {
                            noticeMapper.insertNoticeFile(nf);
                        }
                        // 두 번째 이후부터는 기존 파일을 복제
                    } else {
                        String copiedName = FileUtils.copyFile(filePath, savedFileName);
                        nf.setNoticeFileName(copiedName);
                        noticeMapper.insertNoticeFile(nf);
                    }


                    result ++;
                    //CLASS타입 선택시 신규파일은 없지만 기존 파일 존재시
                } else if(result > 0 && fileList!= null && !fileList.isEmpty()) {
                    if (i >0) {
                        NoticeFile nf =  new NoticeFile();
                        nf.setNoticeNo(notice.getNoticeNo());
                        nf.setNoticeFileOriName(fileList.get(0).getNoticeFileOriName());
                        nf.setFilePath("resources/noticeFile/");

                        Path source = Paths.get(filePath, fileList.get(0).getNoticeFileName());
                        Path target = Paths.get(filePath, "copy_" + fileList.get(0).getNoticeFileName());
                        try {
                            Files.copy(source, target, StandardCopyOption.REPLACE_EXISTING);
                            nf.setNoticeFileName(FileUtils.copyFile(filePath, fileList.get(0).getNoticeFileName()));
                            noticeMapper.insertNoticeFile(nf);

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }




                }


            }
        } else {
            //CLAAS외 타입 선택시
            result = noticeMapper.updateNotice(notice);
            //새로운 파일 있다면 update or insert
            if (result > 0 && file != null && !file.isEmpty()) {
                NoticeFile nf =  new NoticeFile();
                nf.setNoticeNo(notice.getNoticeNo());
                nf.setNoticeFileOriName(file.getOriginalFilename());
                nf.setFilePath("resources/noticeFile/");
                nf.setNoticeFileName(FileUtils.saveFile(file, filePath));
                //기존 파일 존재시
                if (fileList != null && !fileList.isEmpty()) {
                    result = noticeMapper.updateNoticeFile(nf);
                    //기존 파일 없을시
                } else {
                    result = noticeMapper.insertNoticeFile(nf);
                }

            }
        }

        //새로운 파일이 등록되었을시 기존 파일을 경로에서 삭제
        if (file != null && !file.isEmpty()) {
            if (fileList != null && !fileList.isEmpty()) {
                for (NoticeFile old : fileList) {
                    File oldFile = new File(filePath + old.getNoticeFileName());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
            }
        }

        return result;
    }

    /**
     * 공지사항 삭제
     * @param noticeNo
     * @return
     */
    @Override
    @Transactional
    public int deleteNotice(int noticeNo) {
        int result = 1;
        ArrayList<NoticeFile> fileList = noticeMapper.selectNoticeFileList(noticeNo);

        String filePath ="C:/workspace/ErpProject/src/main/webapp/resources/noticeFile/";
        if (fileList != null && fileList.size() > 0) {
            for (int i = 0; i < fileList.size(); i++) {
                File oldFile = new File(filePath + fileList.get(i).getNoticeFileName());

                if (oldFile.exists()) {
                    oldFile.delete();
                    result = noticeMapper.deleteNoticeFile(noticeNo,fileList.get(i).getNoticeFileNo());
                }
            }
        }
        if (result > 0) {
            result = noticeMapper.deleteNotice(noticeNo);
        }

        return result;
    }


}
