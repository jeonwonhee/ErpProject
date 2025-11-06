<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항 상세보기</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/common.css">
</head>
<body class="common notice-detail">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="notice-detail-panel">
        <!-- 제목 영역 -->
        <div class="notice-header">
          <h2 class="notice-title">팀프로젝트 관련 공지</h2>
          <div class="notice-meta">
            <span>작성일: <b>2025-10-19</b></span>
            <span>작성자: <b>관리자</b></span>
          </div>
        </div>

        <!-- 본문 내용 -->
        <div class="notice-body">
          <p>
            안녕하세요. 팀프로젝트 관련하여 다음과 같이 공지드립니다.<br><br>
            📌 프로젝트 주제 제출 기한: <b>10월 25일(토)</b><br>
            📌 중간 점검 발표: <b>11월 2일(일)</b><br>
            📌 최종 발표 및 결과물 제출: <b>11월 15일(토)</b><br><br>
            각 팀은 일정에 맞춰 준비해주시기 바랍니다.  
            <br><br>감사합니다.
          </p>
        </div>

        <!-- 버튼 영역 -->
        <div class="notice-detail-footer">
          <button class="btn-list">목록</button>
          <div class="right-btns">
            <button class="btn-edit">수정</button>
            <button class="btn-delete">삭제</button>
          </div>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
