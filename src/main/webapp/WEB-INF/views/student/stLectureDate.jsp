<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 학생 일정조회</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/student.css">
  <link rel="stylesheet" href="/styles/common.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

</head>

<body class="student calender">
  <!-- ===== 사이드바 ===== -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- ===== 메인 ===== -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
    <!-- Calender Section -->
        <div class="calender-box">
            <div class="calender-header">
                <div class="month-control">
                    <button class="month-btn" id="prevBtn">◀</button>
                    <div class="month-title" id="monthTitle">2025년 10월</div>
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
        window.onload = function() {

            const calender = document.getElementById("calender");
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

            function renderCalender(date) {
                calender.innerHTML = "";

                const year = date.getFullYear();
                const month = date.getMonth();
                const firstDay = new Date(year, month, 1).getDay();
                const lastDate = new Date(year, month + 1, 0).getDate();

                monthTitle.textContent = year + "년 " + (month + 1) + "월";


                // 요일 헤더 추가
                daysOfWeek.forEach(day => {
                  const header = document.createElement("div");
                  header.classList.add("day-header");
                  header.textContent = day;
                  calender.appendChild(header);
                });

                // 첫 주 공백
                for (let i = 0; i < firstDay; i++) {
                  const empty = document.createElement("div");
                  empty.classList.add("day-cell");
                  calender.appendChild(empty);
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

                  calender.appendChild(day);
                }

                // 오늘 날짜 강조
                const today = new Date();
                const todayDate = today.getDate();

                document.querySelectorAll(".day-cell").forEach(cell => {
                    const num = cell.querySelector(".day-num");
                    if (num && parseInt(num.textContent) === todayDate) {
                        cell.classList.add("today");
                    }
                    console.log(num && parseInt(num.textContent) === todayDate);
                });
            }

            // 초기 렌더
            renderCalender(current);

            // 버튼 이벤트
            document.getElementById("prevBtn").addEventListener("click", () => {
                current.setMonth(current.getMonth() - 1);
                renderCalender(current);
            });
            document.getElementById("nextBtn").addEventListener("click", () => {
                current.setMonth(current.getMonth() + 1);
                renderCalender(current);
            });
            document.getElementById("todayBtn").addEventListener("click", () => {
                current = new Date();
                renderCalender(current);
            });

        };
    </script>
</body>
</html>