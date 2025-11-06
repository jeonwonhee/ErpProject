<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 문의 상세</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-inquiry-detail">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content inquiry-detail">
      <div class="card inquiry-card">
        <h2>문의 상세보기</h2>

        <!-- 문의 정보 -->
        <div class="inquiry-header">
          <p><b>제목 :</b> 휴가 승인 지연 문의</p>
          <div class="info-row">
            <span>작성일 : 2025-10-19</span>
            <span>상태 : <span class="status pending">대기</span></span>
          </div>
        </div>

        <!-- 문의 내용 -->
        <div class="inquiry-body">
          <p>
            안녕하세요. 지난주에 휴가 신청을 했는데 아직 승인되지 않아 문의드립니다.<br />
            확인 부탁드립니다.
          </p>
        </div>

        <!-- 관리자 답변 -->
        <div class="inquiry-reply">
          <h3>관리자 답변</h3>
          <div class="reply-box">
            <p>
              안녕하세요, 홍길동님.<br />
              해당 건은 승인 절차가 진행 중이며 오늘 중으로 처리될 예정입니다.<br />
              감사합니다.
            </p>
            <span class="reply-date">답변일 : 2025-10-20</span>
          </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="btn-area">
          <button class="btn-list">목록으로</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
