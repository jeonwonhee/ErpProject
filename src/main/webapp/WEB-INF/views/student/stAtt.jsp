<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 출결정정 신청</title>
  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/student.css">
</head>

<body class="student student-attendance">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content attendance-correction">
      <!-- 정정신청 폼 -->
      <div class="card correction-form">
        <h2>출석정정 신청</h2>
        <form enctype="multipart/form-data" action="${pageContext.request.contextPath}/insertAttendOrder.at" method="post">
            <div class="form-group">
                <label>정정 사유</label>
                <textarea placeholder="사유를 입력하세요." name="attendUpdateContent"></textarea>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <label>정정할 날짜</label>
                    <input type="date" name="correctionApplicationDate">
                </div>
                <div class="form-col">
                    <label>변경 요청 유형</label>
                    <select name="attendStatus">
                        <option value="ATTEND">출석</option>
                        <option value="LATE">지각</option>
                        <option value="ABSENT">결석</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>첨부파일</label>
                <input type="file" name="upFile">
            </div>

            <div class="form-submit">
                <button class="btn-submit" type="submit">제출</button>
            </div>
        </form>

      </div>

      <!-- 처리 현황 -->
      <div class="card correction-status">
        <h2>처리 현황</h2>

        <table>
          <thead>
            <tr>
              <th>신청일</th>
              <th>정정 사유</th>
              <th>처리일</th>
              <th>승인상태</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="r" items="${result}">
                <tr>
                    <td>${r.correctionApplicationDate}</td>
                    <td>${r.attendUpdateContent}</td>
                    <td>${r.updateDate}</td>
                    <c:choose>
                        <c:when test="${r.status eq '승인'}">
                            <td><span class="status approved">${r.status}</span></td>
                        </c:when>
                        <c:otherwise>
                            <td><span class="status pending">${r.status}</span></td>
                        </c:otherwise>
                    </c:choose>

                </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</body>
</html>
