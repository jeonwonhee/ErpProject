<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 강의만족도</title>
        <link rel="stylesheet" href="/styles/default.css" />
        <link rel="stylesheet" href="/styles/style.css" />
        <link rel="stylesheet" href="/styles/student.css" />

        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    </head>

    <body class="student student-satisfaction">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content satisfaction">
                <div class="card">
                    <h2>만족도 조사<br><small>(${className})</small></h2>

                    <!-- <div class="info">
                        <p>제출 현황: ${submittedCount} / ${totalCount}</p>
                    </div> -->

                    <form action="/stSatisfactionInsert.co" method="post">
                        <div class="form-group">
                            <label>• 강의 내용 만족도</label>
                            <select name="classRating">
                                <option value="5">5 - 매우 만족</option>
                                <option value="4">4 - 만족</option>
                                <option value="3">3 - 보통</option>
                                <option value="2">2 - 불만족</option>
                                <option value="1">1 - 매우 불만족</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>• 강사 만족도</label>
                            <select name="lectureRating">
                                <option value="5">5 - 매우 만족</option>
                                <option value="4">4 - 만족</option>
                                <option value="3">3 - 보통</option>
                                <option value="2">2 - 불만족</option>
                                <option value="1">1 - 매우 불만족</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>• 자유 의견</label>
                            <textarea name="suggestion" placeholder="좋았던 점 / 개선사항을 입력하세요."></textarea>
                        </div>

                        <div class="form-submit">
                            <c:if test="${already}">
                                <div class="alert alert-info" style="margin-bottom:10px;">
                                    이미 만족도 조사를 제출했습니다.
                                </div>
                                <button disabled class="btn-submit disabled">제출 완료됨</button>
                            </c:if>

                            <c:if test="${!already}">
                                <button type="submit" class="btn-submit">제출</button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </body>
</html>
