<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 기자재 신청</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/student.css">
    </head>
    <body class="student student-facility" >
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="facility-container">
                    <!-- 기자재 신청 폼 -->
                    <div class="card">
                        <h2>기자재 신청</h2>
                        <form>
                            <div class="form-group">
                                <label for="deviceType">기자재 종류</label>
                                <select id="deviceType" name="deviceName">
                                    <option value="">선택하세요</option>
                                    <option>노트북</option>
                                    <option>빔프로젝터</option>
                                    <option>마이크</option>
                                    <option>HDMI 케이블</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="deviceCount">수량</label>
                                <input type="number" id="deviceCount" min="1" max="10" placeholder="1" />
                            </div>

                            <div class="form-group">
                                <label for="memo">비고</label>
                                <textarea id="memo" placeholder="필요 시 사유를 입력하세요"></textarea>
                            </div>

                            <div class="form-submit">
                                <button type="submit" class="btn-submit">신청하기</button>
                            </div>
                        </form>
                    </div>

                    <!-- 기자재 신청 내역 -->
                    <div class="card facility-history">
                        <h2>신청 내역</h2>
                        <table>
                            <thead>
                                <tr>
                                    <th>기자재명</th>
                                    <th>수량</th>
                                    <th>신청일</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>노트북</td>
                                    <td>1</td>
                                    <td>2025.11.02</td>
                                    <td><span class="status pending">대기중</span></td>
                                </tr>
                                <tr>
                                    <td>HDMI 케이블</td>
                                    <td>2</td>
                                    <td>2025.10.29</td>
                                    <td><span class="status approved">승인</span></td>
                                </tr>
                                <tr>
                                    <td>빔프로젝터</td>
                                    <td>1</td>
                                    <td>2025.10.21</td>
                                    <td><span class="status rejected">반려</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </body>
</html>
