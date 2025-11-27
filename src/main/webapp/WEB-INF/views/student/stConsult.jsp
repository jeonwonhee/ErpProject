<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 상담신청</title>
        <link rel="stylesheet" href="/styles/default.css" />
        <link rel="stylesheet" href="/styles/style.css" />
        <link rel="stylesheet" href="/styles/student.css" />
    </head>

    <body class="student student-consult">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />
        <!-- 메인 -->
        <main class="main">
            <c:set var="pageName" value="상담신청" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content consult">
                <!-- 상담신청 폼 -->
                <div class="card consult-form">
                    <h2>상담 신청</h2>

                    <form action="${pageContext.request.contextPath}/consult.at" method="post">
                        <div class="form-group">
                            <label>상담 주제</label>
                            <select name="topic">
                                <option>진로 상담</option>
                                <option>학습 상담</option>
                                <option>생활 상담</option>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-col">
                                <label>희망 날짜</label>
                                <input type="date" name="date" required min="2025-01-01" max="2099-12-31"/>
                            </div>
                            <div class="form-col">
                                <label>희망 시간</label>
                                <input type="time" name="time" required min="09:00" max="18:00"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>상세 내용</label>
                            <textarea name="content" placeholder="상담 요청 내용을 입력하세요"  maxlength="150"></textarea>
                        </div>

                        <div class="form-submit">
                            <button class="btn-submit" type="submit">신청</button>
                        </div>
                    </form>
                </div>

                <!-- 신청 내역 -->
                <div class="card consult-history">
                    <h2>신청내역</h2>

                    <table>
                        <thead>
                        <tr>
                            <th>기간</th>
                            <th>사유</th>
                            <th>제출일</th>
                            <th>승인상태</th>
                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${consultApplicationList}">
                                <tr>
                                    <td><fmt:formatDate value="${r.consultTime}" pattern="yyyy-MM-dd" /></td>
                                    <td>${r.consultAppContent}</td>
                                    <td>${r.createTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status == 'REQUESTED'}">
                                                <span class="status pending">신청</span>
                                            </c:when>
                                            <c:when test="${r.status == 'APPROVED'}">
                                                <span class="status approved">승인</span>
                                            </c:when>
                                            <c:when test="${r.status == 'REJECTED'}">
                                                <span class="status rejected">반려</span>
                                            </c:when>
                                            <c:when test="${r.status == 'DONE'}">
                                                <span class="status approved">완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status">${r.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>
