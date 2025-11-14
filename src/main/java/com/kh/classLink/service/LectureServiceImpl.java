package com.kh.classLink.service;

import com.kh.classLink.model.mapper.LectureMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LectureServiceImpl implements LectureService {

    private final LectureMapper lectureMapper;

    @Override
    public int getLectureNoByMemberNo(int memberNo) {
        return lectureMapper.selectLectureNoByMemberNo(memberNo);
    }
}