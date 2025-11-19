<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KH EduERP | 상담관리</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/lecture.css">
    </head>
    <body class="lecture lecture-consult-correction">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <c:set var="pageName" value="상담관리" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="card">
                    <form action="${pageContext.request.contextPath}/lectureConsultInsert.co" method="post">
                        <!-- 어떤 상담인지 구분 -->
                        <input type="hidden" name="consultAppNo" value="${consultApplication.consultAppNo}" />

                        <div class="form-group">
                            <label>신청날짜</label>
                            <input type="text" class="form-input"
                                   value="<fmt:formatDate value='${consultApplication.consultTime}' pattern='yyyy-MM-dd'/>"
                                   readonly>
                        </div>

                        <div class="form-group">
                            <label>신청 사유</label>
                            <textarea class="form-textarea" readonly>${consultApplication.consultAppContent}</textarea>
                        </div>

                        <div class="form-group">
                            <label>상담 내용</label>
                            <input type="text" class="form-input" name="content">
                        </div>

                        <button type="submit" class="btn-submit">등록하기</button>
                    </form>

                </div>
            </section>
        </main>
    </body>
</html>