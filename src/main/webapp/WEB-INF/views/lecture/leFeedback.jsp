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
            <header class="topbar">
                <div class="path">강사 > 만족도 결과 <b>강사 페이지</b></div>
                <div class="user-info">
                    <div class="kh-user-info">
                        <span class="alert">알림(2)</span>
                        <span class="user">김강사(강사)</span>
                    </div>
                </div>
            </header>

            <section class="content">
                <div class="card">
                    <h2>강의별 만족도 (5점 만점 기준)</h2>
                    <div class="course-list">
                        <div class="card course-card" onclick="location.href='${pageContext.request.contextPath}/leGraph.co?lectureGraphNo=1'">
                            <div class="course-info" >
                                <h3>JAVA/SPRING - 강사명</h3>
                                <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
                            </div>
                            <span class="response">응답수 48</span>
                        </div>

                        <div class="card course-card">
                            <div class="course-info">
                                <h3>웹프론트 - 강사명</h3>
                                <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
                            </div>
                            <span class="response">응답수 35</span>
                        </div>

                        <div class="card course-card">
                            <div class="course-info">
                                <h3>DB/SQL - 강사명</h3>
                                <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
                            </div>
                            <span class="response">응답수 29</span>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
