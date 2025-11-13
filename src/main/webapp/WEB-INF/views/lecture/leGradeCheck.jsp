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
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content grade-content">
                <h2>학생 성적 입력</h2>

                <!-- 검색 영역 -->
                <div class="search-area">
                    <form id="classForm"
                          action="${pageContext.request.contextPath}/leGrade.co"
                          method="get">
                    <div class="subject">
                        <option value="">-- 수강반 선택 --</option>
                        <c:forEach var="cls" items="${classList}">
                            <option value="${cls.classNo}"
                                    <c:if test="${param.classNo == cls.classNo || selectedClassNo == cls.classNo}">
                                        selected
                                    </c:if>
                                    ${cls.className}
                            </option>
                        </c:forEach>
                        </select>
                    </div>
                    </form>
                </div>

                <!-- =======================
             학생 성적 입력 테이블
             - studentList : 선택된 반의 학생 목록
               · stu.studentNo    : 학생 번호
               · stu.studentName  : 학생 이름 (memberName)
               · stu.lectureName  : 수강 과목명 (선택 상황에 따라)
           ======================= -->
                <table class="grade-table">
                    <thead>
                        <tr>
                            <th>이름</th>
                            <th>수강과목</th>
                            <th>점수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>박혜정</td>
                            <td>A반</td>
                            <td><input type="number" placeholder="점수를 입력하세요"/></td>
                        </tr>
                    </tbody>
                </table>

                <!-- 저장 버튼 -->
                <div class="btn-area">
                    <button class="btn-change" onclick="chageGrades()">수정</button>
                    <button class="btn-save" onclick="saveGrades()">저장</button>
                </div>
            </section>
        </main>

        <script>
            function saveGrades() {
            alert("성적이 저장되었습니다.");
            }

            function chageGrades() {
                alert("성적이 수정되었습니다.");
            }
        </script>
    </body>
</html>
