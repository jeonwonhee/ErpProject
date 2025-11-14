<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 로그인</title>

    <link rel="stylesheet" href="styles/default.css">
    <link rel="stylesheet" href="styles/style.css">
    <link rel="stylesheet" href="styles/auth.css">
</head>
<body class="login">

<h1>모두를 위한 통합 학원 관리 <span>KH EduERP</span></h1>
<p>학생, 강사, 관리자가 한 곳에서 연결되는 스마트 학원 통합 시스템.<br>출결부터 휴가, 공지사항까지 한 번에 관리하세요.</p>

<div class="login-card">

    <!-- 로그인 폼 시작 -->
    <form action="${pageContext.request.contextPath}/login.co" method="post">
        <div class="role-tabs">
            <button type="button" class="active" onclick="setRole('STUDENT')">학생</button>
            <button type="button" onclick="setRole('TEACHER')">강사</button>
            <button type="button" onclick="setRole('ADMIN')">관리자</button>
        </div>

        <input type="hidden" name="role" id="role" value="STUDENT">

        <input type="text" name="memberId" class="input-box" placeholder="아이디" required>
        <input type="password" name="memberPassword" class="input-box" placeholder="비밀번호" required>

        <button type="submit" class="login-btn">로그인</button>

        <div class="links">
            <a href="${pageContext.request.contextPath}/findPassword.co">비밀번호 찾기</a>
            <a href="${pageContext.request.contextPath}/stRegister.co">회원가입</a>
        </div>
    </form>
    <!-- 로그인 폼 끝 -->

</div>

<script>
    // 역할 선택 버튼 동작
    const roleButtons = document.querySelectorAll('.role-tabs button');
    const roleInput = document.getElementById('role');

    roleButtons.forEach((button) => {
        button.addEventListener('click', () => {
            // 모든 버튼의 active 제거
            roleButtons.forEach((btn) => btn.classList.remove('active'));
            // 클릭된 버튼에 active 추가
            button.classList.add('active');

            // hidden input에 역할 값 반영
            if (button.textContent.includes('학생')) roleInput.value = 'STUDENT';
            else if (button.textContent.includes('강사')) roleInput.value = 'TEACHER';
            else if (button.textContent.includes('관리자')) roleInput.value = 'ADMIN';
        });
    });
</script>

</body>
</html>