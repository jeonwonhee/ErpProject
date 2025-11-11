<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 일정관리</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    </head>

    <body class="admin admin-calendar-manage">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="card">
                    <h2>휴강 요청</h2>

                    <form action="${pageContext.request.contextPath}/adminCalenderManage.co" method="post">

                        <input type="hidden" name="lectureDateNo" value="${detail.lectureDateNo}">

                        <div class="form-group">
                            <label>제목</label>
                            <input type="text" class="form-input" value="${detail.title}" readonly>
                        </div>

                        <div class="form-group">
                            <label>휴강 요청일</label>
                            <input type="text" class="form-input" value="${detail.startDate} ~ ${detail.endDate}" readonly>
                        </div>

                        <div class="form-group">
                            <label>신청 사유</label>
                            <textarea class="form-textarea" readonly>${detail.content}</textarea>
                        </div>

                        <div class="form-group">
                            <label>승인 여부</label>
                            <div class="radio-group">
                                <label><input type="radio" name="status" value="APPROVED" ${detail.status eq 'APPROVED' ? 'checked="checked"' : ''}>승인</label>
                                <label><input type="radio" name="status" value="REJECTED" ${detail.status eq 'REJECTED' ? 'checked="checked"' : ''}>반려</label>
                            </div>
                        </div>

                        <div class="form-group approval-reject">
                            <label>반려 사유</label>
                            <input type="text" class="form-input" name="reason" value="${detail.rejectReason}" placeholder="반려 시 사유를 입력하세요">
                        </div>

                        <button class="btn-submit" type="submit">등록하기</button>
                    </form>
                </div>
            </section>
        </main>
    </body>
</html>
