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

            <section class="content">
                <div class="card">
                    <h2>휴강 요청</h2>

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
                        <textarea class="form-textarea" readonly> ${detail.content} </textarea>
                    </div>


                    <div class="form-group">
                        <label>승인 여부</label>
                        <div class="radio-group">
                            <label><input type="radio" name="approve" value="APPROVED" {detail.status == 'APPROVED' ? 'checked' : ''}> 승인</label>
                            <label><input type="radio" name="approve" value="REJECTED" ${detail.status == 'REJECTED' ? 'checked' : ''}> 반려</label>
                        </div>
                    </div>

                    <div class="form-group approval-reject">
                        <label>반려 사유</label>
                        <input type="text" class="form-input" id="approvalReject" placeholder="반려 시 사유를 입력하세요">
                    </div>

                    <button class="btn-submit" type="button" onclick="submitApproval()">등록하기</button>
                </div>
            </section>
        </main>

        <script>
            function submitApproval() {
                    const lectureDateNo = ${detail.lectureDateNo};
                    const status = document.querySelector('input[name="approve"]:checked')?.value;
                    const reason = document.getElementById('approvalReject').value;

                    if (!status) {
                        alert("승인 여부를 선택해주세요.");
                        return;
                    }

                    $.ajax({
                        type: "POST",
                        url: "${pageContext.request.contextPath}/adminCalenderManage.co",
                        data: { lectureDateNo, status, reason },
                        success: function (res) {
                            if (res === "success") {
                                alert("승인 상태가 반영되었습니다.");
                                location.href = "${pageContext.request.contextPath}/adminCalenderManage.co";
                            } else {
                                alert("처리 실패");
                            }
                        },
                        error: function () {
                            alert("서버 오류 발생");
                        }
                    });
                }
        </script>
    </body>
</html>

