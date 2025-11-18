<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:set var="pageName" value="문의" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content inquiry">
                <div class="card">
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
                            <c:forEach var="question" items="${questionList}">
                                <tr onclick="location.href='${pageContext.request.contextPath}/stQuestionDetail.co?questionNo=${question.questionNo}'">
                                    <td>${question.questionTitle}</td>
                                    <td>${question.createDate}</td>
                                    <c:choose>
                                        <c:when test="${question.questionStatus eq '대기'}">
                                            <td><span class="status pending">${question.questionStatus}</span></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><span class="status done">${question.questionStatus}</span></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- 페이지네이션 -->
                    <div class="pagination">
                        <c:if test="${pi.currentPage > 1}">
                            <button class="btn btn-primary"
                                    onclick="location.href='${pageContext.request.contextPath}/stQuestion.co?currentPage=${pi.currentPage - 1}'">
                                &lt; 이전
                            </button>
                        </c:if>

                        <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                            <c:choose>
                                <c:when test="${i == pi.currentPage}">
                                    <button class="btn btn-outline-primary" disabled>
                                            ${i}
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-outline-primary"
                                            onclick="location.href='${pageContext.request.contextPath}/stQuestion.co?currentPage=${i}'">
                                            ${i}
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${pi.currentPage < pi.maxPage}">
                            <button class="btn btn-primary"
                                    onclick="location.href='${pageContext.request.contextPath}/stQuestion.co?currentPage=${pi.currentPage + 1}'">
                                다음 &gt;
                            </button>
                        </c:if>
                    </div>

                    <!-- 글쓰기 버튼 -->
                    <div class="inquiry-write">
                      <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/stQuestionWrite.co'">글쓰기</button>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
