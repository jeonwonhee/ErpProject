<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 문의 작성</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-inquiry-write">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content inquiry-write">
      <div class="card write-card">
        <h2>문의하기</h2>

        <form class="inquiry-form">
          <!-- 분류 -->
          <div class="form-group">
            <label for="category">분류</label>
            <select id="category">
              <option>성적관련</option>
              <option>출결관련</option>
              <option>상담관련</option>
              <option>기타문의</option>
            </select>
          </div>

          <!-- 제목 -->
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" placeholder="제목을 입력하세요." />
          </div>

          <!-- 내용 -->
          <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" placeholder="문의 내용을 남겨주세요."></textarea>
          </div>

          <!-- 버튼 -->
          <div class="btn-area">
            <button type="button" class="btn-submit" onclick="submitInquiry()">등록</button>
          </div>
        </form>
      </div>
    </section>
  </main>

  <script>
    function submitInquiry() {
      const category = document.getElementById("category").value.trim();
      const title = document.getElementById("title").value.trim();
      const content = document.getElementById("content").value.trim();

      if (!title || !content) {
        alert("제목과 내용을 모두 입력해주세요.");
        return;
      }

      alert("문의가 등록되었습니다.");
      window.location.href = "student-inquiry.html"; // 문의 목록으로 이동
    }
  </script>
</body>
</html>
