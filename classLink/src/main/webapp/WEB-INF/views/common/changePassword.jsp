<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 비밀번호 변경</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\auth.css">
    </head>
    <body class="change-pw">
        <div class="pw-wrapper">
            <h1 class="title">비밀번호 변경</h1>

            <div class="card">
                <div class="role-tabs">
                    <button class="role-tab active">학생</button>
                    <button class="role-tab">강사</button>
                    <button class="role-tab">관리자</button>
                </div>

                <div class="input-line">
                    비밀번호를 입력하세요
                </div>

                <p class="field-label">비밀번호 확인</p>
                <div class="input-line confirm">
                    <button class="confirm-button">확인</button>
                </div>
            </div>

            <button class="pw-submit">변경</button>
        </div>
    </body>
</html>
