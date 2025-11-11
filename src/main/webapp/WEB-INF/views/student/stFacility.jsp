<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 기자재 신청</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/student.css">
        <link rel="stylesheet" href="/styles/common.css">
    </head>
    <body class="student student-facility" >
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="facility-container">
                    <!-- 기자재 신청 폼 -->
                    <div class="card">
                        <h2>기자재 신청</h2>
                        <form action="${pageContext.request.contextPath}/device.in" method="post">
                            <div class="form-group">
                                <label for="deviceType">기자재 종류</label>
                                <select id="deviceType" name="deviceId">
                                    <option value="">선택하세요</option>
                                    <c:forEach var="device" items="${device}">
                                        <option value="${device.deviceId}">${device.deviceKind}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="deviceCount">신청 수량</label>
                                <input type="number" id="deviceCount" name="attendAmount" min="0" max="100" placeholder="1" />
                            </div>

                            <div class="form-group">
                                <label for="endTime">반납 예정일</label>
                                <input type="date" id="endTime" name="endTime" required />
                            </div>

                            <div class="form-submit">
                                <button type="submit" class="btn-submit">신청하기</button>
                            </div>
                        </form>
                    </div>

                    <!-- 기자재 신청 내역 -->
                    <div class="card facility-history">
                        <h2>신청 내역</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>기자재명</th>
                                    <th>수량</th>
                                    <th>신청일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="r" items="${deviceRentAtt}">
                                <tr>
                                    <td>${r.deviceKind}</td>
                                    <td>${r.attendAmount}</td>
                                    <td>${r.createTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status == 'WAIT'}">
                                                <span class="status pending">대기중</span>
                                            </c:when>
                                            <c:when test="${r.status == 'APPROVAL'}">
                                                <span class="status approved">승인</span>
                                            </c:when>
                                            <c:when test="${r.status == 'RETURN'}">
                                                <span class="status rejected">반려</span>
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
                        <div class="pagination">

                            <c:if test="${pi.currentPage > 1}">
                                <button class="btn btn-primary"
                                        onclick="location.href='${pageContext.request.contextPath}/stFacility.co?cpage=${pi.currentPage - 1}'">
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
                                                onclick="location.href='${pageContext.request.contextPath}/stFacility.co?cpage=${i}'">
                                                ${i}
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${pi.currentPage < pi.maxPage}">
                                <button class="btn btn-primary"
                                        onclick="location.href='${pageContext.request.contextPath}/stFacility.co?cpage=${pi.currentPage + 1}'">
                                    다음 &gt;
                                </button>
                            </c:if>

                        </div>


                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
