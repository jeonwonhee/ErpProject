package com.kh.classLink;

import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnectionTest {

    @Test
    void testConnection() {
        String url = "jdbc:oracle:thin:@localhost:1521/XEPDB1"; // ✅ 오라클 PDB 주소
        String user = "c##KHERP"; // ✅ 오라클 계정
        String password = "KHERP"; // ✅ 비밀번호

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("✅ DB 연결 성공!");
            System.out.println("DB Info: " + conn.getMetaData().getDatabaseProductVersion());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ DB 연결 실패...");
        }
    }
}