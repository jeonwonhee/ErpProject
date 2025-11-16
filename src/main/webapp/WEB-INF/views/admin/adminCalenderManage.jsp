<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 일정관리</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </head>

    <body class="admin admin-calendar-manage">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content calendar-container">
                <div class="card">
                    <!-- 검색창 -->
                    <div class="search-box">
                        <input type="text" placeholder="검색" />
                        <button class="btn-submit">검색</button>
                    </div>

                    <!-- 일정 테이블 -->
                    <div class="calendar-table-section">
                        <table class="calendar-table">
                            <thead>
                                <tr>
                                <th>일정번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>상태</th>
                                <th>승인여부</th>
                                </tr>
                            </thead>
                            <tbody id="approvalArea">
                                <c:forEach var="a" items="${approvalList}">

                                </c:forEach>
                            </tbody>
                        </table>
                        <div id="approvalPage" class="pagination">

                        </div>
                    </div>
                </div>
            </section>
        </main>

        <script>
            function loadApproval(page) {

                fetch('/ajax/adminCalender?page=' + page)
                .then(resp => resp.json())
                .then(data => {

                    /* ----- 1) 테이블 렌더링 ----- */
                    const area = document.getElementById("approvalArea");
                    area.innerHTML = "";

                    if (data.approvalList.length === 0) {
                        area.innerHTML =
                            '<tr><td colspan="6" style="text-align:center;color:#666;">등록된 일정이 없습니다.</td></tr>';
                    } else {
                        data.approvalList.forEach(function(a) {

                            area.innerHTML +=
                                '<tr class="clickable" ' +
                                    'onclick="location.href=\'' +
                                        '${pageContext.request.contextPath}/adminCalenderDetail.co?lectureDateNo=' +
                                        a.lectureDateNo +
                                    '\'">' +

                                    '<td>' + a.lectureDateNo + '</td>' +
                                    '<td>' + a.title + '</td>' +
                                    '<td>' + a.writer + '</td>' +
                                    '<td>' + a.approvalDate + '</td>' +

                                    '<td>' +
                                        (a.status === "IN_PROGRESS" ? '<span class="status pending">처리중</span>' : '') +
                                        (a.status === "APPROVED"    ? '<span class="status approved">접수</span>'  : '') +
                                        (a.status === "REJECTED"    ? '<span class="status rejected">반려</span>'  : '') +
                                    '</td>' +

                                    '<td>' +
                                        (a.status === "APPROVED" ? '<span class="approved">승인</span>' : '') +
                                        (a.status === "REJECTED" ? '<span class="rejected">반려</span>' : '') +
                                        (a.status !== "APPROVED" && a.status !== "REJECTED"
                                            ? '<span class="pending">대기</span>'
                                            : '') +
                                    '</td>' +

                                '</tr>';
                        });
                    }


                    /* ----- 2) 페이징 렌더링 ----- */
                    const pageArea = document.getElementById("approvalPage");
                    pageArea.innerHTML = "";

                    // ◀ 이전
                    if (page > 1) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" class="page-btn" onclick="loadApproval(' + (page - 1) + ')">◀</a>';
                    }

                    // 페이지 번호들
                    for (let p = data.startPage; p <= data.endPage; p++) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" ' +
                            'class="page-btn' + (p === page ? ' active' : '') + '" ' +
                            'onclick="loadApproval(' + p + ')">' +
                            p +
                            '</a>';
                    }

                    // ▶ 다음
                    if (page < data.maxPage) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" class="page-btn" onclick="loadApproval(' + (page + 1) + ')">▶</a>';
                    }
                });
            }

            loadApproval(1);
        </script>
    </body>
</html>
