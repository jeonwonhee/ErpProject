package com.kh.classLink.model.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

/**
 * 이번달 출석 통계 데이터 VO
 */
@Data
public class AttendanceStats {

    private int attendCount; // 출석
    private int lateCount;   // 지각
    private int absentCount; // 결석

    public int getTotal() {
        return attendCount + lateCount + absentCount;
    }

    public int getRate() {
        if (getTotal() == 0) return 0;
        return (int) Math.round((attendCount * 100.0) / getTotal());
    }

    public int getAttendRate() {
        if (getTotal() == 0) return 0;
        return (int) Math.round((attendCount * 100.0) / getTotal());
    }

    public int getLateRate() {
        if (getTotal() == 0) return 0;
        return (int) Math.round((lateCount * 100.0) / getTotal());
    }

    public int getAbsentRate() {
        if (getTotal() == 0) return 0;
        return (int) Math.round((absentCount * 100.0) / getTotal());
    }
}