<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 출결현황</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
        <!-- Chart.js 외부 라이브러리 로드 -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body class="admin admin-attendance">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content attendance-container">
                <!-- 필터 -->
<%--                <div class="filter-bar">--%>
<%--                    <h2>출결 통계</h2>--%>
<%--                    <select id="period-filter" name="dataSet" onchange="">--%>
<%--                        <option value="student">학생</option>--%>
<%--                        <option value="emp">직원</option>--%>
<%--                    </select>--%>
<%--                </div>--%>

                <!-- 그래프 영역 -->
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>요일별 출석률 <span class="summary"></span></h3>
                        <canvas id="dayChart"></canvas>
                    </div>

                    <div class="chart-card">
                        <h3>출석 비율</h3>
                        <canvas id="pieChart"></canvas>
                    </div>

                    <div class="chart-card wide">
                        <h3>월별 출석률 <span class="summary"></span></h3>
                        <canvas id="monthChart"></canvas>
                    </div>
                </div>
            </section>
        </main>

        <script>
            function init() {
                dataSet();
            }

            //데이터 세팅
            function dataSet() {
                //주간 출석률
                let weekData = ${weekData};
                //전체 출석률
                let allData = ${allData};
                //월별 출석률
                let monthData = ${monthData};

                let weekChartData = [];
                for (let i=0; i< weekData.length; i++) {
                    weekChartData.push(weekData[i].attendRate);
                }

                let allChartData = [];
                for (let i=0; i< allData.length; i++) {
                    if (allData[i].attendStatus === 'ATTEND') {
                        allChartData.splice(0,0,allData[i].attendCount);
                    } else if(allData[i].attendStatus === 'LATE') {
                        allChartData.splice(1,0,allData[i].attendCount);
                    } else {
                        allChartData.splice(2,0,allData[i].attendCount);
                    }

                }

                let monthChartLabel = [];
                let monthChartData = [];
                for (let i=0; i< monthData.length; i++) {
                    let labelMon;
                    if (monthData[i].attendMonth.length > 3) {
                        labelMon = monthData[i].attendMonth.substring(5,7);
                    } else {
                        labelMon = monthData[i].attendMonth;
                    }
                    monthChartData.splice(labelMon-1,0,monthData[i].attendRate);
                    monthChartLabel.splice(labelMon-1,0,labelMon+"월");
                }

                console.log(monthData);
                console.log(monthChartData);

                dayChart(weekChartData);
                pieChart(allChartData);
                monChart(monthChartData,monthChartLabel);
            }

            function dayChart(weekChartData) {
                // 요일별 출석률 (막대그래프)
                new Chart(document.getElementById("dayChart"), {
                    type: 'bar',
                    data: {
                        labels: ["일", "월", "화", "수", "목", "금", "토"],
                        datasets: [{
                            label: "출석률 (%)",
                            data: weekChartData,
                            backgroundColor: "#4B5DFF",
                            borderRadius: 6,
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: { beginAtZero: true, max: 100 }
                        },
                        plugins: { legend: { display: false } }
                    }
                });
            }


            function pieChart(allChartData) {
                // 출석 비율 (도넛차트)
                new Chart(document.getElementById("pieChart"), {
                    type: 'doughnut',
                    data: {
                        labels: ["출석", "지각", "결석"],
                        datasets: [{
                            data: allChartData,
                            backgroundColor: ["#4B5DFF", "#FFD43B", "#FF6B6B"]
                        }]
                    },
                    options: {
                        plugins: {
                            legend: { position: "bottom" }
                        }
                    }
                });
            }


            function monChart(monthChartData,monthChartLabel) {
                // 월별 출석률
                new Chart(document.getElementById("monthChart"), {
                    type: 'line',
                    data: {
                        labels: monthChartLabel,
                        datasets: [{
                            label: "출석률 (%)",
                            data: monthChartData,
                            borderColor: "#4B5DFF",
                            fill: true,
                            backgroundColor: "rgba(75,93,255,0.1)",
                            tension: 0.4
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: { beginAtZero: true, max: 100 }
                        },
                        plugins: { legend: { display: false } }
                    }
                });
            }






            // function selectDataSet() {
            //     let selectSetById = document.getElementById("period-filter");
            //     let selectSet;
            //     for (let i=0; i<selectSetById.options.length; i++) {
            //         if(selectSetById.options[i].selected) {
            //             selectSet = selectSetById.options[i].value;
            //
            //             $.ajax({
            //                 url : "attendStatistics.at",
            //                 type : "get",
            //                 data : {
            //                     dataSet : selectSet
            //                 },
            //                 success: function(result){
            //
            //
            //                 },
            //                 error: function(err){
            //                     console.log("출석 체크 요청 실패 : ", err);
            //                 }
            //             })
            //
            //         }
            //     }
            //
            // }

            document.addEventListener('DOMContentLoaded' , init);
        </script>
    </body>
</html>
