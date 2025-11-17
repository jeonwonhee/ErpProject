<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 성적조회</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/student.css" />
</head>

<body class="student student-score">

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content score">
        <div class="card">

            <!-- 제목 -->
            <h2>학생 성적 조회</h2>

            <!-- ===============================
                 1. 상단 영역 (이름 + 과목 선택)
               =============================== -->
            <form action="${pageContext.request.contextPath}/stScore.co"
                  method="get"
                  class="student-info">

                <!-- 이름 -->
                <p><b>이름</b> ${loginMember.memberName}</p>

                <!-- 과목 선택 -->
                <div class="subject-select">
                    <label for="lectureNo"><b>과목 선택</b></label>

                    <select id="lectureNo" name="lectureNo" required>
                        <option value="" disabled
                                <c:if test="${empty selectedLectureNo}">selected</c:if>>
                            과목을 선택하세요
                        </option>

                        <c:forEach var="subj" items="${subjectList}">
                            <option value="${subj.lectureNo}"
                                    <c:if test="${subj.lectureNo == selectedLectureNo}">selected</c:if>>
                                    ${subj.lectureName}
                            </option>
                        </c:forEach>
                    </select>

                    <button type="submit" class="btn-search">조회</button>
                </div>
            </form>

            <!-- ===============================
                 2. 성적 테이블 (과목 선택 시만 표시)
               =============================== -->
            <c:if test="${not empty selectedLectureNo}">
                <div class="score-area">
                    <!-- 성적 테이블 -->
                    <table class="score-table">
                        <thead>
                        <tr>
                            <th>시험 이름</th>
                            <th>점수</th>
                        </tr>
                        </thead>

                        <tbody>

                        <!-- 성적 없을 경우 -->
                        <c:if test="${empty gradeList}">
                            <tr>
                                <td colspan="2" style="text-align:center; color:gray;">
                                    조회할 성적이 없습니다.
                                </td>
                            </tr>
                        </c:if>

                        <!-- 성적 있을 경우 -->
                        <c:forEach var="g" items="${gradeList}">
                            <tr>
                                <!-- 시험 이름 -->
                                <td>${g.testName}</td>

                                <!-- 점수 + 정정 버튼-->
                                <td class="score-cell">
                                    <span class="score-value">${g.grade}점</span>

                                  <!--  <a href="${pageContext.request.contextPath}/gradeUpdate.co"
                                       class="btn-correct">
                                        정정 신청
                                    </a>-->
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>
    </section>
</main>
</body>
</html>

