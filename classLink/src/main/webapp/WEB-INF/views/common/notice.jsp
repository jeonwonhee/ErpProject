<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lecture.css">
</head>
<body class="lecture lecture-notice">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
    <header class="topbar">
      <div class="path">강사 › 공지사항 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <div class="notice-panel">
        <h3>공지사항</h3>

        <!-- 공지사항 테이블 -->
        <table class="notice-table">
          <thead>
            <tr>
              <th>제목</th>
              <th>작성일</th>
              <th>작성자</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>팀프로젝트 관련 공지</td>
              <td>10/19</td>
              <td>관리자</td>
            </tr>
            <tr>
              <td>상담 신청 방법</td>
              <td>10/15</td>
              <td>강사</td>
            </tr>
            <tr>
              <td>출결 처리 지침 안내</td>
              <td>10/10</td>
              <td>관리자</td>
            </tr>
            <tr>
              <td>만족도 조사 일정 공지</td>
              <td>10/01</td>
              <td>관리자</td>
            </tr>
          </tbody>
        </table>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button class="page-btn active">1</button>
          <button class="page-btn">2</button>
          <button class="page-btn">3</button>
          <button class="page-btn">4</button>
          <button class="page-btn">5</button>
        </div>

        <!-- 글쓰기 버튼 -->
        <div class="notice-footer">
          <button class="btn-write">글쓰기</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
