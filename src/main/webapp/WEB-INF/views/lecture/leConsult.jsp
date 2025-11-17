<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 상담관리</title>

    <!-- 기존 공통 css -->
    <link rel="stylesheet" href="/styles/default.css">
    <link rel="stylesheet" href="/styles/style.css">
    <link rel="stylesheet" href="/styles/lecture.css">
</head>
<body class="lecture lecture-consult">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<main class="main">
    <header class="topbar">
        <div class="path">강사 › 상담관리 <b>강사 페이지</b></div>
        <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
        <div class="consult-panel">
            <h3>상담 승인 요청</h3>

            <div class="consult-list">

                <!-- 카드 예시 -->
                <c:forEach var="r" items="${consultApplicationList}">
                    <c:choose>
                        <c:when test="${r.status == 'REQUESTED'}">
                            <div class="card consult-card"
                                 onclick="location.href='${pageContext.request.contextPath}/lectureConsultCorrection.co?consultAppNo=${r.consultAppNo}'">
                                <div class="consult-main">
                                    <div class="consult-info">
                                        <p><b>학생:</b> ${r.memberName}</p>
                                        <p><b>신청일:</b> ${r.createTime}</p>
                                        <p><b>사유:</b> ${r.consultAppContent}</p>
                                    </div>
                                    <span class="consult-status pending">신청</span>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${r.status == 'APPROVED'}">
                            <div class="card consult-card"
                                 onclick="location.href='${pageContext.request.contextPath}/lectureConsultApprove.co?consultAppNo=${r.consultAppNo}'">
                                <div class="consult-main">
                                    <div class="consult-info">
                                        <p><b>학생:</b> ${r.memberName}</p>
                                        <p><b>신청일:</b> ${r.createTime}</p>
                                        <p><b>사유:</b> ${r.consultAppContent}</p>
                                    </div>
                                    <span class="consult-status approved">승인</span>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${r.status == 'DONE'}">
                            <div class="card consult-card">
                                <div class="consult-main">
                                    <div class="consult-info">
                                        <p><b>학생:</b> ${r.memberName}</p>
                                        <p><b>신청일:</b> ${r.createTime}</p>
                                        <p><b>사유:</b> ${r.consultAppContent}</p>
                                    </div>
                                    <span class="consult-status approved">완료</span>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="card consult-card"
                                 onclick="location.href='${pageContext.request.contextPath}/lectureConsultCorrection.co?consultAppNo=${r.consultAppNo}'">
                                <div class="consult-main">
                                    <div class="consult-info">
                                        <p><b>학생:</b> ${r.memberName}</p>
                                        <p><b>신청일:</b> ${r.createTime}</p>
                                        <p><b>사유:</b> ${r.consultAppContent}</p>
                                    </div>
                                    <span class="consult-status rejected">반려</span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </c:forEach>

                <!-- 여러 카드 반복 -->
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">

                <c:if test="${pi.currentPage > 1}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/lectureConsult.co?cpage=${pi.currentPage - 1}'">
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
                                    onclick="location.href='${pageContext.request.contextPath}/lectureConsult.co?cpage=${i}'">
                                    ${i}
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${pi.currentPage < pi.maxPage}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/lectureConsult.co?cpage=${pi.currentPage + 1}'">
                        다음 &gt;
                    </button>
                </c:if>

            </div>
        </div>
    </section>
</main>
</body>
</html>