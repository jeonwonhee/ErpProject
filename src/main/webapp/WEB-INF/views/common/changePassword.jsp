<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 비밀번호 변경</title>

    <!-- 역슬래시(\) 대신 슬래시(/) 권장 -->
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

    <!-- ✅ 폼 시작 -->
    <form id="pwForm" action="${pageContext.request.contextPath}/changePassword.co" method="post">
        <!-- 역할 탭 -->
        <div class="card">
            <div class="role-tabs" id="roleTabs">
                <button type="button" class="role-tab active" data-role="STUDENT">학생</button>
                <button type="button" class="role-tab" data-role="TEACHER">강사</button>
                <button type="button" class="role-tab" data-role="ADMIN">관리자</button>
            </div>

            <!-- 서버로 보낼 role -->
            <input type="hidden" id="role" name="role" value="STUDENT" />

            <!-- 새 비밀번호 -->
            <div class="input-line">
                <label for="newPw" class="field-label">비밀번호</label>
                <input type="password" id="newPw" name="newPw" placeholder="새 비밀번호 입력"  />
            </div>

            <!-- 비밀번호 확인 -->
            <p class="field-label">비밀번호 확인</p>
            <div class="input-line confirm">
                <input type="password" id="confirmPw" name="confirmPw" placeholder="새 비밀번호 확인"  />
            </div>

            <!-- 오류 메시지 -->
            <p id="pwError" class="error-text" style="color:#e13535;display:none;margin-top:8px;">
                비밀번호가 일치하지 않습니다.
            </p>
        </div>

        <!-- 제출 버튼 (폼 안으로 이동!) -->
        <button type="submit" class="pw-submit">변경</button>
    </form>
    <!-- ✅ 폼 끝 -->
</div>

<script>
    // 역할 탭: active 토글 + hidden role 값 설정
    document.querySelectorAll('.role-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.role-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            document.getElementById('role').value = tab.dataset.role;
        });
    });

    // 비밀번호 일치 검증 (클라이언트)
    document.getElementById('pwForm').addEventListener('submit', e => {
        const newPw = document.getElementById('newPw').value.trim();
        const confirmPw = document.getElementById('confirmPw').value.trim();
        const pwError = document.getElementById('pwError');

        if (newPw !== confirmPw) {
            e.preventDefault();
            pwError.textContent = '비밀번호가 서로 일치하지 않습니다.';
            pwError.style.display = 'block';
        } else {
            pwError.style.display = 'none';
        }
    });
</script>
</body>
</html>
