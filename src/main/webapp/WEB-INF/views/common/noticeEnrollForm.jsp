<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항 작성</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/common.css">
</head>

<body class="common notice-enroll-form ">

  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <c:set var="pageName" value="공지사항" scope="request"></c:set>
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content notice-write">
      <div class="card">
        <h2>공지사항 작성</h2>

        <form class="notice-form" enctype="multipart/form-data" action="${pageContext.request.contextPath}/insertNotice.co" method="post">
          <div class="form-group">
            <label for="noticeTitle">제목</label>
            <input type="text" id="noticeTitle" maxlength="30" required name="noticeTitle" placeholder="제목을 입력하세요">
          </div>
            <div class="subject-select">
                <label for="noticeType">공지 타입</label>
                <select name="noticeType" onchange="changeNoticeType()" id="noticeType">
                    <option value="ALL">전체</option>
                    <option value="SYSTEM">시스템</option>
                    <option value="EVENT">이벤트</option>
                    <option value="CLASS">반 별 공지</option>
                </select>
            </div>
            <br>
            <div class="class-no-list">
                <label for="classNoList">반 명</label>
                <div class="checkbox-group">
                    <c:forEach var="c" items="${classList}">
                        <input type="checkbox" name="classNoList" value="${c.classNo}"> ${c.className}
                    </c:forEach>
                </div>
            </div>
            <br>
          <div class="form-group file-group">
            <label for="file">첨부파일</label>
            <div class="file-box">
             <%-- <label class="file-label" for="file">파일선택</label>--%>
              <input type="file" id="file" name="upFile">
            </div>
          </div>

          <div class="form-group">
            <label for="noticeContents">작성 내용</label>
            <textarea id="noticeContents" maxlength="300" required name="noticeContents" placeholder="내용을 입력하세요"></textarea>
          </div>

          <button type="submit" class="btn-submit">등록하기</button>
        </form>
      </div>
    </section>
  </main>
<script>
    function changeNoticeType() {

        let noticeType = document.getElementById("noticeType");

        let classNoList = document.querySelector(".class-no-list");
        let selectNoticeType = "";
        for (let i=0; i<noticeType.options.length; i++) {
            if(noticeType.options[i].selected) {
                selectNoticeType = noticeType.options[i].value;
            }
        }
        if (selectNoticeType === "CLASS") {

            classNoList.style.display = 'flex';
        } else {
            classNoList.style.display = 'none';
        }
        console.log(selectNoticeType);
    }

</script>
</body>
</html>
