<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
      <meta charset="UTF-8">
      <title>KH EduERP | 관리자 대시보드</title>

      <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    </head>

    <body class="admin">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
        <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="stats-row">
                    <div class="stat-box"><h4>전체 학생수</h4><p>128</p></div>
                    <div class="stat-box"><h4>전체 강사수</h4><p>12</p></div>
                    <div class="stat-box"><h4>학생 평균 출석률</h4><p>90%</p></div>
                    <div class="stat-box"><h4>강사 평균 출석률</h4><p>98%</p></div>
                    <div class="stat-box"><h4>금일 결석자</h4><p>4</p></div>
                </div>

                <div class="bottom-section">
                    <div class="card">
                        <h3>요일별 출석률</h3>
                        <div class="chart-placeholder">
                            <img src="images\SimpleBarChart - ShowCartesianGrid, !ShowXAxis, !ShowYAxis, !ShowLegend, ShowTooltip.png" alt="요일별 출석률 그래프">
                        </div>
                    </div>
                    <div class="card" style="max-width:300px;">
                        <h3>알림</h3>
                        <ul class="alert-list">
                            <li>휴가 승인 대기 3건</li>
                            <li>신규 학생 등록 2건</li>
                        </ul>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
