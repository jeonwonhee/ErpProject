<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 강사 일정관리</title>

        <!-- 통합된 스타일 -->
        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/lecture.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    </head>

    <body class="lecture calender">
        <c:set var="pageName" value="일정관리" scope="request"></c:set>
        <!-- ===== 사이드바 ===== -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- ===== 메인 영역 ===== -->
        <main class="main">
            <c:set var="pageName" value="일정관리" scope="request"></c:set>
            <!-- 상단바 -->
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <!-- 콘텐츠 영역 -->
            <section class="content">
                <select id="classSelect" class="classSelect" onchange="changeClass()">
                    <c:forEach var="c" items="${classList}">
                        <option value="${c.classLectureNo}"
                            <c:if test="${c.classLectureNo eq selectedClassLectureNo}">selected</c:if>>
                            ${c.className}
                        </option>
                    </c:forEach>
                </select>

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
                                <c:forEach var="e" items="${upcomingList}">
                                    <tr>
                                        <td>${e.startDate} ~ ${e.endDate}</td>
                                        <td>${e.title}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${e.status eq 'APPROVED'}"><span class="status-approved">승인</span></c:when>
                                                <c:when test="${e.status eq 'REJECTED'}"><span class="status-rejected">반려</span></c:when>
                                                <c:otherwise><span class="status-pending">대기</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="?classLectureNo=${selectedClassLectureNo}&page=${currentPage - 1}" class="page-btn">◀</a>
                            </c:if>

                            <c:forEach var="p" begin="${startPage}" end="${endPage}">
                                <a href="?classLectureNo=${selectedClassLectureNo}&page=${p}"
                                   class="page-btn ${p == currentPage ? 'active' : ''}">
                                    ${p}
                                </a>
                            </c:forEach>

                            <c:if test="${currentPage < maxPage}">
                                <a href="?classLectureNo=${selectedClassLectureNo}&page=${currentPage + 1}" class="page-btn">▶</a>
                            </c:if>
                        </div>
                    </div>
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
            window.onload = function () {

                var calendar = document.getElementById("calender");
                var monthTitle = document.getElementById("monthTitle");
                var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
                var current = new Date();

                // ===== 날짜 두 자리로 맞추기 =====
                function twoDigit(n) {
                    return (n < 10 ? "0" + n : n);
                }

                // ===== 데이터 =====
                var events = [];

                <c:if test="${not empty events}">
                    <c:forEach var="e" items="${events}">
                        events.push({
                            startDate: "${e.startDate}",
                            endDate: "${e.endDate}",
                            title: "${e.title}",
                            content: "${e.content}",
                            type: "${e.dateType}"
                        });
                    </c:forEach>
                </c:if>

                //======= 달력 렌더링 =======
                function renderCalendar(date) {

                    calendar.innerHTML = "";

                    var year = date.getFullYear();
                    var month = date.getMonth();
                    var firstDay = new Date(year, month, 1).getDay();
                    var lastDate = new Date(year, month + 1, 0).getDate();

                    monthTitle.textContent = year + "년 " + (month + 1) + "월";

                    //===== 요일 헤더 =====
                    for (var i = 0; i < daysOfWeek.length; i++) {
                        var header = document.createElement("div");
                        header.classList.add("day-header");
                        header.textContent = daysOfWeek[i];
                        calendar.appendChild(header);
                    }

                    //===== 첫 주 빈칸 =====
                    for (var e = 0; e < firstDay; e++) {
                        var empty = document.createElement("div");
                        empty.classList.add("day-cell");
                        calendar.appendChild(empty);
                    }

                    //===== 날짜 셀 생성 =====
                    for (var day = 1; day <= lastDate; day++) {

                        var cell = document.createElement("div");
                        cell.classList.add("day-cell");

                        var span = document.createElement("span");
                        span.classList.add("day-num");
                        span.textContent = day;
                        cell.appendChild(span);

                        // 날짜 key 생성
                        var key = year + "-" + twoDigit(month + 1) + "-" + twoDigit(day);

                        //===== 해당 날짜에 매칭되는 일정 찾기 (기간 일정 포함) =====
                        var matchEvent = null;
                        for (var k = 0; k < events.length; k++) {
                            var start = new Date(events[k].startDate);
                            var end = new Date(events[k].endDate);
                            var now = new Date(key);

                            if (start <= now && now <= end) {
                                matchEvent = events[k];
                                break;
                            }
                        }

                        //===== 일정 표시 =====
                        if (matchEvent !== null) {
                            var dot = document.createElement("span");
                            dot.classList.add("dot");

                            if (matchEvent.type === "CLASS") dot.classList.add("blue");
                            else if (matchEvent.type === "OFF") dot.classList.add("red");
                            else if (matchEvent.type === "EXAM") dot.classList.add("orange");

                            var content = document.createElement("div");
                            content.classList.add("event-content");
                            content.textContent = matchEvent.title;

                            cell.appendChild(dot);
                            cell.appendChild(content);
                        }

                        calendar.appendChild(cell);
                    }

                    //====== 오늘 날짜 강조 ======
                    var today = new Date();
                    var todayDate = today.getFullYear() + "-" + twoDigit(today.getMonth() + 1) + "-" + twoDigit(today.getDate());

                    var cells = document.querySelectorAll(".day-cell");
                    for (var a = 0; a < cells.length; a++) {
                        var num = cells[a].querySelector(".day-num");
                        if (num != null) {
                            var checkKey = year + "-" + twoDigit(month + 1) + "-" + twoDigit(parseInt(num.textContent));
                            if (checkKey === todayDate) {
                                cells[a].classList.add("today");
                            }
                        }
                    }

                    attachModalEvents();
                }

                //======= 모달 =======
                var modal = document.getElementById("eventModal");
                var modalTitle = document.getElementById("modalTitle");
                var modalBody = document.getElementById("modalBody");

                function openModal(dateKey) {

                    var matchEvent = null;
                    for (var i = 0; i < events.length; i++) {
                        if (events[i].startDate <= dateKey && dateKey <= events[i].endDate) {
                            matchEvent = events[i];
                            break;
                        }
                    }

                    var parts = dateKey.split("-");
                    var month = parseInt(parts[1]);
                    var day = parseInt(parts[2]);

                    modalTitle.innerHTML = month + "월 " + day + "일 일정";

                    if (matchEvent !== null) {

                        var typeLabel = "미정";
                        var dotColor = "";

                        if (matchEvent.type === "CLASS") {
                            typeLabel = "수업";
                            dotColor = "blue";
                        } else if (matchEvent.type === "OFF") {
                            typeLabel = "휴일/행사";
                            dotColor = "red";
                        } else if (matchEvent.type === "EXAM") {
                            typeLabel = "시험";
                            dotColor = "orange";
                        }

                        modalBody.innerHTML =
                            "<p><strong>제목:</strong> " + matchEvent.title + "</p>" +
                            "<p><strong>구분:</strong> <span class='dot " + dotColor + "'></span> " + typeLabel + "</p>" +
                            "<p><strong>내용:</strong><br>" + matchEvent.content + "</p>";

                    } else {
                        modalBody.textContent = "등록된 일정이 없습니다.";
                    }

                    modal.style.display = "flex";
                }

                window.closeModal = function () {
                    modal.style.display = "none";
                };


                //======= 날짜 클릭 이벤트 =======
                function attachModalEvents() {
                    var cells = document.querySelectorAll(".day-cell");
                    for (var i = 0; i < cells.length; i++) {
                        var num = cells[i].querySelector(".day-num");

                        if (num != null) {
                            var dayNum = parseInt(num.textContent);

                            var key = current.getFullYear() + "-" +
                                      twoDigit(current.getMonth() + 1) + "-" +
                                      twoDigit(dayNum);

                            (function(keyCopy){
                                cells[i].addEventListener("click", function(){
                                    openModal(keyCopy);
                                });
                            })(key);
                        }
                    }
                }

                //======= 버튼 이벤트 =======
                document.getElementById("prevBtn").addEventListener("click", function () {
                    current.setMonth(current.getMonth() - 1);
                    renderCalendar(current);
                });

                document.getElementById("nextBtn").addEventListener("click", function () {
                    current.setMonth(current.getMonth() + 1);
                    renderCalendar(current);
                });

                document.getElementById("todayBtn").addEventListener("click", function () {
                    current = new Date();
                    renderCalendar(current);
                });

                //======= 초기 렌더링 =======
                renderCalendar(current);
            };
        </script>


    </body>
</html>
