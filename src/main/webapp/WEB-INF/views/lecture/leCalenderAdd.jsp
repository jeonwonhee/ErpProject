<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 일정관리</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/lecture.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </head>

    <body>
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <header class="topbar">
                <div class="path">강사 › 일정관리 <b>강사 페이지</b></div>
                <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
            </header>

            <section class="content">
                <form action="/insertLectureDate.bo" method="post">

                    <!-- 일정 추가 -->
                    <div class="schedule-add">
                        <h3>일정 추가</h3>
                        <!-- 반 선택 -->
                        <div class="form-row">
                            <div class="form-group">
                                <label>반 선택</label>
                                <select name="classLectureNo" class="form-select">
                                    <c:forEach var="c" items="${classList}">
                                        <option value="${c.classLectureNo}"
                                            ${c.classLectureNo == selectedClassLectureNo ? "selected" : ""}>
                                            ${c.className}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label>제목</label>
                                <input type="text" name="title" class="form-input" placeholder="제목을 입력하세요">
                            </div>
                            <div class="form-group">
                                <label>일정유형</label>
                                <select name="dateType" class="form-select">
                                    <option value="" disabled selected hidden>수업일정 / 휴강 중 선택</option>
                                    <option value="CLASS">수업</option>
                                    <option value="OFF">휴강</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>희망 날짜 시작일</label>
                                <input type="date" name="startDate" class="form-input">
                            </div>
                            <div class="form-group">
                                <label>희망 날짜 종료일</label>
                                <input type="date" name="endDate" class="form-input">
                            </div>
                        </div>

                        <div class="form-group">
                            <label>상세 내용</label>
                            <textarea class="form-textarea" name="content" placeholder="내용을 입력하세요"></textarea>
                        </div>
                        <br><br>
                        <button type="submit" class="btn-submit">추가</button>
                    </div>
                </form>
            </section>
        </main>
        <script>
            $(window).load(function() {
              console.log("페이지 전체 로드 후 실행");
            });

        </script>
    </body>
</html>
