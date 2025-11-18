<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
      <meta charset="UTF-8">
      <title>KH EduERP | 출결관리</title>

      <link rel="stylesheet" href="styles/default.css">
      <link rel="stylesheet" href="styles/style.css">
      <link rel="stylesheet" href="styles/lecture.css">
    </head>

    <body class="lecture lecture-attendance">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

      <!-- 메인 -->
      <main class="main">
        <c:set var="pageName" value="출결관리" scope="request"></c:set>
        <header class="topbar">
          <div class="path">강사 › 출결관리 <b>강사 페이지</b></div>
          <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
        </header>

        <section class="content">
          <!-- 출결 박스 -->
          <div class="class-select">
              <form action="${pageContext.request.contextPath}/selectAttendClass.at" method="get">
                  <label for="classNo">반 : </label>
                  <select name="classNo" id="selectClass">
                      <c:forEach var="c" items="${classList}">
                          <option value="${c.classNo}" ${classInfo[0].classNo == c.classNo ? 'selected' : ''}>${c.className}</option>
                      </c:forEach>
                  </select>
                  <button type="submit">조회</button>
              </form>

            </div>
          <div class="attendance-panel">
            <div class="attendance-head">
              <div class="attendance-info">
                <p>출결 날짜 : <b>${classList[0].planDate}</b></p>
                <p>반 : <b>${classInfo[0].className}</b></p>
                <p>인원 수 : <b>${classInfo[0].memberCount}</b></p>
              </div>
              <div class="attendance-bulk">
                <span class="bulk-title">(일괄처리)</span>
                <div class="bulk-btns">
                  <button type="button" class="att-btn" onclick="location.href='${pageContext.request.contextPath}/attendClassAll.at?classNo=${classInfo[0].classNo}&attendStatus=ATTEND&sessionNo=${classInfo[0].controllNo}'">출석</button>
                  <button type="button" class="att-btn" onclick="location.href='${pageContext.request.contextPath}/attendClassAll.at?classNo=${classInfo[0].classNo}&attendStatus=LATE&sessionNo=${classInfo[0].controllNo}'">지각</button>
                  <button type="button" class="att-btn" onclick="location.href='${pageContext.request.contextPath}/attendClassAll.at?classNo=${classInfo[0].classNo}&attendStatus=ABSENT&sessionNo=${classInfo[0].controllNo}'">결석</button>
                </div>
              </div>
            </div>

            <div class="attendance-list">
              <!-- 한 줄 -->
                <c:forEach var="stList" items="${studentList}">
                    <div class="attendance-row">
                        <div class="attendance-stu">
                            <span class="stu-name">${stList.memberName}</span>
                            <span class="stu-class">${stList.className}</span>
                        </div>
                        <div class="attendance-actions">
                            <button type="button" class="att-btn ${stList.attendStatus eq 'ATTEND' ? 'att-status' : ''}" ${stList.attendStatus eq null ? '' : 'disabled'} onclick="studentAttend(this,'ATTEND',${stList.studentNo},${classInfo[0].controllNo})">출석</button>
                            <button type="button" class="att-btn ${stList.attendStatus eq 'LATE' ? 'late-status' : ''}" ${stList.attendStatus eq null ? '' : 'disabled'} onclick="studentAttend(this,'LATE',${stList.studentNo},${classInfo[0].controllNo})">지각</button>
                            <button type="button" class="att-btn ${stList.attendStatus eq 'ABSENT' ? 'abs-status' : ''}" ${stList.attendStatus eq null ? '' : 'disabled'} onclick="studentAttend(this,'ABSENT',${stList.studentNo},${classInfo[0].controllNo})">결석</button>
                        </div>
                    </div>
                </c:forEach>
            </div>

    <%--        <div class="attendance-footer">
              <button type="button" class="btn-submit">적용</button>
            </div>--%>
          </div>
        </section>
      </main>
    <script>
        function studentAttend(btn,status,studentNo,sessionNo) {

            const row = btn.closest(".attendance-row");

            $.ajax({
                url : "studentAttendMan.at",
                type : "get",
                data : {
                    status : status,
                    studentNo : studentNo,
                    sessionNo : sessionNo
                },
                success: function(result){
                    if (result == "1") {
                        let newClass;
                        if (status === 'ATTEND') {
                            newClass = 'att-status';
                        } else if(status === 'LATE') {
                            newClass = 'late-status';
                        } else {
                            newClass = 'abs-status';
                        }
                        btn.className = btn.className + newClass;

                        const allButtons = row.querySelectorAll(".att-btn");
                        allButtons.forEach(button => {
                            button.disabled = true;
                        });
                    } else {
                        console.log("출석 처리 실패");
                    }

                },
                error: function(err){
                    console.log("출석 체크 요청 실패 : ", err);
                }
            })
        }

    </script>
    </body>
</html>
