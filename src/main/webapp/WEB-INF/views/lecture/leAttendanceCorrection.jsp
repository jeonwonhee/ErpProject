<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KH EduERP | 출결정정 처리</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\lecture.css">
    </head>

    <body class="lecture lecture-attendance-correction">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

            <main class="main">
            <header class="topbar">
                <div class="path">강사 &gt; 반려페이지 <b>강사 페이지</b></div>
                <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
            </header>

            <section class="content">
                <div class="card">
                    <h2>출결 정정 요청</h2>

                    <form action="${pageContext.request.contextPath}/leAttendanceCorrection.co" method="post">
                        <div class="form-group">
                            <label>제목</label>
                            <input type="text" class="form-input" value="출석 정정 요청합니다">
                        </div>

                        <div class="form-group">
                            <label>첨부파일</label>
                            <div class="file-box">
                                <label for="fileInput" class="file-label">파일선택</label>
                                <input type="file" id="fileInput">
                                <span>진단서.JPG</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>정정 요청일</label>
                            <input type="text" class="form-input" value="2025.10.29">
                        </div>

                        <div class="form-group">
                            <label>신청 사유</label>
                            <textarea class="form-textarea">교통사고 나서 입원했는데 병가 처리로 바꿔주세요.</textarea>
                        </div>

                        <div class="form-group">
                            <label>승인 여부</label>
                                <div class="radio-group">
                                    <label><input type="radio" name="approve" checked> 승인</label>
                                    <label><input type="radio" name="approve"> 반려</label>
                                </div>
                        </div>

                        <div class="form-group">
                            <label>반려 사유</label>
                            <input type="text" class="form-input" value="병가 모두 소진하셨습니다.">
                        </div>

                        <button class="btn-submit">등록하기</button>
                    </form>
                </div>
            </section>
        </main>
    </body>
</html>