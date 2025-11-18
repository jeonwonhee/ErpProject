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

    </head>

    <body class="student calender">
        <!-- ===== 사이드바 ===== -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- ===== 메인 ===== -->
        <main class="main">
            <c:set var="pageName" value="일정조회" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <h2 class="class-title">${className} 일정</h2>

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
            $(document).ready(function () {

                const $calendar = $("#calender");
                const $monthTitle = $("#monthTitle");
                const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
                let current = new Date();

                const events = [];
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

                console.log("📅 전달된 events 데이터:", events);

                // ===== 달력 렌더링 =====
                function renderCalendar(date) {
                    $calendar.empty();

                    const year = date.getFullYear();
                    const month = date.getMonth();
                    const firstDay = new Date(year, month, 1).getDay();
                    const lastDate = new Date(year, month + 1, 0).getDate();

                    $monthTitle.text(year + "년 " + (month + 1) + "월");

                    // 요일 헤더
                    daysOfWeek.forEach(day => {
                        $("<div>").addClass("day-header").text(day).appendTo($calendar);
                    });

                    // 첫 주 공백
                    for (let i = 0; i < firstDay; i++) {
                        $("<div>").addClass("day-cell").appendTo($calendar);
                    }

                    // 날짜 셀 생성
                    for (let i = 1; i <= lastDate; i++) {
                        const $day = $("<div>").addClass("day-cell");
                        $("<span>").addClass("day-num").text(i).appendTo($day);

                        const key = year + "-" +
                                    (String(month + 1).length === 1 ? "0" + String(month + 1) : String(month + 1)) +
                                    "-" + (String(i).length === 1 ? "0" + String(i) : String(i));

                        const matchEvent = events.find(ev => {
                            const start = new Date(ev.startDate);
                            const end = new Date(ev.endDate);
                            const currentDate = new Date(key);
                            return start <= currentDate && currentDate <= end;
                        });

                        if (matchEvent) {
                            const $dot = $("<span>").addClass("dot");
                            if (matchEvent.type === "CLASS") $dot.addClass("blue");
                            else if (matchEvent.type === "OFF") $dot.addClass("red");
                            else if (matchEvent.type === "EXAM") $dot.addClass("orange");

                            const $content = $("<div>").addClass("event-content").text(matchEvent.content);
                            $day.append($dot, $content);
                        }

                        $calendar.append($day);
                    }

                    // 오늘 날짜 강조
                    const today = new Date();
                    const todayDate = today.getDate();
                    const todayMonth = today.getMonth();
                    const todayYear = today.getFullYear();

                    $(".day-cell").each(function () {
                        const $num = $(this).find(".day-num");
                        if (year === todayYear && month === todayMonth && parseInt($num.text()) === todayDate) {
                            $(this).addClass("today");
                        }
                    });

                    attachModalEvents();
                }

                // ===== 모달 =====
                const $modal = $("#eventModal");
                const $modalTitle = $("#modalTitle");
                const $modalBody = $("#modalBody");

                function openModal(dateKey) {
                    console.log("🟦 클릭된 날짜:", dateKey);

                    const matchEvent = events.find(ev => ev.startDate <= dateKey && dateKey <= ev.endDate);
                    console.log("🧠 매칭된 이벤트:", matchEvent);

                    const parts = dateKey.split("-");
                    const month = parseInt(parts[1]);
                    const day = parseInt(parts[2]);
                    $modalTitle.html(month + "월 " + day + "일 일정");

                    if (matchEvent) {
                        let typeLabel, dotColor;
                        switch (matchEvent.type) {
                            case "CLASS":
                                typeLabel = "수업"; dotColor = "blue"; break;
                            case "OFF":
                                typeLabel = "휴일/행사"; dotColor = "red"; break;
                            case "EXAM":
                                typeLabel = "시험"; dotColor = "orange"; break;
                            default:
                                typeLabel = "미정"; dotColor = "gray";
                        }

                        $modalBody.html(
                            '<p><strong>제목:</strong> ' + matchEvent.title + '</p>' +
                            '<p><strong>구분:</strong> <span class="dot ' + dotColor + '"></span> ' + typeLabel + '</p>' +
                            '<p><strong>내용:</strong><br>' + matchEvent.content + '</p>'
                        );
                    } else {
                        $modalBody.text("등록된 일정이 없습니다.");
                    }

                    $modal.css("display", "flex");
                }

                window.closeModal = function () {
                    $modal.hide();
                };

                function attachModalEvents() {
                    $(".day-cell").each(function () {
                        const $num = $(this).find(".day-num");
                        if ($num.length) {
                            const dayNum = parseInt($num.text());
                            const key = current.getFullYear() + "-" +
                                        (String(current.getMonth() + 1).length === 1 ? "0" + String(current.getMonth() + 1) : String(current.getMonth() + 1)) +
                                        "-" + (String(dayNum).length === 1 ? "0" + String(dayNum) : String(dayNum));
                            $(this).off("click").on("click", () => openModal(key));
                        }
                    });
                }

                // ===== 버튼 이벤트 =====
                $("#prevBtn").on("click", () => {
                    current.setMonth(current.getMonth() - 1);
                    renderCalendar(current);
                });

                $("#nextBtn").on("click", () => {
                    current.setMonth(current.getMonth() + 1);
                    renderCalendar(current);
                });

                $("#todayBtn").on("click", () => {
                    current = new Date();
                    renderCalendar(current);
                });

                // 초기 렌더
                renderCalendar(current);
            });
        </script>
    </body>
</html>