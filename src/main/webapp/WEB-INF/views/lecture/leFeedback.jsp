<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 강의별 만족도</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\lecture.css">

    </head>

    <body class="lecture lecture-feedback">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <c:set var="pageName" value="강의별 만족도" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="card">
                    <h2>강의별 만족도 (5점 만점 기준)</h2>
                    <div class="course-list">
                        <c:forEach var="lec" items="${lectureList}">
                            <div class="card course-card" onclick="location.href='/leGraph.co?lectureGraphNo=${lec.classLectureNo}'">
                                <div class="course-info">
                                    <h3>${lec.className} - ${lec.lectureName}</h3>
                                    <p>강의 평점: <strong>${lec.avgClassRating}</strong> /
                                       강사 평점: <strong>${lec.avgLectureRating}</strong></p>
                                </div>
                                <span class="response">
                                    제출률 ${lec.submittedCount} / ${lec.totalCount}
                                </span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
