<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>KH EduERP | 상담관리</title>
  
  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/lecture.css">
</head>
<body class="lecture lecture-consult-correction">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <main class="main">
    <header class="topbar">
      <div class="path">강사 &gt; 반려페이지 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <div class="card">
          <form action="${pageContext.request.contextPath}/lectureConsultUpdate.co" method="post">
              <!-- 어떤 상담인지 구분 -->
              <input type="hidden" name="consultAppNo" value="${consultApplication.consultAppNo}" />

              <div class="form-group">
                  <label>상담 요청일</label>
                  <input type="text" class="form-input"
                         value="<fmt:formatDate value='${consultApplication.consultTime}' pattern='yyyy-MM-dd'/>"
                         readonly>
              </div>

              <div class="form-group">
                  <label>신청 사유</label>
                  <textarea class="form-textarea" readonly>${consultApplication.consultAppContent}</textarea>
              </div>

              <div class="form-group">
                  <label>승인 여부</label>
                  <div class="radio-group">
                      <label>
                          <input type="radio" name="status" value="APPROVED"
                          ${consultApplication.status == 'APPROVED' ? 'checked' : ''}>
                          승인
                      </label>
                      <label>
                          <input type="radio" name="status" value="REJECTED"
                          ${consultApplication.status == 'REJECTED' ? 'checked' : ''}>
                          반려
                      </label>
                  </div>

              </div>

              <div class="form-group">
                  <label>반려 사유</label>
                  <input type="text" class="form-input" name="refusal" value="${consultApplication.refusal}">
              </div>

              <button type="submit" class="btn-submit">등록하기</button>
          </form>

      </div>
    </section>
  </main>
</body>
</html>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const radios = document.querySelectorAll('input[name="status"]');
        const refusalInput = document.querySelector('input[name="refusal"]');

        function toggleRefusalInput() {
            if (document.querySelector('input[name="status"]:checked').value === 'APPROVED') {
                refusalInput.disabled = true; // 승인 선택 시 입력 막기
                refusalInput.value = "";      // 필요하면 기존 값도 지움
            } else {
                refusalInput.disabled = false; // 반려 선택 시 입력 가능
            }
        }

        radios.forEach(radio => {
            radio.addEventListener('change', toggleRefusalInput);
        });

        // 페이지 로드 시 초기 상태 설정
        toggleRefusalInput();
    });
</script>
