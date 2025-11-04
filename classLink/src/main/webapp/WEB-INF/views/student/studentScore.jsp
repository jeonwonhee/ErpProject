<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 성적조회</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-score">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content score">
      <div class="card score-card">
        <h2>학생 성적 조회</h2>

        <div class="student-info">
          <p><b>이름</b> 김정훈</p>
          <div class="subject-select">
            <label for="subject"><b>과목 선택</b></label>
            <select id="subject">
              <option>Java</option>
              <option>SQL</option>
              <option>HTML/CSS</option>
              <option>Spring</option>
            </select>
          </div>
        </div>

        <div class="score-result">
          <p class="subject-title">SQL 성적</p>
          <p class="score-value">점수 : <span>80점</span></p>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
