<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 비밀번호 변경</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/auth.css">
</head>

<body class="change-pw">
<div class="pw-wrapper">
    <h1 class="title">비밀번호 변경</h1>

    <!-- 메시지 표시 (성공/실패) -->
    <c:if test="${not empty msg}">
        <div class="alert-msg">${msg}</div>
    </c:if>

    <form id="pwForm" action="${pageContext.request.contextPath}/changePassword.co" method="post">

        <!-- 필요하면 사용하는 hidden 값들 -->
        <input type="hidden" name="token" value="${param.token}">
        <input type="hidden" id="role" name="role" value="STUDENT">

        <div class="pw-card">

            <!-- 새 비밀번호 -->
            <label for="newPw" class="field-label">새 비밀번호</label>
            <div class="input-line">
                <input type="password" id="newPw" maxlength="20" name="newPw" placeholder="새 비밀번호 입력">
            </div>

            <!-- 비밀번호 확인 -->
            <label for="confirmPw" class="field-label">비밀번호 확인</label>
            <div class="input-line confirm">
                <input type="password" id="confirmPw" maxlength="20" name="confirmPw" placeholder="다시 한 번 입력">
            </div>

            <!-- 오류 메시지 -->
            <p id="pwError" class="error-text" style="color:#e13535; display:none; margin-top:8px;">
                비밀번호가 일치하지 않습니다.
            </p>
        </div>

        <!-- 제출 버튼 -->
        <button type="button" class="pw-submit" onclick="changePw();">
            변경
        </button>
    </form>
</div>

<script>
    // 비밀번호 일치 체크 + 제출
    function changePw() {
        const form = document.getElementById('pwForm');
        const newPw = document.getElementById('newPw').value.trim();
        const confirmPw = document.getElementById('confirmPw').value.trim();
        const pwError = document.getElementById('pwError');

        if (!newPw || !confirmPw) {
            pwError.textContent = '비밀번호를 모두 입력해 주세요.';
            pwError.style.display = 'block';
            return;
        }

        if (newPw !== confirmPw) {
            pwError.textContent = '비밀번호가 서로 일치하지 않습니다.';
            pwError.style.display = 'block';
            return;
        }

        pwError.style.display = 'none';
        alert('비밀번호 변경이 완료되었습니다.');
        form.submit();
    }
</script>

</body>
</html>
