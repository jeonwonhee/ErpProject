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
<body class="common question-enroll-form">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="card has-answer">
        <!-- 상단 -->
        <div class="question-header">
          <input type="text" value="${question.questionType}" readonly>
            <input type="hidden" name="questionNo" value="${question.questionNo}">
          작성일 : <input type="text" value="${question.createDate}" readonly class="align-right">
        </div>

        <!-- 본문 -->
        <div class="question-body">
          <p class="meta">문의 : ${question.questionMemberName}</p>
          <p class="text">
            ${question.questionContent}
          </p>

        </div>
        <br>
        <form class="notice-form" action="${pageContext.request.contextPath}/questionAnswer.qu" method="post">
            <div class="form-group">
                <label for="content">답변 내용</label>
                <textarea id="content" name="answer" placeholder="내용을 입력하세요"></textarea>
            </div>

            <!-- 하단 -->
            <div class="question-footer">
                <button type="submit" class="btn-submit">등록하기</button>
            </div>
        </form>

      </div>
    </section>
  </main>
</body>
</html>
