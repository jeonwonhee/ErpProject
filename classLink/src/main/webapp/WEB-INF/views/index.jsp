<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 출결관리</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lecture.css">
</head>
<body class="lecture lecture-attendance">
  <!-- 사이드바 -->
  <aside class="sidebar">
    <div>
      <div class="logo">
        <span>KH EduERP</span>
      </div>
      <ul class="menu">
        <li>학생관리</li>
        <li class="active">출결관리</li>
        <li>일정관리</li>
        <li>상담관리</li>
        <li>출결정정 처리</li>
        <li>만족도 결과</li>
        <li>공지사항</li>
        <li>문의</li>
      </ul>
    </div>
    <footer>© 2025 KH</footer>
  </aside>

  <!-- 메인 -->
  <main class="main">
    <header class="topbar">
      <div class="path">강사 › 출결관리 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <!-- 출결 박스 -->
      <div class="attendance-panel">
        <div class="attendance-head">
          <div class="attendance-info">
            <p>출결 날짜 : <b>2025-10-05</b></p>
            <p>과목 : <b>AWS</b></p>
            <p>인원 수 : <b>25</b></p>
          </div>
          <div class="attendance-bulk">
            <span class="bulk-title">(일괄처리)</span>
            <div class="bulk-btns">
              <button type="button" class="att-btn">출석</button>
              <button type="button" class="att-btn">지각</button>
              <button type="button" class="att-btn">결석</button>
              <button type="button" class="att-btn">조회</button>
            </div>
          </div>
        </div>

        <div class="attendance-list">
          <!-- 한 줄 -->
          <div class="attendance-row">
            <div class="attendance-stu">
              <span class="stu-name">유학생</span>
              <span class="stu-class">AWS</span>
            </div>
            <div class="attendance-actions">
              <button type="button" class="att-btn">출석</button>
              <button type="button" class="att-btn">지각</button>
              <button type="button" class="att-btn">결석</button>
              <button type="button" class="att-btn">조회</button>
            </div>
          </div>
          <!-- 필요한 만큼 반복 -->
        </div>

        <div class="attendance-footer">
          <button type="button" class="apply-btn">적용</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>

