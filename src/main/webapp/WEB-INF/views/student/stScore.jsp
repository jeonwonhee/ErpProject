<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 성적조회</title>
    <link rel="stylesheet" href="/styles/default.css" />
    <link rel="stylesheet" href="/styles/style.css" />
    <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-score">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content score">
        <div class="card">
            <h2>학생 성적 조회</h2>

            <div class="student-info">
                <p><b>이름</b> <c:out value="${loginMember.name}" /></p>

                <div class="subject-select">
                    <label for="subject"><b>과목 선택</b></label>
                    <select id="subject">
                        <!-- placeholder -->
                        <option value="" selected disabled>과목을 선택하세요</option>

                        <c:choose>
                            <c:when test="${not empty subjectList}">
                                <c:forEach var="subj" items="${subjectList}">
                                    <!-- value는 ID, 라벨은 이름 -->
                                    <option value="${subj.lectureName}}">
                                        <c:out value="${subj.lectureName}}"/>
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option value="">조회할 성적이 없습니다</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
            </div>

            <!-- 결과/빈 상태 영역 -->
            <div class="score-result" style="display:none;">
                <p class="subject-title"></p>
                <p class="score-value">점수 : <span></span></p>
            </div>

            <div class="no-result" style="display:none; color:gray;">
                조회할 성적이 없습니다.
            </div>
        </div>
    </section>
</main>

<script>
    $(function() {
        const subjectSelect = $("#subject");
        const scoreResult = $(".score-result");
        const noResult = $(".no-result");
        const ctx = "${pageContext.request.contextPath}";
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        // 과목 없음 처리 (placeholder 1개 + 빈값)
        if (subjectSelect.find("option").length === 1 && subjectSelect.find("option").val() === "") {
            subjectSelect.prop("disabled", true);
            noResult.text("조회할 성적이 없습니다.").show();
            return;
        }

        // 로딩 텍스트 (간단)
        const loading = $("<p class='loading' style='color:gray; display:none;'>불러오는 중...</p>");
        scoreResult.before(loading);

        subjectSelect.on("change", function() {
            const subjectId = $(this).val();
            if (!subjectId) return;

            scoreResult.hide();
            noResult.hide();
            loading.show();

            $.ajax({
                url: ctx + "/student/getScore",
                type: "GET",        // Security 쓰면 POST 권장 (컨트롤러도 POST로 맞추기)
                dataType: "json",
                cache: false,
                data: { subjectId: subjectId },
                beforeSend: function(xhr) {
                    if (csrfToken && csrfHeader) xhr.setRequestHeader(csrfHeader, csrfToken);
                },
                success: function(res) {
                    loading.hide();

                    if (!res || typeof res.score === "undefined") {
                        noResult.text("성적 정보가 없습니다.").show();
                        return;
                    }

                    // 선택된 option의 라벨(과목명)
                    const label = subjectSelect.find("option:selected").text();
                    $(".subject-title").text(label + " 성적");
                    $(".score-value span").text(res.score + "점");
                    scoreResult.fadeIn(200);
                },
                error: function() {
                    loading.hide();
                    noResult.text("성적 정보를 불러올 수 없습니다.").show();
                }
            });
        });
    });
</script>
</body>
</html>