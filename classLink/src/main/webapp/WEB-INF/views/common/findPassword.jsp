<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>KH EduERP | 비밀번호 찾기</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Pretendard', sans-serif;
    }

    body {
      background: #f3f4fb;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 50px 0 100px;
    }

    /* ===== Wrapper ===== */
    .pw-wrapper {
      width: min(970px, 100% - 40px);
      background: #f3f4fb;
      border: 1px solid #d3d3da;
      border-radius: 18px;
      padding: 44px 0 110px;
      position: relative;
    }

    .pw-title {
      text-align: center;
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 34px;
    }

    /* ===== Card ===== */
    .pw-card {
      width: 520px;
      margin: 0 auto;
      background: #fff;
      border: 1px solid #161616;
      border-radius: 14px;
      padding: 32px 34px 48px;
    }

    /* ===== Role Tabs ===== */
    .role-tabs {
      display: flex;
      gap: 14px;
      margin-bottom: 30px;
    }

    .role-tab {
      flex: 1;
      height: 50px;
      border: none;
      border-radius: 16px;
      background: #d2ccff;
      color: #fff;
      font-weight: 600;
      font-size: 15px;
      cursor: pointer;
      transition: 0.15s;
    }

    .role-tab.active {
      background: #5b55ff;
      box-shadow: 0 6px 10px rgba(90, 85, 255, 0.25);
    }

    /* ===== Labels ===== */
    .field-label {
      font-weight: 600;
      font-size: 14px;
      color: #222;
      margin-bottom: 8px;
      display: block;
    }

    /* ===== Select Box ===== */
    .select-box {
      position: relative;
      margin-bottom: 24px;
    }

    select {
      width: 100%;
      height: 50px;
      border: 1px solid #ccc;
      border-radius: 12px;
      padding: 0 14px;
      font-size: 14px;
      color: #333;
      appearance: none;
      background: #fff;
      cursor: pointer;
    }

    .select-box::after {
      content: "⌄";
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      color: #555;
      pointer-events: none;
      font-size: 16px;
    }

    /* ===== Input Fields ===== */
    .input-group {
      margin-bottom: 22px;
      position: relative;
    }

    .form-input {
      width: 100%;
      height: 50px;
      border: 1px solid #ccc;
      border-radius: 12px;
      padding: 0 14px;
      font-size: 14px;
      background: #fff;
      transition: 0.2s;
    }

    .form-input::placeholder {
      color: #999;
    }

    .form-input:focus {
      outline: none;
      border-color: #6b5bff;
      background: #fafbff;
    }

    /* ===== 인증 버튼 ===== */
    .btn-inline {
      position: absolute;
      right: 8px;
      top: 50%;
      transform: translateY(-50%);
      background: #fff;
      border: 1px solid #bbb;
      border-radius: 10px;
      padding: 6px 12px;
      font-size: 13px;
      cursor: pointer;
      transition: 0.15s;
      color: #444;
    }

    .btn-inline:hover {
      border-color: #5b55ff;
      color: #5b55ff;
    }

    /* ===== 하단 버튼 ===== */
    .pw-submit {
      position: absolute;
      bottom: 30px;
      left: 50%;
      transform: translateX(-50%);
      background: #5b55ff;
      color: white;
      border: none;
      border-radius: 14px;
      width: 110px;
      height: 42px;
      font-weight: 600;
      cursor: pointer;
      transition: 0.15s;
    }

    .pw-submit:hover {
      background: #4a45e6;
    }

    @media (max-width: 600px) {
      .pw-card {
        width: 100%;
        padding: 26px 20px 48px;
      }
    }
  </style>
</head>
<body>
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
