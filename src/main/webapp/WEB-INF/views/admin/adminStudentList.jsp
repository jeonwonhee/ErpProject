<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 학생목록</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
          <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
          <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    </head>

    <body class="admin admin-student-list">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content student-list">
                <div class="card">
                    <h2>학생목록</h2>

                    <table class="student-table">
                        <thead>
                            <tr>
                                <th>이름</th>
                                <th>과정</th>
                                <th>연락처</th>
                                <th>출석률</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>김이서</td>
                                <td>Java/Spring</td>
                                <td>010-1111-2222</td>
                                <td>99%</td>
                                <td>재학</td>
                            </tr>
                            <tr>
                                <td>유한정</td>
                                <td>AI/데이터분석</td>
                                <td>010-3333-4444</td>
                                <td>83%</td>
                                <td>재학</td>
                            </tr>
                            <tr>
                                <td>신윤주</td>
                                <td>데이터분석</td>
                                <td>010-5555-6666</td>
                                <td>79%</td>
                                <td>재학</td>
                            </tr>
                            <tr>
                                <td>김기수</td>
                                <td>Java/Spring</td>
                                <td>010-7777-8888</td>
                                <td>59%</td>
                                <td>재학</td>
                            </tr>
                            <tr>
                                <td>유부은</td>
                                <td>Java/Spring</td>
                                <td>010-8888-9999</td>
                                <td>99%</td>
                                <td>재학</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>
