<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 기자재 관리</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="admin admin-facility">

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <c:set var="pageName" value="기자재 관리 통합" scope="request"></c:set>
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
        <!-- 기자재 현황 -->
        <h2 class="section-title">
            기자재 현황
            <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/adminFacilityDetail.co'">
                + 기자재 추가
            </button>
        </h2>

        <div class="card">
            <div class="facility-list"><!-- AJAX로 카드 들어감 --></div>

            <!-- 페이징 영역 -->
            <div class="pagination" style="margin-top:20px; text-align:center;"></div>
        </div>

        <!-- 기자재 상태 -->
        <h2 class="section-title">기자재 상태</h2>
<%--        <div class="card">--%>
<%--            <div class="filter-bar">--%>
<%--                <label for="deviceSelect">기자재 선택:</label>--%>
<%--                <select id="deviceSelect">--%>
<%--                    <option value="">선택하세요</option>--%>
<%--                    <c:forEach var="device" items="${list}">--%>
<%--                        <option value="${device.deviceId}">${device.deviceKind}</option>--%>
<%--                    </c:forEach>--%>
<%--                </select>--%>
<%--            </div>--%>
        <div class="card">
            <table>
                <thead>
                <tr>
                    <th>기자재 명</th>
                    <th>총 개수</th>
                    <th>남은 개수</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="device" items="${deviceList}">
                    <tr>
                        <td>${device.deviceKind}</td>
                        <td>${device.deviceCount}</td>
                        <td>${device.deviceRemain}</td>

<%--                        <td>--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${device.status == 'NORMAL'}">정상</c:when>--%>
<%--                                <c:when test="${device.status == 'REPAIR'}">수리중</c:when>--%>
<%--                                <c:when test="${device.status == 'LOST'}">분실</c:when>--%>
<%--                                <c:otherwise>미정</c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </td>--%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>


    </section>
</main>


<script>
    let currentPage = 1; // 전역 변수로 현재 페이지 상태 유지

    $(document).ready(function () {
        loadPage(1); // 첫 페이지 로드
    });

    // AJAX로 카드 + 페이징 데이터 불러오기
    function loadPage(page) {
        currentPage = page; // 현재 페이지 저장
        $.ajax({
            url: "${pageContext.request.contextPath}/getDeviceCards",
            method: "GET",
            data: { cpage: page },
            success: function (response) {
                drawDeviceRentAttList(response.list, response.pi);
            },
            error: function () {
                alert("데이터 로드 실패");
            }
        });
    }

    // 카드 + 페이징 렌더링
    function drawDeviceRentAttList(deviceList, pi) {
        const facilityList = document.querySelector(".facility-list");
        const paginationDiv = document.querySelector(".pagination");

        facilityList.innerHTML = "";
        paginationDiv.innerHTML = "";

        for (let device of deviceList) {
            const card = document.createElement("div");
            card.className = "card facility-card";
            card.id = `card-\${device.deviceRentAttId}`;

            card.innerHTML = `
            <div class="facility-title">
                <h3>\${device.deviceKind}</h3>
                <span class="badge ok">\${device.memberName || "미지정"}</span>
            </div>
            <p class="facility-meta">신청개수 : <strong>\${device.attendAmount}</strong></p>
            <span class="location-pill">신청 날짜 : \${device.startTime || "-"}</span>
            <div class="action-buttons">
                <button class="btn-edit">승인</button>
                <button class="btn-delete">반려</button>
            </div>
        `;
            facilityList.appendChild(card);

            // 승인 버튼
            card.querySelector(".btn-edit").addEventListener("click", function () {
                updateDeviceStatus(device.deviceRentAttId, "APPROVAL");
            });

            // 반려 버튼
            card.querySelector(".btn-delete").addEventListener("click", function () {
                updateDeviceStatus(device.deviceRentAttId, "RETURN");
            });
        }

        // 페이징
        if (pi.currentPage > 1) {
            const prevBtn = document.createElement("button");
            prevBtn.className = "btn btn-primary";
            prevBtn.innerHTML = "&lt; 이전";
            prevBtn.addEventListener("click", function () {
                loadPage(pi.currentPage - 1);
            });
            paginationDiv.appendChild(prevBtn);
        }

        if (pi.currentPage < pi.maxPage) {
            const nextBtn = document.createElement("button");
            nextBtn.className = "btn btn-primary";
            nextBtn.innerHTML = "다음 &gt;";
            nextBtn.addEventListener("click", function () {
                loadPage(pi.currentPage + 1);
            });
            paginationDiv.appendChild(nextBtn);
        }
    }

    function updateDeviceStatus(deviceRentAttId, status) {
        $.ajax({
            url: "${pageContext.request.contextPath}/updateDeviceStatus",
            method: "POST",
            data: { deviceRentAttId: deviceRentAttId, status: status },
            success: function (result) {
                if (result === "1") {
                    loadPage(currentPage);   // 카드 리스트 갱신
                    loadDeviceStatus();      // 기자재 현황 테이블 갱신
                } else {
                    alert("기자재 재고가 부족합니다.");
                }
            },
            error: function () {
                alert("서버 오류 발생");
            }
        });
    }

    function loadDeviceStatus() {
        $.ajax({
            url: "${pageContext.request.contextPath}/getDeviceStatus",
            method: "GET",
            success: function (list) {
                const tbody = document.querySelector("table tbody");
                tbody.innerHTML = ""; // 기존 테이블 비우고
                for (let d of list) {
                    tbody.innerHTML += `
                    <tr>
                        <td>\${d.deviceKind}</td>
                        <td>\${d.deviceCount}</td>
                        <td>\${d.deviceRemain}</td>
                    </tr>
                `;
                }
            }
        });
    }


</script>


</body>
</html>
