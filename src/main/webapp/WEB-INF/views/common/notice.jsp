<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/common.css">
</head>
<body class="common notice">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <c:set var="pageName" value="공지사항" scope="request"></c:set>
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="card">
        <h3>공지사항</h3>

          <div class="select-notice">
              <form action="${pageContext.request.contextPath}/searchNotice.co" method="get">
                  <label for="selectNoticeType">주제 : </label>
                  <select name="selectNoticeType"  id="selectNoticeType">
                      <option value="ALL" ${selectNoticeType == 'ALL' ? 'selected' : ''}>전체</option>
                      <option value="SYSTEM" ${selectNoticeType == 'SYSTEM' ? 'selected' : ''}>시스템</option>
                      <option value="EVENT" ${selectNoticeType == 'EVENT' ? 'selected' : ''}>이벤트</option>
                      <option value="CLASS" ${selectNoticeType == 'CLASS' ? 'selected' : ''}>반 별 공지</option>
                  </select>

                  <button class="btn-submit">검색</button>
              </form>



          </div>
        <!-- 공지사항 테이블 -->
        <table class="notice-table">
          <thead>
            <tr>
                <th>주제</th>
                <th>제목</th>
                <th>작성일</th>
                <th>작성자</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="notice" items="${noticeList}">
                <tr onclick="location.href='${pageContext.request.contextPath}/noticeDetail.co?noticeNo=${notice.noticeNo}'">
                    <td>${notice.noticeType}</td>
                    <td>${notice.noticeTitle}</td>
                    <td>${notice.createDate}</td>
                    <td>${notice.memberName}</td>
                </tr>
            </c:forEach>
          </tbody>
        </table>

        <!-- 페이지네이션 -->
        <div class="pagination">
        <c:choose>
            <c:when test="${empty selectNoticeType}">
                <c:if test="${pi.currentPage > 1}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/notice.co?currentPage=${pi.currentPage - 1}'">
                        &lt; 이전
                    </button>
                </c:if>
                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${i == pi.currentPage}">
                            <button class="page-btn" disabled>
                                    ${i}
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/notice.co?currentPage=${i}'">
                                    ${i}
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pi.currentPage < pi.maxPage}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/notice.co?currentPage=${pi.currentPage + 1}'">
                        다음 &gt;
                    </button>
                </c:if>
            </c:when>
            <c:otherwise>
                <c:if test="${pi.currentPage > 1}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/searchNotice.co?currentPage=${pi.currentPage - 1}&selectNoticeType=${selectNoticeType}'">
                        &lt; 이전
                    </button>
                </c:if>
                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${i == pi.currentPage}">
                            <button class="page-btn" disabled>
                                    ${i}
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/searchNotice.co?currentPage=${i}&selectNoticeType=${selectNoticeType}'">
                                    ${i}
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pi.currentPage < pi.maxPage}">
                    <button class="btn btn-primary"
                            onclick="location.href='${pageContext.request.contextPath}/searchNotice.co?currentPage=${pi.currentPage + 1}&selectNoticeType=${selectNoticeType}'">
                        다음 &gt;
                    </button>
                </c:if>
            </c:otherwise>
        </c:choose>
        </div>

        <!-- 글쓰기 버튼 -->
          <c:if test="${loginMember.role != 'STUDENT'}">
              <div class="notice-footer">
                  <button class="btn-write" onclick="location.href='${pageContext.request.contextPath}/noticeEnrollForm.co'">글쓰기</button>
              </div>
          </c:if>

      </div>
    </section>
  </main>
<script>
    <%--function searchNotice() {--%>
    <%--    let selectNoticeType = document.getElementById("selectNoticeType");--%>
    <%--    console.log("selectNoticeType",selectNoticeType);--%>
    <%--    let selectNoticeTypeVal = "";--%>
    <%--    for (let i=0; i<selectNoticeType.options.length; i++) {--%>
    <%--        if(selectNoticeType.options[i].selected) {--%>
    <%--            selectNoticeTypeVal = selectNoticeType.options[i].value;--%>
    <%--        }--%>
    <%--    }--%>
    <%--    $.ajax({--%>
    <%--        url: "searchNotice.co",--%>
    <%--        data: {--%>
    <%--            selectNoticeType : selectNoticeTypeVal,--%>
    <%--        },--%>
    <%--        dataType: "json",--%>
    <%--        success: function(data){--%>
    <%--            if(data.noticeList && data.noticeList.length > 0)--%>
    <%--                reloadNotice(data);--%>
    <%--        },--%>
    <%--        error: function(err){--%>
    <%--            console.log("ajax 실패");--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>

        <%--function reloadNotice(data) {--%>
    <%--    let table = document.querySelector(".notice-table tbody");--%>
    <%--    let page = document.querySelector(".pagination");--%>
    <%--    const contextPath = "${pageContext.request.contextPath}";--%>
    <%--    table.innerHTML = "";--%>
    <%--    page.innerHTML = "";--%>
    <%--    data.noticeList.forEach(function(notice, index) {--%>
    <%--        const row = `--%>
    <%--            <tr onclick="location.href='\${contextPath}/noticeDetail.co?noticeNo=\${notice.noticeNo}'">--%>
    <%--              <td>\${notice.noticeType}</td>--%>
    <%--              <td>\${notice.noticeTitle}</td>--%>
    <%--              <td>\${notice.createDate}</td>--%>
    <%--              <td>\${notice.memberName}</td>--%>
    <%--            </tr>--%>
    <%--          `;--%>
    <%--        table.insertAdjacentHTML("beforeend", row);--%>
    <%--    })--%>

    <%--    const pi = data.pi;--%>
    <%--    console.log(pi);--%>
    <%--    for (let i=pi.startPage; i<pi.endPage; i++) {--%>
    <%--        --%>
    <%--    }--%>


    <%--}--%>
</script>
</body>
</html>
