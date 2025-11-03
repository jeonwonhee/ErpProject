<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KH EduERP | 로그인</title>
  <!-- <style>
    @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Pretendard', sans-serif;
    }

    body {
      background-color: #f8f9fc;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
    }

    h1 {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 12px;
      color: #222;
    }

    h1 span {
      color: #4b45ff;
    }

    p {
      color: #555;
      font-size: 15px;
      text-align: center;
      line-height: 1.5;
      margin-bottom: 40px;
    }

    .login-card {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 14px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.05);
      width: 380px;
      padding: 40px 50px;
      text-align: center;
    }

    .role-tabs {
      display: flex;
      justify-content: center;
      margin-bottom: 25px;
      gap: 10px;
    }

    .role-tabs button {
      flex: 1;
      padding: 10px 0;
      border: none;
      border-radius: 20px;
      background: #d5d9ff;
      color: #333;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      opacity: 0.7;
    }

    .role-tabs button:hover {
      opacity: 1;
    }

    .role-tabs button.active {
      background: #4b45ff;
      color: #fff;
      opacity: 1;
      font-weight: 600;
    }

    .input-box {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 14px;
      margin-bottom: 14px;
      transition: all 0.2s ease;
    }

    .input-box:focus {
      outline: none;
      border-color: #4b45ff;
      box-shadow: 0 0 0 3px rgba(75, 69, 255, 0.15);
    }

    .login-btn {
      background: #4b45ff;
      color: #fff;
      border: none;
      width: 100%;
      padding: 12px 0;
      border-radius: 10px;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.25s ease;
    }

    .login-btn:hover {
      background: #3832d0;
    }

    .links {
      display: flex;
      justify-content: space-between;
      margin-top: 14px;
      font-size: 13px;
      color: #555;
    }

    .links a {
      text-decoration: none;
      color: #4b45ff;
      font-weight: 500;
    }

    .links a:hover {
      text-decoration: underline;
    }
  </style> -->

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
      <a href="#">비밀번호 찾기</a>
      <a href="#">회원가입</a>
    </div>
  </div>

</body>
</html>