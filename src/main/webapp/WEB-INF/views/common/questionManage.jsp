<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="card">
                <!-- 검색창 -->
                <%--관리자는 불필요--%>
                <c:if test="${loginMember.role eq 'TEACHER'}">
                    <form action="${pageContext.request.contextPath}/questionManage.co" method="get">
                        <div class="search-box">

                            <select name="listType" id="listType" class="question-select">
                                <option value="QUESTION" ${listType eq 'QUESTION' ? 'selected' : ''}>내 질문</option>
                                <option value="ANSWER" ${listType eq 'ANSWER' ? 'selected' : ''}>답변</option>
                            </select>
                            <button class="btn-search">검색</button>


                        </div>
                    </form>
                </c:if>

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
                            </tr>
                        </thead>
                        <tbody>
                            <%--강사--%>
                            <c:forEach var="question" items="${questionList}">
                                <c:choose>
                                    <c:when test="${listType eq 'QUESTION'}">
                                        <tr onClick = "location.href='${pageContext.request.contextPath}/stQuestionDetail.co?questionNo=${question.questionNo}'">
                                    </c:when>
                                    <c:otherwise>
                                        <tr onClick = "location.href='${pageContext.request.contextPath}/questionEnrollForm.co?questionNo=${question.questionNo}'">
                                    </c:otherwise>
                                </c:choose>
                                    <td>${question.questionNo}</td>
                                    <td>${question.questionTitle}</td>
                                    <td>${question.questionMemberName}</td>
                                    <td>${question.createDate}</td>
                                    <c:choose>
                                        <c:when test="${question.questionStatus eq '대기'}">
                                            <td><span class="status received">${question.questionStatus}</span></td>
                                        </c:when>
                                        <c:otherwise>
                                            <td><span class="status processing">${question.questionStatus}</span></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>

                            <%--관리자--%> <%--문의 답변만 가능.--%>
                        </tbody>
                    </table>

                    <c:if test="${pi.currentPage > 1}">
                        <button class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/questionManage.co?currentPage=${pi.currentPage - 1}&listType=${listType}'">
                            &lt; 이전
                        </button>
                    </c:if>
                    <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                        <c:choose>
                            <c:when test="${i == pi.currentPage}">
                                <button class="page-btn" disabled>
                                        ${i}
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="page-btn"
                                        onclick="location.href='${pageContext.request.contextPath}/questionManage.co?currentPage=${i}&listType=${listType}'">
                                        ${i}
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pi.currentPage < pi.maxPage}">
                        <button class="btn btn-primary"
                                onclick="location.href='${pageContext.request.contextPath}/questionManage.co?currentPage=${pi.currentPage + 1}&listType=${listType}'">
                            다음 &gt;
                        </button>
                    </c:if>

                </div>
            </section>
        </main>
    </body>
</html>
