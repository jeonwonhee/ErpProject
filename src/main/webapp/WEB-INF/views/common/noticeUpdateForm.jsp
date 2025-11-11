<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항 수정</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/common.css">
</head>

<body class="lecture notice-update-form">

  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content notice-write">
      <div class="card">
        <h2>공지사항 수정</h2>

        <form class="notice-form" enctype="multipart/form-data" action="${pageContext.request.contextPath}/updateNotice.no" method="post">
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="noticeTitle" placeholder="제목을 입력하세요" value="${noticeDetail.noticeTitle}">
          </div>
            <input type="hidden" value="${noticeDetail.noticeNo}" name="noticeNo"/>
            <div class="subject-select">
                <label for="noticeType">공지 타입</label>
                <select name="noticeType" onchange="changeNoticeType()" id="noticeType">
                    <option value="ALL" ${noticeDetail.noticeType == 'ALL' ? 'selected' : ''}>전체</option>
                    <option value="SYSTEM" ${noticeDetail.noticeType == 'SYSTEM' ? 'selected' : ''}>시스템</option>
                    <option value="EVENT" ${noticeDetail.noticeType == 'EVENT' ? 'selected' : ''}>이벤트</option>
                    <option value="CLASS" ${noticeDetail.noticeType == 'CLASS' ? 'selected' : ''}>반 별 공지</option>
                </select>
            </div>
            <br>
            <c:choose>
                <c:when test="${noticeDetail.noticeType == 'CLASS'}">
                    <div class="class-no-list class-true">
                        <label for="classNoList">반 명</label>
                        <div class="checkbox-group">
                            <c:forEach var="c" items="${classList}">
                                <input type="checkbox" name="classNoList" value="${c.classNo}" ${noticeDetail.classNo == c.classNo ? 'checked' : ''}> ${c.className}
                            </c:forEach>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="class-no-list class-false">
                        <label for="classNoList">반 명</label>
                        <div class="checkbox-group">
                            <c:forEach var="c" items="${classList}">
                                <input type="checkbox" name="classNoList" value="${c.classNo}" ${noticeDetail.classNo == c.classNo ? 'checked' : ''}> ${c.className}
                            </c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
            <br>
          <div class="form-group file-group">
            <label for="file">첨부파일</label>
            <div class="file-box">
<%--              <label class="file-label" for="file">파일선택</label>--%>
              <input type="file" id="file" name="upFile">
                <c:choose>
                    <c:when test="${empty fileList}">
                        <span class="file-name">선택된 파일이 없음</span>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="file" items="${fileList}">
                            <span class="file-name">${file.noticeFileOriName}</span>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>
          </div>

          <div class="form-group">
            <label for="content">작성 내용</label>
            <textarea id="content" name="noticeContents" placeholder="내용을 입력하세요">${noticeDetail.noticeContents}</textarea>
          </div>

          <button type="submit" class="btn-submit">수정하기</button>
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

            classNoList.style.display = 'block';
        } else {
            classNoList.style.display = 'none';
        }
        console.log(selectNoticeType);
    }

</script>
</body>
</html>
