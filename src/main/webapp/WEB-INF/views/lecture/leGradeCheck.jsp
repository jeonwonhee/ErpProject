<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 학생 성적조회</title>
        <link rel="stylesheet" href="/styles/default.css" />
        <link rel="stylesheet" href="/styles/style.css" />
        <link rel="stylesheet" href="/styles/lecture.css" />
    </head>

    <body class="lecture lecture-grade">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <header class="topbar">
                <div class="path">강사 › 학생조회 <b>강사 페이지</b></div>
                <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
            </header>

            <section class="content grade-content">
                <h2>학생 성적 입력</h2>

                <!-- 검색 영역 -->
                <div class="search-area">
                    <div class="search-box">
                        <input type="text" placeholder="반 검색" />
                        <button class="btn-search">🔍</button>
                    </div>
                    <input type="text" class="exam-name" placeholder="시험명을 입력하세요..." />
                </div>

                <!-- 테이블 -->
                <table class="grade-table">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>반이름</th>
                            <th>점수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>박혜정</td>
                            <td>**반</td>
                            <td><input type="number" placeholder="점수를 입력하세요" value="98" /></td>
                        </tr>
                        <tr>
                            <td>박혜정</td>
                            <td>**반</td>
                            <td><input type="number" value="98" /></td>
                        </tr>
                        <tr>
                            <td>박혜정</td>
                            <td>**반</td>
                            <td><input type="number" value="98" /></td>
                        </tr>
                    </tbody>
                </table>

                <!-- 저장 버튼 -->
                <div class="btn-area">
                    <button class="btn-save" onclick="saveGrades()">저장</button>
                </div>
            </section>
        </main>

        <script>
            function saveGrades() {
            alert("성적이 저장되었습니다.");
            }
        </script>
    </body>
</html>
