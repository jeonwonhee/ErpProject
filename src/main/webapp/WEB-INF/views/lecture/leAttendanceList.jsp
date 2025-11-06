<!-- === 강사 출결정정 페이지 (상태 오른쪽으로 이동 및 크기 확장) === -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KH EduERP | 강사 출결정정 처리</title>

  <link rel="stylesheet" href="styles\default.css">
  <link rel="stylesheet" href="styles\style.css">
  <link rel="stylesheet" href="styles\lecture.css">
</head>
<body class="lecture lecture-attendance-list">
  <div class="teacher-attendance-page kh-container">
      <!-- 사이드바 -->
      <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

    <main class="main">
      <header class="topbar">
        <div class="path">강사 &gt; 출결정정 처리 <b>강사 페이지</b></div>
        <div class="user-info">
            <span class="alert">알림(2)</span>
            <span class="user">김강사(강사)</span>
        </div>
      </header>

      <section class="content">
        <div class="card">
          <h2>정정 요청 목록</h2>
          <div class="lecture-request-list">

            <div class="card lecture-request-card" onclick="location.href='${pageContext.request.contextPath}/leAttendanceCorrection.co'">
              <div class="lecture-request-main">
                <div class="lecture-request-info">
                  <strong>이새봄</strong>
                  <div class="lecture-request-details">
                    날짜: 11/08 | 사유: 지하철 지연 | 증빙: 첨부
                  </div>
                </div>
                <span class="status-tag">대기</span>
              </div>
            </div>

            <div class="card lecture-request-card">
              <div class="lecture-request-main">
                <div class="lecture-request-info">
                  <strong>정가을</strong>
                  <div class="lecture-request-details">
                    날짜: 11/02 | 사유: 병원 진료 | 증빙: 진단서
                  </div>
                </div>
                <span class="status-tag">대기</span>
              </div>
            </div>

          </div>
        </div>
      </section>
    </main>
  </div>
</body>
</html>
