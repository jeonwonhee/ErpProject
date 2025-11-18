<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 학생 성적관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/lecture.css" />
</head>

<body class="lecture lecture-grade">

<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content grade-content">

        <!-- 탭 메뉴 -->
        <div class="grade-tab-menu">
            <button type="button" class="tab-item <c:if test='${activeTab == "input"}'>active</c:if>'" data-tab="input">
                성적 입력
            </button>

            <button type="button" class="tab-item <c:if test='${activeTab == "edit"}'>active</c:if>'" data-tab="edit">
                성적 수정
            </button>
        </div>

        <!-- ===============================
             탭 1) 성적 입력
           =============================== -->
        <div id="tab-input" class="tab-panel" style="<c:if test='${activeTab == "input"}'>display:block;</c:if> <c:if test='${activeTab != "input"}'>display:none;</c:if>">

            <h2>학생 성적 입력</h2>

            <!-- 반 선택 -->
            <div class="search-area">
                <form action="${pageContext.request.contextPath}/leGrade.co" method="get">
                    <input type="hidden" name="tab" value="input" />

                    <label>수강반</label>
                    <select name="classSelect" required>
                        <option value="">반 선택</option>
                        <c:forEach var="cls" items="${classList}">
                            <option value="${cls.classNo}"
                                    <c:if test="${cls.classNo == selectedClassNo}">selected</c:if>>
                                    ${cls.className}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn-search">조회</button>
                </form>
            </div>

            <!-- 성적입력 폼 -->
            <c:if test="${not empty selectedClassNo}">
                <form action="${pageContext.request.contextPath}/leGradeSave.co" method="post">

                    <input type="hidden" name="classNo" value="${selectedClassNo}" />

                    <div class="test-name-row">
                        <div class="test-input-group">
                            <input type="text" name="testName"
                                   placeholder="시험 이름 입력 (예: 중간)"
                                   required />
                            <button type="button" class="btn-test-save"
                                    onclick="alert('시험 이름이 설정되었습니다. 아래에서 점수를 입력 후 저장 버튼을 눌러 주세요.');">
                                저장
                            </button>
                        </div>
                    </div>

                    <table class="grade-table">
                        <thead>
                        <tr><th>이름</th><th>점수</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="stu" items="${studentList}">
                            <tr>
                                <td>${stu.studentName}
                                    <input type="hidden" name="studentNo" value="${stu.studentNo}" />
                                </td>
                                <td><input type="number" name="grade" min="0" max="100" required /></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="btn-area">
                        <button type="button" class="btn-save"
                        onclick="alert('시험 성적이 저장되었습니다.');this.form.submit();">
                            저장
                        </button>
                    </div>
                </form>
            </c:if>
        </div>

        <!-- ===============================
             탭 2) 성적 수정
           =============================== -->
        <div id="tab-edit" class="tab-panel" style="<c:if test='${activeTab == "edit"}'>display:block;</c:if> <c:if test='${activeTab != "edit"}'>display:none;</c:if>">

            <h2>학생 성적 수정</h2>

            <!-- 반 선택 -->
            <div class="search-area">
                <form action="${pageContext.request.contextPath}/leGrade.co" method="get">
                    <input type="hidden" name="tab" value="edit" />

                    <label>수강반</label>
                    <select name="classSelect" required>
                        <option value="">반 선택</option>
                        <c:forEach var="cls" items="${classList}">
                            <option value="${cls.classNo}"
                                    <c:if test="${cls.classNo == selectedClassNo}">selected</c:if>>
                                    ${cls.className}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn-search">조회</button>
                </form>
            </div>

            <!-- 시험 검색 -->
            <c:if test="${not empty selectedClassNo}">
                <div class="test-name-row">
                    <form action="${pageContext.request.contextPath}/leGrade.co" method="get" class="test-input-group">

                        <input type="hidden" name="tab" value="edit" />
                        <input type="hidden" name="classSelect" value="${selectedClassNo}" />

                        <input type="text" name="keyword" value="${keyword}"
                               placeholder="시험 이름 검색 (예: 중간)"
                               style="width: 300px;" />

                        <button type="submit" class="btn-test-save">검색</button>
                    </form>
                </div>
            </c:if>

            <!-- 시험 검색 결과 테이블 -->
            <c:if test="${not empty gradeEditList}">
                <table class="grade-table">
                    <thead>
                    <tr>
                        <th>이름</th>
                        <th>현재 점수</th>
                        <th>수정 점수</th>
                        <th>수정</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="g" items="${gradeEditList}">
                        <tr>
                            <!-- 각 행마다 하나의 form 사용 -->
                            <form action="${pageContext.request.contextPath}/leGradeUpdate.co" method="post">
                                <td>
                                        ${g.studentName}
                                    <!-- 어떤 GRADE를 수정하는지 -->
                                    <input type="hidden" name="gradeNo" value="${g.gradeNo}" />
                                </td>

                                <td>${g.grade}점</td>

                                <td>
                                    <input type="number" min="0" max="100"
                                           name="newGrade"
                                           value="${g.grade}"
                                           required
                                           placeholder="새 점수" />
                                </td>

                                <td>
                                    <!-- 시험 이름은 검색한 keyword를 그대로 testName 으로 보냄 -->
                                    <input type="hidden" name="testName" value="${keyword}" />

                                    <!-- 다시 돌아갈 때 필요한 값들 -->
                                    <input type="hidden" name="classSelect" value="${selectedClassNo}" />
                                    <input type="hidden" name="keyword" value="${keyword}" />

                                    <button type="button" class="btn-save"
                                             onclick="alert('시험 성적이 수정되었습니다.'); this.form.submit();">
                                        저장
                                    </button>
                                </td>
                            </form>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>


            <!-- 검색했는데 결과 없음 -->
            <c:if test="${empty gradeEditList && not empty keyword}">
                <p style="text-align:center; color:gray;">검색 결과가 없습니다.</p>
            </c:if>

        </div>
    </section>
</main>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        // 탭 전환
        const tabs = document.querySelectorAll(".grade-tab-menu .tab-item");
        const panels = document.querySelectorAll(".tab-panel");

        tabs.forEach(tab => {
            tab.addEventListener("click", function () {
                const target = this.dataset.tab;

                tabs.forEach(t => t.classList.remove("active"));
                this.classList.add("active");

                panels.forEach(p => p.style.display = "none");
                document.getElementById("tab-" + target).style.display = "block";
            });
        });
    });
</script>

</body>
</html>
