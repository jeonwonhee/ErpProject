<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항 상세보기</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/common.css">
</head>
<body class="common notice-detail">
  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
      <c:set var="pageName" value="공지사항" scope="request"></c:set>
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

      <form action="${pageContext.request.contextPath}/deleteNotice.no?noticeNo=${noticeDetail.noticeNo}" method="get">
          <section class="content">
              <div class="notice-detail-panel">
                  <!-- 제목 영역 -->
                  <div class="notice-header">
                      <h2 class="notice-title">${noticeDetail.noticeTitle}</h2>
                      <input type="hidden" value="${noticeDetail.noticeNo}" name="noticeNo"/>
                      <div class="notice-meta">
                          <span>작성일: <b>${noticeDetail.createDate}</b></span>
                          <span>작성자: <b>${noticeDetail.memberName}</b></span>
                      </div>
                      <div>
                          <c:if test="${not empty fileList}">
                              <h4>첨부파일</h4>
                              <c:forEach var="file" items="${fileList}">
                                  <a download="${file.noticeFileOriName}"
                                     href="${pageContext.request.contextPath}/${file.filePath}${file.noticeFileName}">
                                          ${file.noticeFileOriName}
                                  </a>
                              </c:forEach>
                          </c:if>

                      </div>
                  </div>

                  <!-- 본문 내용 -->
                  <div class="notice-body">
                      <p>
                          ${noticeDetail.noticeContents}
                      </p>
                  </div>

                  <!-- 버튼 영역 -->
                  <div class="notice-detail-footer">
                      <button class="btn-list" type="button" onclick="location.href='${pageContext.request.contextPath}/notice.co'">목록</button>
                      <div class="right-btns">
                          <button class="btn-edit" type="button" onclick="location.href='${pageContext.request.contextPath}/noticeUpdateForm.no?noticeNo=${noticeDetail.noticeNo}'">수정</button>
                          <button class="btn-delete" type="submit">삭제</button>
                      </div>
                  </div>
              </div>
          </section>
      </form>

  </main>
</body>
</html>
