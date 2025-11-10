<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 강사 일정관리</title>

        <!-- ✅ 통합된 스타일 -->
        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/lecture.css">
        <link rel="stylesheet" href="/styles/common.css">
    </head>

    <body class="lecture calender">
        <!-- ===== 사이드바 ===== -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- ===== 메인 영역 ===== -->
        <main class="main">
            <!-- 상단바 -->
            <header class="topbar">
                <div class="path">강사 &gt; 일정관리 <b>강사 페이지</b></div>
                <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
            </header>

            <!-- 콘텐츠 영역 -->
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

                <!-- 달력 -->
                <div class="calender-grid" id="calender"></div>

                <!-- 일정 추가 버튼 -->
                <button class="add-btn" onclick="location.href='${pageContext.request.contextPath}/leCalenderPlus.co'">일정추가</button>

                <br><br>
                <!-- 다가오는 일정 -->
                <div class="upcoming-schedule">
                    <h3>다가오는 일정</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>기간</th>
                                    <th>제목</th>
                                    <th>승인상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>11/14</td>
                                    <td>프로젝트 개발</td>
                                    <td class="status-pending">대기</td>
                                </tr>
                                <tr>
                                    <td>11/19</td>
                                    <td>프로젝트 발표</td>
                                    <td class="status-approved">승인</td>
                                </tr>
                            </tbody>
                        </table>
                </div>
            </section>
        </main>

        <!-- ===== 일정 상세 모달 ===== -->
        <div class="modal" id="eventModal">
            <div class="modal-content">
                <h3 id="modalTitle">일정 상세</h3>
                <p id="modalBody">내용 없음</p>
                <button class="modal-close" onclick="closeModal()">닫기</button>
            </div>
        </div>

        <!-- ===== JavaScript ===== -->
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

                    attachModalEvents();
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

                const modal = document.getElementById("eventModal");
                const modalTitle = document.getElementById("modalTitle");
                const modalBody = document.getElementById("modalBody");

                // 모달 열기
                function openModal(dateKey) {
                    const eventList = events[dateKey];

                    if (eventList && eventList.length > 0) {
                        const [year, month, day] = dateKey.split("-");
                        modalTitle.innerHTML = parseInt(month) + "월 " + parseInt(day) + "일 일정";
                        modalBody.innerHTML = eventList.map(e => `<li>${e}</li>`).join("");
                    } else {
                        modalTitle.innerHTML = "일정 없음";
                        modalBody.innerHTML = "등록된 일정이 없습니다.";
                    }
                    modal.style.display = "flex";
                }

                // 모달 닫기
                window.closeModal = function() {
                    modal.style.display = "none";
                }

                function attachModalEvents() {
                    document.querySelectorAll(".day-cell").forEach(cell => {
                        const num = cell.querySelector(".day-num");
                        if (num) {
                            const dayNum = parseInt(num.textContent);
                            const key = current.getFullYear() + "-" +
                                        String(current.getMonth() + 1).padStart(2, "0") + "-" +
                                        String(dayNum).padStart(2, "0");
                            cell.addEventListener("click", () => openModal(key));
                        }
                    });
                }

            };
        </script>
    </body>
</html>
