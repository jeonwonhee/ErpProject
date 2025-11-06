<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 상담신청</title>
  <link rel="stylesheet" href="/styles/default.css" />
  <link rel="stylesheet" href="/styles/style.css" />
  <link rel="stylesheet" href="/styles/student.css" />
</head>

<body class="student student-consult">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />
  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content consult">
      <!-- 상담신청 폼 -->
      <div class="card consult-form">
        <h2>상담 신청</h2>

        <div class="form-group">
          <label>상담 주제</label>
          <select>
            <option>진로 상담</option>
            <option>학습 상담</option>
            <option>생활 상담</option>
          </select>
        </div>

        <div class="form-row">
          <div class="form-col">
            <label>희망 날짜</label>
            <input type="date" />
          </div>
          <div class="form-col">
            <label>희망 시간</label>
            <input type="time" />
          </div>
        </div>

        <div class="form-group">
          <label>상세 내용</label>
          <textarea placeholder="상담 요청 내용을 입력하세요"></textarea>
        </div>

        <div class="form-submit">
          <button class="btn-submit">신청</button>
        </div>
      </div>

      <!-- 신청 내역 -->
      <div class="card consult-history">
        <h2>신청내역</h2>

        <table>
          <thead>
            <tr>
              <th>기간</th>
              <th>사유</th>
              <th>제출일</th>
              <th>승인상태</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>10/29~10/31</td>
              <td>가족 행사</td>
              <td>9/28</td>
              <td><span class="status pending">대기</span></td>
            </tr>
            <tr>
              <td>9/8~9/9</td>
              <td>건강 검진</td>
              <td>8/31</td>
              <td><span class="status approved">승인</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</body>
</html>
