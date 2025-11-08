<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 출결관리</title>

  <link rel="stylesheet" href="styles/default.css">
  <link rel="stylesheet" href="styles/style.css">
  <link rel="stylesheet" href="styles/lecture.css">
</head>

<body class="lecture lecture-attendance">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
    <header class="topbar">
      <div class="path">강사 › 출결관리 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <!-- 출결 박스 -->
      <div class="class-select">
            <label for="classSelect">반 : </label>
            <select name="classSelect" onchange="changeClass()" id="selectClass">
                <option value="1">A반</option>
                <option value="2">B반</option>
                <option value="3">C반</option>
                <option value="4">D반</option>
            </select>
        </div>
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
          <button type="button" class="btn-submit">적용</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
