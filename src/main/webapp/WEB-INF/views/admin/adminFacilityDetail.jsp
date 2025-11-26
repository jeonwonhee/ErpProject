<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 기자재 추가</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/admin.css">
</head>
<body class="admin admin-facility-detail">
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<main class="main">
    <c:set var="pageName" value="기자재 추가" scope="request"></c:set>
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

  <section class="content">
    <div class="card">
      <h2>기자재 추가</h2>

      <form action="${pageContext.request.contextPath}/insert.di" method="post">
        <div class="form-group">
          <label for="deviceName">기자재 명</label>
          <input type="text" id="deviceName" name="deviceKind" placeholder="기자재 명을 입력하세요" required maxlength="20">
        </div>

        <div class="form-group">
          <label for="deviceCount">수량</label>
          <input type="number" id="deviceCount" name="deviceCount" placeholder="수량을 입력하세요" min="1" required>
        </div>

        <div class="form-submit">
          <button type="submit" class="btn-submit">신청</button>
        </div>
      </form>
    </div>
  </section>
</main>
</body>
</html>
