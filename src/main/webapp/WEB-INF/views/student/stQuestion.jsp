<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 문의</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-inquiry">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content inquiry">
      <div class="card inquiry-card">
        <h2>문의 목록</h2>

        <table class="inquiry-table">
          <thead>
            <tr>
              <th>제목</th>
              <th>작성일</th>
              <th>상태</th>
            </tr>
          </thead>
          <tbody>
          <tr onclick="location.href='${pageContext.request.contextPath}/stQuestionDetail.co?studentInquiryDetailNo=1'">
              <td>휴가 승인 지연 문의</td>
              <td>10/19</td>
              <td><span class="status pending">대기</span></td>
            </tr>
            <tr>
              <td>상담 신청 방법</td>
              <td>10/7</td>
              <td><span class="status done">답변</span></td>
            </tr>
            <tr>
              <td>출석 정정 신청 방법</td>
              <td>10/3</td>
              <td><span class="status done">답변</span></td>
            </tr>
            <tr>
              <td>병결 관련 문의</td>
              <td>9/28</td>
              <td><span class="status done">답변</span></td>
            </tr>
          </tbody>
        </table>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <button>1</button>
          <button>2</button>
          <button>3</button>
          <button>4</button>
          <button>5</button>
        </div>

        <!-- 글쓰기 버튼 -->
        <div class="inquiry-write">
          <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/studentInquiryWrite.co'">글쓰기</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
