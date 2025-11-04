<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 학생 일정조회</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/student.css">
</head>

<body class="student student-calendar">
  <!-- ===== 사이드바 ===== -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- ===== 메인 ===== -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="calendar-header">
        <div class="month-control">
          <button class="month-btn">◀</button>
          <div class="month-title">2025년 11월</div>
          <button class="month-btn">▶</button>
          <button class="today-btn">오늘</button>
        </div>

        <div class="legend">
          <span><span class="dot blue"></span>수업</span>
          <span><span class="dot orange"></span>시험</span>
          <span><span class="dot green"></span>휴일/행사</span>
        </div>
      </div>

      <div class="calendar-grid" id="calendar"></div>

      <p class="calendar-note">
        ※ 일정이 많은 날은 셀 하단의 +N 표시를 눌러 세부 내용을 확인할 수 있습니다.
      </p>
    </section>
  </main>

  <script>
    const calendar = document.getElementById("calendar");

    const events = {
      3: ["웹 프로젝트 수업", "프론트 퀴즈"],
      4: ["DB/SQL 실습"],
      10: ["Spring MVC"],
      12: ["중간평가"],
      15: ["학원 휴무"],
      19: ["팀 프로젝트 발표", "프로젝트 미팅", "+1 더보기"],
      27: ["버프 리허설"]
    };

    for (let i = 1; i <= 30; i++) {
      const day = document.createElement("div");
      day.classList.add("day-cell");
      day.innerHTML = `<span class="day-num">${i}</span>`;

      if (events[i]) {
        const eventList = document.createElement("ul");
        eventList.classList.add("event-list");

        events[i].forEach(event => {
          const li = document.createElement("li");
          li.textContent = event;
          eventList.appendChild(li);
        });

        day.appendChild(eventList);
      }

      calendar.appendChild(day);
    }
  </script>
</body>
</html>
