<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 문의관리</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/common.css" />
</head>

<body class="common question-manage">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content inquiry-container">
      <!-- 검색창 -->
      <div class="search-box">
        <input type="text" placeholder="검색" />
        <button class="btn-search">검색</button>
      </div>

      <!-- 문의 테이블 -->
      <div class="inquiry-table-section">
        <table class="inquiry-table">
          <thead>
            <tr>
              <th>문의번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>등록일</th>
              <th>상태</th>
              <th>답변여부</th>
            </tr>
          </thead>
          <tbody>
            <tr class="clickable"
                data-title="수강 신청이 안돼요."
                data-writer="홍길동"
                data-date="2025-10-25"
                data-content="수강 신청을 눌러도 반응이 없습니다."
                data-status="접수"
                data-reply=""
                data-stage="미답변">
              <td>101</td>
              <td onClick = "location.href='${pageContext.request.contextPath}/questionDetail.co'">수강 신청 정정 문의</td>
              <td>홍길동</td>
              <td>2025-10-25</td>
              <td><span class="status received">접수</span></td>
              <td onClick = "location.href='${pageContext.request.contextPath}/questionEnrollForm.co'">미답변</td>
            </tr>
            <tr class="clickable"
                data-title="오류 문의"
                data-writer="김길동"
                data-date="2025-10-28"
                data-content="화면 로딩 중 오류가 발생합니다."
                data-status="처리중"
                data-reply="처리 중입니다."
                data-stage="답변완료">
              <td>102</td>
              <td>오류 문의</td>
              <td>김길동</td>
              <td>2025-10-28</td>
              <td><span class="status processing">처리중</span></td>
              <td>답변완료</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>

  </main>
</body>
</html>
