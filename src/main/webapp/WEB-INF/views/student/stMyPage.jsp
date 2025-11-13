<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 마이페이지</title>

    <link rel="stylesheet" href="/styles/default.css" />
    <link rel="stylesheet" href="/styles/style.css" />
    <link rel="stylesheet" href="/styles/student.css" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap JS (팝업 작동 필수) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body class="student student-mypage">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<c:if test="${not empty requestScope.alertMsg}">
    <script>
        alert('${requestScope.alertMsg}');
    </script>
    <%-- 한 번 보여줬으면 request / session 둘 다에서 제거 --%>
    <c:remove var="alertMsg" scope="request" />
    <c:remove var="alertMsg" scope="session" />
</c:if>

<!-- 메인 -->
<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content mypage">
        <div class="card">
            <h2>마이페이지</h2>

            <form action="${pageContext.request.contextPath}/stMyPage.co" method="post" id="updateForm">

                <!-- 이름 (읽기 전용) -->
                <div class="form-group">
                    <label>이름</label>
                    <input type="text" name="memberName" value="${loginMember.memberName}" readonly />
                </div>

                <!-- 아이디 (읽기 전용) -->
                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" name="memberId" value="${loginMember.memberId}" readonly />
                </div>

                <!-- 생년월일 -->
                <div class="form-group">
                    <label>생년월일</label>
                    <input
                            type="date"
                            id="birthDate"
                            name="birthDate"
                            value="${loginMember.birthDate}"
                            required
                    />
                </div>

                <!-- 전화번호 (수정 가능) -->
                <div class="form-group">
                    <label>전화번호</label>
                    <input type="tel" name="phone" value="${loginMember.phone}" placeholder="010-1234-5678" />
                </div>

                <!-- 이메일 (수정 가능) -->
                <div class="form-group">
                    <label>이메일</label>
                    <input type="email" name="email" value="${loginMember.email}" placeholder="example@naver.com" />
                </div>

                <!-- 수강반 (읽기 전용 + hidden으로 값 전송) -->
                <div class="form-group">
                    <label>수강반</label>
                    <select id="course_view" name="course_view" disabled>
                        <option value="${loginMember.classNo}" selected>${loginMember.className}</option>
                    </select>
                    <input type="hidden" id="course" name="courseId" value="${loginMember.classNo}">
                </div>

                <div class="form-buttons">
                    <button type="submit" class="btn btn-primary">정보 수정</button>

                    <button type="button"
                            class="btn change-pw"
                            onclick="location.href='${pageContext.request.contextPath}/changePassword.co'">
                        비밀번호 변경
                    </button>

                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#delete-member-modal">
                        회원탈퇴
                    </button>
                </div>
            </form>
        </div>
    </section>
</main>

<!-- 탈퇴 팝업 -->
<div class="modal fade" id="delete-member-modal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원탈퇴</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/delete.co" method="post" id="delForm">
                    <div class="alert alert-warning" role="alert">
                        <strong>경고:</strong> 탈퇴 후 복구가 불가능합니다.<br>
                        정말로 탈퇴하시겠습니까?
                    </div>
                    <div class="mb-3">
                        <label for="deletePwd" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="deletePwd" name="memberPassword" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-danger">탈퇴하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
