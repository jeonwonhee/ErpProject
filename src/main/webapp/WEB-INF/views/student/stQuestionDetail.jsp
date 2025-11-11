<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
      <div class="card">
        <h2>문의 상세보기</h2>

        <!-- 문의 정보 -->
        <div class="inquiry-header">
          <p><b>제목 :</b>${question.questionTitle}</p>
          <div class="info-row">
            <span>작성일 : ${question.createDate}</span>
              <c:choose>
                  <c:when test="${question.questionStatus eq '대기'}">
                      <span>상태 : <span class="status pending">대기</span></span>
                  </c:when>
                  <c:otherwise>
                      <span>상태 : <span class="status done">답변</span></span>
                  </c:otherwise>
              </c:choose>

          </div>
        </div>

        <!-- 문의 내용 -->
        <div class="inquiry-body">
          <p>
            ${question.questionContent}
          </p>
        </div>

        <!-- 관리자 답변 -->
        <div class="inquiry-reply">
          <h3>관리자 답변</h3>
          <div class="reply-box">
            <p>
              ${question.answer}
            </p>
            <span class="reply-date">답변일 : ${question.updateDate}</span>
          </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="btn-area">
          <button class="btn-list" onclick="location.href='${pageContext.request.contextPath}/stQuestion.co'">목록으로</button>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
