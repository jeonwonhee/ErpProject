<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 기자재 관리 통합</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    </head>

    <body class="admin admin-facility">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <!-- 기자재 현황 -->
                <h2 class="section-title">기자재 현황 <button class="add-btn" onclick="location.href='${pageContext.request.contextPath}/adminFacilityDetail.co'">+ 기자재 추가</button></h2>
                <div class="card">
                    <div class="facility-list">
                        <div class="facility-card expanded">
                            <div class="facility-title">
                                <h3>컴퓨터</h3>
                                <span class="badge ok">정상</span>
                            </div>
                            <p class="facility-meta">카테고리 : <strong>기기</strong></p>
                            <span class="location-pill">Q반</span>
                            <div class="action-buttons">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </div>
                        </div>

                        <div class="facility-card">
                            <div class="facility-title">
                                <h3>빔 프로젝터</h3>
                                <span class="badge repair">수리중</span>
                            </div>
                            <p class="facility-meta">카테고리 : <strong>기기</strong></p>
                            <span class="location-pill">H반</span>
                            <div class="action-buttons">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </div>
                        </div>

                        <div class="facility-card">
                            <div class="equip-title">
                                <h3>마우스</h3>
                                <span class="badge lost">분실</span>
                            </div>
                            <p class="facility-meta">카테고리 : <strong>주변기기</strong></p>
                            <span class="location-pill">A반</span>
                            <div class="action-buttons">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 기자재 상태 -->
                <h2 class="section-title">기자재 상태</h2>
                <div class="card">
                    <div class="filter-bar">
                        <label for="classSelect">반 선택:</label>
                        <select id="classSelect">
                            <option value="all">전체</option>
                            <option value="A">A반</option>
                            <option value="B">B반</option>
                            <option value="C">C반</option>
                            <option value="D">D반</option>
                        </select>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>반</th>
                                <th>기자재 수</th>
                                <th>정상</th>
                                <th>수리중</th>
                                <th>분실</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>A반</td>
                                <td>15</td>
                                <td class="status-ok">13</td>
                                <td class="status-repair">1</td>
                                <td class="status-lost">1</td>
                            </tr>
                            <tr>
                                <td>B반</td>
                                <td>12</td>
                                <td class="status-ok">11</td>
                                <td class="status-repair">1</td>
                                <td class="status-lost">0</td>
                            </tr>
                            <tr>
                                <td>C반</td>
                                <td>14</td>
                                <td class="status-ok">14</td>
                                <td class="status-repair">0</td>
                                <td class="status-lost">0</td>
                            </tr>
                            <tr>
                                <td>D반</td>
                                <td>10</td>
                                <td class="status-ok">8</td>
                                <td class="status-repair">2</td>
                                <td class="status-lost">0</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </body>
</html>
