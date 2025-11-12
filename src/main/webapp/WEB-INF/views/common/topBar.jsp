<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 5:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>topBar</title>
</head>
<body>
<header class="topbar">
    <div class="path">강사 › 공지사항 <b>강사 페이지</b></div>
    <div class="user-info"><a class="alarm-btn" onclick="alarmPage();">알림(<span> </span>)</a><a onclick="location.href='${pageContext.request.contextPath}/stMyPage.co'">김강사(강사)</a></div>
</header>
<aside class="alarm-page" style="display: none" id="alarmPage">
    <div>
        <div class="logo"><span>알림창</span></div>
        <%--알람 발생에 따라 반복 필요 ajax처리?--%>
        <div class="alarm-area">
            <div class="alarm-list">
                <div class="alarm-row">

                </div>
            </div>
        </div>

    </div>

</aside>
<script>
    function alarmPage() {
        let alarmPage = document.querySelector(".alarm-page");

        console.log("TEST!!");
        console.log(alarmPage.style.display);
        if(alarmPage.style.display === 'none') {
            alarmPage.style.display = 'block';

            //ajax호출 -- 알림 리스트 가져오기 div 꾸미기 필요
            $.ajax({
                url : "selectNotiToMember.nt",
                type : "get",
                success: function(data){
                    console.log(data);
                    if (data.result === "1") {
                        alramReload(data);
                    } else {
                        console.log("알림 호출 에러.");
                    }
                },
                error: function(err){
                    console.log("아이디 체크 요청 실패 : ", err);
                }
            })

        } else {
            alarmPage.style.display = 'none';
        }
    }

    function alramReload(data) {
        let alarmArea = document.querySelector(".alarm-area");
        let notiList = JSON.parse(data.notiList);
            alarmArea.innerHTML ="";
            console.log(notiList);
            console.log(notiList.length);
        for (let i=0; i<notiList.length; i++) {
            alarmArea.innerHTML += '<div class="alarm-list">'+
                                        '<div class="alarm-row">'+notiList[i].notificationTitle+'</div>'+
                                    '</div>';

            //알람 내역도 출력시키고

            //읽음 버튼 추가해서 읽음 처리 및 해당 알림창에서 삭제(상태값 변경후 리로드)


        }
    }
</script>
</body>
</html>
