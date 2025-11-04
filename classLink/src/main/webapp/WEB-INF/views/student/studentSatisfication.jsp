<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 강의만족도</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-satisfaction">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content satisfaction">
      <div class="card">
        <h2>만족도 조사<br><small>(AWS 클라우드 기반 DevOps 개발자 양성 과정)</small></h2>

        <form>
          <div class="form-group">
            <label>• 강의 내용 만족도</label>
            <select>
              <option>5 - 매우 만족</option>
              <option>4 - 만족</option>
              <option>3 - 보통</option>
              <option>2 - 불만족</option>
              <option>1 - 매우 불만족</option>
            </select>
          </div>

          <div class="form-group">
            <label>• 강사 전달력</label>
            <select>
              <option>5 - 매우 만족</option>
              <option>4 - 만족</option>
              <option>3 - 보통</option>
              <option>2 - 불만족</option>
              <option>1 - 매우 불만족</option>
            </select>
          </div>

          <div class="form-group">
            <label>• 몰입도</label>
            <select>
              <option>5 - 매우 만족</option>
              <option>4 - 만족</option>
              <option>3 - 보통</option>
              <option>2 - 불만족</option>
              <option>1 - 매우 불만족</option>
            </select>
          </div>

          <div class="form-group">
            <label>• 자유 의견</label>
            <textarea placeholder="좋았던 점 / 개선사항을 입력하세요."></textarea>
          </div>

          <div class="form-submit">
            <button type="submit" class="btn-submit">제출</button>
          </div>
        </form>
      </div>
    </section>
  </main>
</body>
</html>
