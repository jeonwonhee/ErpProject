package com.kh.classLink.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Lecture {
    private int lectureNo;
    private String lectureName;
    private int memberNo;

    private String memberName;
}
