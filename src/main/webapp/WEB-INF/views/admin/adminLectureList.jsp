<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 강사목록</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">

    </head>

    <body class="admin admin-lecture-list">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content lecture-list">
                <h2>강사목록</h2>
                <div class="inquiry-write">
                    <button type="button" class="btn-write create-btn">강사/관리자 생성</button>
                </div>
                <table class="lecture-table">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>담당 과정</th>
                            <th>연락처</th>
                            <th>출근율</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>김이서</td>
                            <td>Java/Spring</td>
                            <td>010-1111-2222</td>
                            <td>99%</td>
                            <td>재직</td>
                        </tr>
                         <tr>
                            <td>유한정</td>
                            <td>AI/데이터분석</td>
                            <td>010-3333-4444</td>
                            <td>83%</td>
                            <td>재직</td>
                        </tr>
                        <tr>
                            <td>신윤주</td>
                            <td>데이터분석</td>
                            <td>010-5555-6666</td>
                            <td>79%</td>
                            <td>재직</td>
                        </tr>
                         <tr>
                            <td>김기수</td>
                            <td>Java/Spring</td>
                            <td>010-7777-8888</td>
                            <td>59%</td>
                            <td>재직</td>
                         </tr>
                         <tr>
                            <td>유부은</td>
                            <td>Java/Spring</td>
                            <td>010-8888-9999</td>
                            <td>99%</td>
                            <td>재직</td>
                        </tr>
                    </tbody>
                </table>
            </section>
        </main>
    </body>
</html>
