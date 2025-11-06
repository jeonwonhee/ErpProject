<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KH EduERP | 회원가입</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/auth.css">
    </head>
    <body class="register">
        <div class="card">
            <h1>회원가입 페이지</h1>
            <p class="desc">해당하는 회원가입 유형을 선택하세요</p>

            <div class="user-type">
                <label>
                    <input type="radio" name="userType" checked>
                    <div class="card">
                        <div class="emoji">👩‍🎓</div>
                        <div class="role-name">학생</div>
                    </div>
                </label>
            </div>

            <div class="form-card">
                <div class="form-group">
                    <label for="course">수강과정</label>
                    <select id="course">
                        <option>선택하세요</option>
                        <option>JAVA / SPRING</option>
                        <option>웹프론트</option>
                        <option>DB / SQL</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="name">이름</label>
                    <input id="name" type="text" placeholder="이름을 입력하세요">
                </div>

                <div class="form-group">
                    <label for="id">아이디</label>
                    <div class="input-with-btn">
                        <input id="id" type="text" placeholder="아이디 입력 (6~20자)">
                        <span class="check-icon success">✅</span>
                        <span class="check-icon fail">❌</span>
                        <button class="btn-submit">중복확인</button>
                    </div>
                </div>

                <div class="form-group">
                    <label for="pw">비밀번호</label>
                    <input id="pw" type="password" placeholder="문자, 특수문자, 숫자 포함 8~20자">
                </div>

                <div class="form-group">
                    <label for="pw2">비밀번호 확인</label>
                    <input id="pw2" type="password" placeholder="비밀번호 재입력">
                </div>

                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input id="phone" type="tel" placeholder="휴대폰 번호 입력 ('-'제외 11자리)">
                </div>

                <div class="form-group">
                    <label>생년월일</label>
                    <div class="birth-selects">
                            <select><option>년도</option></select>
                            <select><option>월</option></select>
                            <select><option>일</option></select>
                    </div>
                </div>
            </div>

            <button class="btn-submit">회원가입</button>
        </div>
    </body>
</html>