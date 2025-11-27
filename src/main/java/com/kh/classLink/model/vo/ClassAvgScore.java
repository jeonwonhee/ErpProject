package com.kh.classLink.model.vo;

public class ClassAvgScore {

    private String className;
    private double avgGrade;
    private int studentCount; // 반 인원수

    public ClassAvgScore() {}

    public ClassAvgScore(String className, double avgGrade, int studentCount) {
        this.className = className;
        this.avgGrade = avgGrade;
        this.studentCount = studentCount;
    }

    public String getClassName() {
        return className;
    }

    public double getAvgGrade() {
        return avgGrade;
    }

    public int getStudentCount() {
        return studentCount;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public void setAvgGrade(double avgGrade) {
        this.avgGrade = avgGrade;
    }

    public void setStudentCount(int studentCount) {
        this.studentCount = studentCount;
    }

    @Override
    public String toString() {
        return "ClassAvgScore{" +
                "className='" + className + '\'' +
                ", avgGrade=" + avgGrade +
                ", studentCount=" + studentCount +
                '}';
    }
}