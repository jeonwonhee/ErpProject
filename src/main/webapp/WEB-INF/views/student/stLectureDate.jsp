<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 학생 일정조회</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/student.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <style>
      .calender-box { width: 800px; margin: 40px auto; }
      .calender-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:16px; }
      .month-title { font-size:20px; font-weight:600; }
      .month-btn { padding:4px 10px; cursor:pointer; }

      .calender-grid {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        border-top:1px solid #ddd;
        border-left:1px solid #ddd;
      }
      .day-cell, .day-header {
        border-right:1px solid #ddd;
        border-bottom:1px solid #ddd;
        min-height: 90px;
        padding: 6px;
      }
      .day-header { background:#f1f3f8; font-weight:700; text-align:center; }
      .day-num { font-weight:600; color:#333; }
      .event-list { margin-top: 4px; padding-left: 14px; font-size:13px; }

      .today {
        background: #e3f2fd;
        border: 2px solid #2196f3;
      }
    </style>
</head>

<body class="student student-calender">
  <!-- ===== 사이드바 ===== -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- ===== 메인 ===== -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
    <!-- Calendar Section -->
        <div class="calender-box">
            <div class="calender-header">
                <div class="month-control">
                    <button class="month-btn" id="prevBtn">◀</button>
                    <div class="month-title" id="monthTitle">이게 몇년 몇월일까</div>
                    <button class="month-btn" id="nextBtn">▶</button>
                    <button class="today-btn" id="todayBtn">오늘</button>
                </div>

        <div class="legend">
            <span><span class="dot blue"></span>수업</span>
            <span><span class="dot orange"></span>시험</span>
            <span><span class="dot red"></span>휴일/행사</span>
        </div>
      </div>

      <div class="calender-grid" id="calender"></div>

      <p class="calender-note">
        ※ 일정이 많은 날은 셀 하단의 +N 표시를 눌러 세부 내용을 확인할 수 있습니다.
      </p>
    </section>
  </main>

  <script>
    document.addEventListener("DOMContentLoaded", () => {
          const calendar = document.getElementById("calender");
          const monthTitle = document.getElementById("monthTitle");
          const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
          let current = new Date();

          const events = {
            "2025-10-03": ["웹 프로젝트 수업", "프론트 퀴즈"],
            "2025-10-12": ["중간평가"],
            "2025-10-15": ["학원 휴무"],
            "2025-10-19": ["팀 프로젝트 발표", "프로젝트 미팅"],
            "2025-10-27": ["버프 리허설"]
          };

          function renderCalendar(date) {
            calendar.innerHTML = "";

            const year = date.getFullYear();
            const month = date.getMonth();
            const firstDay = new Date(year, month, 1).getDay();
            const lastDate = new Date(year, month + 1, 0).getDate();

            console.log("현재 날짜 정보:", "year =", year, ", month =", month, ", firstDay =", firstDay, ", lastDate =", lastDate);

            monthTitle.textContent = year + "년 " + (month + 1) + "월";


            // 요일 헤더 추가
            daysOfWeek.forEach(day => {
              const header = document.createElement("div");
              header.classList.add("day-header");
              header.textContent = day;
              calendar.appendChild(header);
            });

            // 첫 주 공백
            for (let i = 0; i < firstDay; i++) {
              const empty = document.createElement("div");
              empty.classList.add("day-cell");
              calendar.appendChild(empty);
            }

            // 날짜 셀 생성
            for (let i = 1; i <= lastDate; i++) {
              const day = document.createElement("div");
              day.classList.add("day-cell");

              const span = document.createElement("span");
              span.classList.add("day-num");
              span.textContent = i;
              day.appendChild(span);

              // 날짜 key (예: 2025-10-03)
              const key = year + "-" + String(month + 1).padStart(2, "0") + "-" + String(i).padStart(2, "0");

              if (events[key]) {
                const ul = document.createElement("ul");
                ul.classList.add("event-list");
                events[key].forEach(e => {
                  const li = document.createElement("li");
                  li.textContent = e;
                  ul.appendChild(li);
                });
                day.appendChild(ul);
              }

              calendar.appendChild(day);
            }

            // 오늘 날짜 강조
            const today = new Date();
            if (today.getFullYear() === year && today.getMonth() === month) {
              const todayCells = document.querySelectorAll(".day-cell");
              todayCells.forEach(cell => {
                const num = cell.querySelector(".day-num");
                if (num && parseInt(num.textContent) === today.getDate()) {
                  cell.classList.add("today");
                }
              });
            }
          }

          // 초기 렌더
          renderCalendar(current);

          // 버튼 이벤트
          document.getElementById("prevBtn").addEventListener("click", () => {
            current.setMonth(current.getMonth() - 1);
            renderCalendar(current);
          });
          document.getElementById("nextBtn").addEventListener("click", () => {
            current.setMonth(current.getMonth() + 1);
            renderCalendar(current);
          });
          document.getElementById("todayBtn").addEventListener("click", () => {
            current = new Date();
            renderCalendar(current);
          });
        });
  </script>
</body>
</html>