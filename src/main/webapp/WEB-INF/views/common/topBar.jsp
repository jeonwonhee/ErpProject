<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 5:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>topBar</title>
</head>
<body>
<header class="topbar">
    <c:if test="${not empty alertMsg}">
        <script>
            alert("${alertMsg}");
        </script>
        <c:remove var="alertMsg"/>
    </c:if>
    <div class="path">
        <c:set var="roleName"
                value="${loginMember.role eq 'STUDENT'
                ? '학생'
                : (loginMember.role eq 'TEACHER')
                ? '강사'
                : '관리자'}"/>

        ${roleName} › ${pageName} <b>강사 페이지</b></div>
    <div class="user-info"><a class="noti-btn" onclick="notiPage();">알림(<span class="noti-count"> </span>)</a><a onclick="location.href='${pageContext.request.contextPath}/stMyPage.co'">김강사(강사)</a></div>
</header>
<aside class="noti-page" style="display: none" id="notiPage">
    <div>
        <div class="logo"><span>알림창</span></div>
        <%--알람 발생에 따라 반복 필요 ajax처리--%>
        <div class="noti-area">
<%--            <div class="noti-list">
                <div class="noti-row">

                </div>
            </div>--%>
        </div>

    </div>

</aside>
<script>
    function init() {
        notiCount();
    }

    function notiCount() {
        $.ajax({
            url : "selectNotiCount.nt",
            type : "get",
            success: function(data){
                console.log(data);
                notiCountReload(data);

            },
            error: function(err){
                console.log("아이디 체크 요청 실패 : ", err);
            }
        })
    }

    function notiPage() {
        let notiPage = document.querySelector(".noti-page");

        console.log("TEST!!");
        console.log(notiPage.style.display);
        if(notiPage.style.display === 'none') {
            notiPage.style.display = 'block';

            //ajax호출 -- 알림 리스트 가져오기 div 꾸미기 필요
            selectNotiToMember()

        } else {
            notiPage.style.display = 'none';
        }

        notiCount();
    }

    function selectNotiToMember() {
        $.ajax({
            url : "selectNotiToMember.nt",
            type : "get",
            success: function(data){
                console.log(data);
                if (data.result === "1") {
                    notiReload(data);
                } else {
                    console.log("알림 호출 에러.");
                    let notiArea = document.querySelector(".noti-area");
                    notiArea.innerHTML ="";
                }
            },
            error: function(err){
                console.log("아이디 체크 요청 실패 : ", err);
            }
        })
    }

    function notiReload(data) {
        let notiArea = document.querySelector(".noti-area");
        let notiList = JSON.parse(data.notiList);
        notiArea.innerHTML ="";

        for (let i=0; i<notiList.length; i++) {
            notiArea.innerHTML += '<div class="noti-list">'+
                                        '<div class="noti-row">'+
                                            '<div class="noti-title">'+notiList[i].notificationTitle+'</div>'+
                                            '<div class="noti-content">'+notiList[i].notificationContents+'</div>'+
                                            '<button class="noti-read" data-id='+notiList[i].notificationNo+'>읽음</button>'+
                                        '</div>'+
                                    '</div>';

        }

        const readBtnList = document.querySelectorAll('.noti-read');
        readBtnList.forEach(function(readBtn) {
            readBtn.addEventListener('click',function() {
                notiRead(readBtn.dataset.id);
            })

        })
        // readBtn.addEventListener('click',function() {
        //     console.log(readBtn)
        //     //notiRead();
        // })
    }

    function notiCountReload(data) {
        let notiSpan = document.querySelector(".noti-count");

        notiSpan.innerHTML = "";
        notiSpan.innerHTML = data;
    }

    function notiRead(notificationNo) {
        console.log(notificationNo);
        $.ajax({
            url : "notiRead.nt",
            type : "get",
            data : {
                notificationNo : notificationNo
            },
            success: function(data){
                console.log(data);
                notiCountReload(data);
                selectNotiToMember();

            },
            error: function(err){
                console.log("알람 읽음 요청 실패 : ", err);
            }
        })
    }

    document.addEventListener('DOMContentLoaded' , init);
</script>
</body>
</html>
