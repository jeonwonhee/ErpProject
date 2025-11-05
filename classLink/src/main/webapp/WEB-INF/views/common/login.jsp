<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 로그인</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\auth.css">
    </head>
    <body class="login">

        <h1>모두를 위한 통합 학원 관리 <span>KH EduERP</span></h1>
        <p>학생, 강사, 관리자가 한 곳에서 연결되는 스마트 학원 통합 시스템.<br>출결부터 휴가, 공지사항까지 한 번에 관리하세요.</p>

        <div class="login-card">
            <div class="role-tabs">
                <button class="active">학생</button>
                <button>강사</button>
                <button>관리자</button>
            </div>

            <input type="text" class="input-box" placeholder="아이디">
            <input type="password" class="input-box" placeholder="비밀번호">
            <button class="login-btn">로그인</button>

            <div class="links">
                <a href="${pageContext.request.contextPath}/findPassword.co">비밀번호 찾기</a>
                <a href="${pageContext.request.contextPath}/studentRegister.co">회원가입</a>
            </div>
        </div>

    </body>
</html>