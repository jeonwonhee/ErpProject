<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 공지사항 작성</title>

  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/lecture.css">
    <style>
        .classNoList {
            display: none;
            flex-direction: column;  /* 세로 배치 */
            align-items: flex-start; /* label은 왼쪽 정렬 */
            gap: 8px; /* label과 체크박스 그룹 사이 여백 */
            width: 100%;
        }

        .classNoList > label {
            font-weight: bold;
            margin-left: 5px;
        }

        .checkbox-group {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            width: 100%;
        }

        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .subject-select select {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
            background: #fff;
            width: 100%;
        }
    </style>
</head>

<body class="lecture lecture-notice-write">

  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <!-- 메인 -->
  <main class="main">
  <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content notice-write">
      <div class="card">
        <h2>공지사항 작성</h2>

        <form class="notice-form" enctype="multipart/form-data">
          <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" placeholder="제목을 입력하세요">
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
            <div class="classNoList">
                <label for="classNoList">반 명</label>
                <div class="checkbox-group">
                    <input type="checkbox" name="classNoList" value="1"> a반
                    <input type="checkbox" name="classNoList" value="2"> b반
                    <input type="checkbox" name="classNoList" value="3"> c반
                    <input type="checkbox" sname="classNoList" value="4"> d반
                </div>
            </div>
            <br>
          <div class="form-group file-group">
            <label for="file">첨부파일</label>
            <div class="file-box">
              <label class="file-label" for="file">파일선택</label>
              <input type="file" id="file">
              <span class="file-name">선택된 파일이 없음</span>
            </div>
          </div>

          <div class="form-group">
            <label for="content">작성 내용</label>
            <textarea id="content" placeholder="내용을 입력하세요"></textarea>
          </div>

          <button type="submit" class="btn-submit">등록하기</button>
        </form>
      </div>
    </section>
  </main>
<script>
    function changeNoticeType() {

        let noticeType = document.getElementById("noticeType");

        let classNoList = document.querySelector(".classNoList");
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
