<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
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

            <section class="content calendar-container">
                <!-- 검색창 -->
                <div class="search-box">
                    <input type="text" placeholder="검색" />
                    <button class="btn-search">검색</button>
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
                        <tbody>
                            <tr class="clickable">
                                <td>18</td>
                                <td>휴강</td>
                                <td>김강사</td>
                                <td>2025-10-25</td>
                                <td><span class="status received">접수</span></td>
                                <td class="approved">승인</td>
                            </tr>
                            <tr class="clickable">
                                <td>17</td>
                                <td>휴강</td>
                                <td>이강사</td>
                                <td>2025-10-28</td>
                                <td><span class="status processing">처리중</span></td>
                                <td class="rejected">반려</td>
                            </tr>
                            <tr class="clickable">
                                <td>16</td>
                                <td>휴강</td>
                                <td>이강사</td>
                                <td>2025-10-21</td>
                                <td><span class="status processing">처리중</span></td>
                                <td class="approved">승인</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- 우측 패널 -->
            <aside class="detail-panel">
                <h3>휴강신청</h3>
                <p>작성자: <b>김강사</b></p>
                <p>작성일: <span>2025-10-28</span></p>

                <div class="detail-box">
                    <label>휴강사유</label>
                    <textarea readonly>~~~ 이유로 휴강 신청합니다.</textarea>
                </div>

                <div class="approval-radio">
                    <label><input type="radio" name="approval" /> 승인</label>
                    <label><input type="radio" name="approval" /> 반려</label>
                </div>

                <div class="reject-box">
                    <label>반려사유</label>
                    <textarea placeholder="사유를 입력하세요.">연차를 모두 소진하셨습니다.</textarea>
                </div>

                <div class="btn-group">
                    <button class="btn-delete">삭제</button>
                    <button class="btn-submit">등록</button>
                </div>
            </aside>
        </main>
    </body>
</html>
