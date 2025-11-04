<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 상담관리</title>

  <!-- 기존 공통 css -->
  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/lecture.css">
</head>
<body class="lecture lecture-consult">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <main class="main">
    <header class="topbar">
      <div class="path">강사 › 상담관리 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <div class="consult-panel">
        <h3>상담 승인 요청</h3>

        <div class="consult-list">
          <!-- 카드 예시 -->
          <div class="consult-card">
            <div class="consult-main">
              <div class="consult-info">
                <p><b>학생:</b> 이새봄</p>
                <p><b>신청일:</b> 11/8</p>
                <p><b>사유:</b> 성적</p>
              </div>
              <span class="consult-status pending">승인 대기</span>
            </div>
          </div>

          <div class="consult-card">
            <div class="consult-main">
              <div class="consult-info">
                <p><b>학생:</b> 김하늘</p>
                <p><b>신청일:</b> 11/8</p>
                <p><b>사유:</b> 진로</p>
              </div>
              <span class="consult-status pending">승인 대기</span>
            </div>
          </div>

          <!-- 여러 카드 반복 -->
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="page-btn active">1</button>
          <button class="page-btn">2</button>
          <button class="page-btn">3</button>
          <button class="page-btn">4</button>
          <button class="page-btn">5</button>
          <button class="page-btn">6</button>
          <button class="page-btn">7</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
