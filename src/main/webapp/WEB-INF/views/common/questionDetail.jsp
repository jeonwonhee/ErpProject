<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 문의 상세보기</title>

  <link rel="stylesheet" href="styles/default.css">
  <link rel="stylesheet" href="styles/style.css">
  <link rel="stylesheet" href="styles/common.css">
</head>
<body class="common question-detail">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <c:set var="pageName" value="문의" scope="request"></c:set>
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="card has-answer">
        <!-- 상단 -->
        <div class="question-header">
          <input type="text" value="성적관련" readonly>
          <input type="text" value="작성일 : 10/05" readonly class="align-right">
        </div>

        <!-- 본문 -->
        <div class="question-body">
          <p class="meta">문의 : 유학생</p>
          <p class="text">
            고양이가 알람을 껐는데 봐주면 출석 정정 신청 되나요?
          </p>

          <div class="answer-box">
            <p class="meta">답변 : 강사 <span>답변일 : 10/06</span></p>
            <p class="text">
              고양이 사진 보내주면 봐드리겠습니다.
            </p>
          </div>
        </div>

        <!-- 하단 -->
        <div class="question-footer">
          <button class="btn-back" onClick = "location.href='${pageContext.request.contextPath}/questionManage.co'">뒤로가기</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
