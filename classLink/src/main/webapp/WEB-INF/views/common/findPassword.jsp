<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 비밀번호 찾기</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\auth.css">
    </head>
    <body class="find-pw">
        <div class="pw-wrapper">
            <h1 class="title">비밀번호 찾기</h1>

            <div class="card">
                <div class="role-tabs">
                    <button class="role-tab active">학생</button>
                    <button class="role-tab">강사</button>
                    <button class="role-tab">관리자</button>
                </div>

                <label class="field-label">수강 과정</label>
                <div class="select-box">
                    <select>
                        <option>AWS 클라우드 기반 Devops 개발자 양성 과정</option>
                        <option>Java 웹 풀스택 개발자 과정</option>
                        <option>AI 데이터 분석 전문가 과정</option>
                    </select>
                </div>

                <label class="field-label">아이디</label>
                <div class="input-group">
                    <input type="text" class="input-box" placeholder="아이디를 입력하세요">
                </div>

                <label class="field-label">전화번호</label>
                <div class="input-group">
                    <input type="text" class="input-box" placeholder="전화번호를 입력하세요">
                    <button class="btn-inline">인증번호 요청</button>
                </div>

                <label class="field-label">인증번호</label>
                <div class="input-group">
                    <input type="text" class="input-box" placeholder="인증번호를 입력하세요">
                    <button class="btn-inline">인증</button>
                </div>
            </div>

            <button class="pw-submit">다음</button>
        </div>
    </body>
</html>
