<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:set var="pageName" value="출결정정 처리" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content">
                <div class="card">
                    <h2>출결 정정 요청</h2>

                    <form action="${pageContext.request.contextPath}/lectureAttendanceCorrection.co" method="post">

                        <input type="hidden" name="attendUpdateNo" value="${detail.attendUpdateNo}">

                        <div class="form-group">
                            <label>첨부파일</label>
                            <div class="file-box">
                                <a download="${detail.attendUpdateFileOriName}"
                                   href="${pageContext.request.contextPath}/${detail.filePath}${detail.attendUpdateFileName}">
                                    ${detail.attendUpdateFileName}
                                </a>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>정정 요청일</label>
                            <input type="text" class="form-input" readonly value="${detail.correctionApplicationDate}">
                        </div>

                        <div class="form-group">
                            <label>신청 사유</label>
                            <textarea class="form-textarea" readonly>${detail.attendUpdateContent}</textarea>
                        </div>

                        <div class="form-group">
                            <label>승인 여부</label>
                                <div class="radio-group">
                                    <label><input class="input-status" type="radio" name="status" onchange="changeStatus()"  value="APPROVED" ${detail.status != 'REQUESTED' ? 'disabled' : ''} ${detail.status eq 'APPROVED' ? 'checked="checked"' : ''}>승인</label>
                                    <label><input class="input-status" type="radio" name="status" onchange="changeStatus()" value="REJECTED" ${detail.status != 'REQUESTED' ? 'disabled' : ''} ${detail.status eq 'REJECTED' ? 'checked="checked"' : ''}>반려</label>
                                </div>
                        </div>


                        <div class="form-group">
                            <label>반려 사유</label>
                            <c:choose>
                                <c:when test="${detail.status eq 'REQUESTED'}">
                                    <input type="text" class="form-input rejected-input" name="refusal" readonly>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" class="form-input rejected-input" name="refusal" readonly value="${detail.refusal}">
                                </c:otherwise>
                            </c:choose>

                        </div>
                        <c:if test="${detail.status eq 'REQUESTED'}">
                            <button class="btn-submit">등록하기</button>
                        </c:if>
                    </form>
                </div>
            </section>
        </main>
    <script>

        function changeStatus() {
            let inputStatus = document.querySelectorAll(".input-status");
            let inputReject = document.querySelector(".rejected-input");
            inputStatus.forEach(function(data,index) {
               console.log(data.checked);
               if (data.checked) {
                   if (data.value === 'REJECTED') {
                       inputReject.removeAttribute("readonly");
                   } else {
                       inputReject.value = "";
                       inputReject.readOnly = true;
                   }
               }

            });
        }

    </script>
    </body>
</html>