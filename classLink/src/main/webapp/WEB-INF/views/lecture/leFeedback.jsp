<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 강의별 만족도</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600&display=swap');
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }

    body { background: #f8f9fc; display: flex; }

    /* Sidebar */
    .sidebar {
      width: 230px;
      background: #e8ecff;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 25px 20px;
      height: 100vh;
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 8px;
      font-weight: 600;
      font-size: 18px;
      color: #2a4cff;
    }

    .logo img { width: 32px; height: 32px; }

    .menu { list-style: none; margin-top: 40px; }
    .menu li {
      padding: 10px 12px;
      border-radius: 8px;
      margin-bottom: 8px;
      font-size: 15px;
      cursor: pointer;
      color: #333;
      transition: 0.15s;
    }
    .menu li.active, .menu li:hover { background: #d5d9ff; font-weight: 600; }

    .sidebar footer { font-size: 12px; color: #666; text-align: center; }

    /* Main */
    .main { flex: 1; display: flex; flex-direction: column; background: #fff; }
    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 28px;
      border-bottom: 1px solid #ddd;
    }

    .path { font-size: 15px; color: #444; }
    .path b { margin-left: 6px; font-weight: 600; }
    .user-info { font-size: 14px; color: #666; }

    .content { flex: 1; padding: 40px; }
    .card {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 30px 35px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      max-width: 100%;
    }

    .card h2 { font-size: 18px; font-weight: 700; margin-bottom: 10px; }

    /* Course cards */
    .course-list { display: grid; gap: 16px; margin-top: 20px; }

    .course-card {
      background: #f9f9ff;
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      transition: 0.2s;
      cursor: pointer;
    }

    .course-card:hover {
      background: #eef0ff;
      transform: translateY(-2px);
    }

    .course-info h3 {
      font-size: 16px;
      color: #222;
      margin-bottom: 6px;
    }

    .course-info p {
      font-size: 14px;
      color: #555;
    }

    .course-info strong { color: #4b45ff; }

    .response { font-size: 13px; color: #777; }
  </style>
</head>
<body>
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <main class="main">
    <header class="topbar">
      <div class="path">강사 > 만족도 결과 <b>강사 페이지</b></div>
      <div class="user-info">
        <div class="kh-user-info">
            <span class="alert">알림(2)</span>
            <span class="user">김강사(강사)</span>
        </div>
      </div>
    </header>

    <section class="content">
      <div class="card">
        <h2>강의별 만족도 (5점 만점 기준)</h2>
        <div class="course-list">
          <div class="course-card">
            <div class="course-info" onclick="location.href='${pageContext.request.contextPath}/leGraph.co?lectureGraphNo=1'">
              <h3>JAVA/SPRING - 강사명</h3>
              <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
            </div>
            <span class="response">응답수 48</span>
          </div>

          <div class="course-card">
            <div class="course-info">
              <h3>웹프론트 - 강사명</h3>
              <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
            </div>
            <span class="response">응답수 35</span>
          </div>

          <div class="course-card">
            <div class="course-info">
              <h3>DB/SQL - 강사명</h3>
              <p>강의 평점: <strong>4.2</strong> / 강사 평점: <strong>4.3</strong></p>
            </div>
            <span class="response">응답수 29</span>
          </div>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
