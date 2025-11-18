package com.kh.classLink.model.vo;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int memberNo;
    private String memberId;
    private String memberName;
    private String memberPassword;
    private LocalDate createDate;
    private LocalDate updateDate;
    private String status;
    private String email;
    private String phone;
    private String address;
    private String role;

    private LocalDate birthDate;
    private int vacCnt;

    private Integer attendRate;
    private Integer classNo;
    private String className;

    private Integer studentNo;
    private String studentName;

    private Integer lectureNo;
    private String lectureName;
    private String commuteRate;
    private String commuteMonth;
}

