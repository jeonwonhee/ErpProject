<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 학생 성적입력</title>
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

        <!-- =========================
             1. 수강반 선택 영역 (항상 보임)
           ========================= -->
        <div class="search-area">
            <form id="classForm"
                  action="${pageContext.request.contextPath}/leGrade.co"
                  method="get">
                <div class="subject">
                    <label for="classSelect">수강반</label>
                    <select id="classSelect" name="classSelect" required>
                        <option value="">반 선택</option>
                        <c:forEach var="cls" items="${classList}">
                            <option value="${cls.classNo}"
                                    <c:if test="${cls.classNo == selectedClassNo}">selected</c:if>>
                                    ${cls.className}
                            </option>
                        </c:forEach>
                    </select>

                    <button type="submit" class="btn-search">조회</button>
                </div>
            </form>
        </div>

        <!-- =========================
             2. 성적 입력 영역
             - 선택된 반이 있을 때만 보이게!
           ========================= -->
        <c:if test="${not empty selectedClassNo}">
            <!-- 성적 저장 폼 -->
            <form action="${pageContext.request.contextPath}/leGradeSave.co"
                  method="post">

                <!-- 선택된 반 번호 전달 -->
                <input type="hidden" name="classNo" value="${selectedClassNo}" />
                <c:if test="${not empty classLectureNo}">
                    <input type="hidden" name="classLectureNo" value="${classLectureNo}" />
                </c:if>

                <!-- 시험 이름 입력 영역 -->
                <div class="test-name-row">
                    <label for="testName">시험 이름</label>

                    <div class="test-input-group">
                        <input type="text"
                               id="testName"
                               name="testName"
                               placeholder="중간고사 / 기말고사 등"
                               required />

                        <!-- 이 버튼은 그냥 알림만 주고 싶으면 type="button" -->
                        <button type="button" class="btn-test-save"
                                onclick="alert('시험 이름이 설정되었습니다. 아래에서 점수를 입력 후 저장 버튼을 눌러 주세요.');">
                            저장
                        </button>
                    </div>
                </div>

                <!-- 학생 성적 입력 테이블 -->
                <table class="grade-table">
                    <thead>
                    <tr>
                        <th>이름</th>
                        <th>점수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty studentList}">
                        <tr>
                            <td colspan="2" style="text-align: center;">
                                선택한 반에 등록된 학생이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="stu" items="${studentList}">
                        <tr>
                            <td>
                                    ${stu.studentName}
                                <!-- 학생 번호 hidden -->
                                <input type="hidden" name="studentNo" value="${stu.studentNo}" />
                            </td>
                            <td>
                                <input type="number"
                                       name="grade"
                                       min="0"
                                       max="100"
                                       required
                                       placeholder="점수를 입력하세요" />
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- 저장 버튼 -->
                <div class="btn-area">
                    <button type="submit" class="btn-save">저장</button>
                </div>
            </form>
        </c:if>

    </section>
</main>

<script>
    function saveGrades() {
        alert("성적이 저장되었습니다.");
    }

    function changeGrades() {
        alert("성적이 수정되었습니다.");
    }
</script>
</body>
</html>
