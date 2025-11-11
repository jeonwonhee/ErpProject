<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 일정관리</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </head>

    <body class="admin admin-calendar-manage">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content calendar-container">
                <div class="card">
                    <!-- 검색창 -->
                    <div class="search-box">
                        <input type="text" placeholder="검색" />
                        <button class="btn-submit">검색</button>
                    </div>

                    <!-- 일정 테이블 -->
                    <div class="calendar-table-section">
                        <table class="calendar-table">
                            <thead>
                                <tr>
                                <th>일정번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>상태</th>
                                <th>승인여부</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="a" items="${approvalList}">
                                    <tr class="clickable"
                                        onclick="location.href='${pageContext.request.contextPath}/adminCalenderDetail.co?lectureDateNo=${a.lectureDateNo}'">

                                        <td>${a.lectureDateNo}</td>
                                        <td>${a.title}</td>
                                        <td>${a.writer}</td>
                                        <td>${a.approvalDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${a.status eq 'IN_PROGRESS'}">
                                                    <span class="status processing">처리중</span>
                                                </c:when>
                                                <c:when test="${a.status eq 'APPROVED'}">
                                                    <span class="status received">접수</span>
                                                </c:when>
                                                <c:when test="${a.status eq 'REJECTED'}">
                                                    <span class="status rejected">반려</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status unknown">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${a.status eq 'APPROVED'}">
                                                    <span class="approved">승인</span>
                                                </c:when>
                                                <c:when test="${a.status eq 'REJECTED'}">
                                                    <span class="rejected">반려</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="pending">대기</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>

        <!-- ✅ Ajax 스크립트 추가 -->
        <script>
            // 승인/반려 버튼 클릭 시 호출되는 함수
            function updateApproval(lectureDateNo, status, reason = "") {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/adminCalenderManage.co", // 기존 URL 그대로
                    data: { lectureDateNo, status, reason },
                    success: function (res) {
                        if (res === "success") {
                            alert("처리 완료");
                            location.reload();
                        } else {
                            alert("처리 실패");
                        }
                    },
                    error: function () {
                        alert("서버 오류 발생");
                    }
                });
            }
        </script>
    </body>
</html>
