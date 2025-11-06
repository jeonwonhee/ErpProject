<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 마이페이지</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-mypage">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content mypage">
      <div class="card mypage-card">
        <h2>마이페이지</h2>

        <form>
          <!-- 이름 -->
          <div class="form-group">
            <label>이름</label>
            <input type="text" placeholder="이름을 입력하세요" />
          </div>

          <!-- 생년월일 -->
          <div class="form-group">
            <label>생년월일</label>
            <div class="birth-row">
              <select><option>년도</option></select>
              <select><option>월</option></select>
              <select><option>일</option></select>
            </div>
          </div>

          <!-- 전화번호 -->
          <div class="form-group">
            <label>전화번호</label>
            <input type="tel" placeholder="예: 010-1234-5678" />
          </div>

          <!-- 과정명 -->
          <div class="form-group">
            <label>과정명</label>
            <input type="text" placeholder="과정명을 입력하세요" />
          </div>

          <div class="form-buttons">
            <button type="button" class="btn-edit">수정하기</button>
            <button type="button" class="btn-delete">탈퇴하기</button>
          </div>
        </form>
      </div>
    </section>
  </main>
</body>
</html>
