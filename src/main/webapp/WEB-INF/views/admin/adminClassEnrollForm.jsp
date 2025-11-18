<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 반 등록</title>
    <link rel="stylesheet" href="/styles/default.css">
    <link rel="stylesheet" href="/styles/style.css">
    <link rel="stylesheet" href="/styles/admin.css">
</head>

<body class="admin admin-class-enroll">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <c:set var="pageName" value="반 등록" scope="request"></c:set>
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content attendance-correction">
        <!-- 정정신청 폼 -->
        <form action="${pageContext.request.contextPath}/insertClass.cl" method="get">
            <div class="card correction-form">
                <h2>반 등록</h2>

                <div class="form-group">
                    <label>반 이름</label>
                    <input type="text" name="className"/>
                </div>

                <div class="form-row">
                    <div class="form-col">
                        <label>시작 날짜</label>
                        <input type="date" name="startDate" class="start-date-input" onchange="dateSet()"/>
                    </div>
                    <div class="form-col">
                        <label>종료 날짜</label>
                        <input type="date" name="endDate" class="end-date-input" onchange="dateSet()"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>배정 수업</label>
                    <select onchange="selectLecture()">

                    </select>
                </div>
            </div>
            <!-- 배정 수업 -->
            <h2 class="section-title">배정 수업</h2>
            <div class="card">
                <table>
                    <thead>
                    <tr>
                        <th>선택</th>
                        <th>수업 명</th>
                        <th>담당 강사명</th>
                        <th>수업 시작일</th>
                        <th>수업 종료일</th>
                        <th>수업 설명</th>
                    </tr>
                    </thead>
                    <tbody class="lecture-tbody">

                    </tbody>
                </table>

                <div class="lecture-btn">
                    <button type="button" onclick="location.href='${pageContext.request.contextPath}/adminClassManage.co'">목록</button>
                    <div class="form-submit">
                        <button class="btn-delete" type="button" onclick="deleteLecture()">제거</button>
                        <button class="btn-submit" type="submit">등록</button>
                    </div>
                </div>

            </div>
        </form>

    </section>
</main>

<script>
    const selectLectureBox = document.querySelector(".form-group select");
    const lectureList = ${lectureList};
    const startDate = document.querySelector(".start-date-input");
    const endDate = document.querySelector(".end-date-input");

    function init() {
        selectBoxSet();
        dataDefaultSet();
    }

    function dataDefaultSet() {
        const toDay = new Date();

        const year = toDay.getFullYear();
        const month = ('0' + (toDay.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 1을 더합니다.
        const day = ('0' + toDay.getDate()).slice(-2);



        startDate.value = year+"-"+month+"-"+day;
        endDate.value = year+"-"+month+"-"+day;
    }

    function deleteLecture() {
        let lectureTd = document.querySelectorAll(".lecture-tbody tr");

        lectureTd.forEach(function(data, index) {
            const checkBox = data.querySelector('.check-box input[type="checkbox"]');

            if (checkBox.checked) {
                data.remove();
            }
        })


    }

    function selectBoxSet() {


        selectLectureBox.innerHTML = "";
        selectLectureBox.innerHTML +="<option></option>"
        lectureList.forEach(function(data,index) {
            console.log(data);
            let option = '<option value="'+data.lectureNo+'">'+data.lectureName+'</option>'


            selectLectureBox.innerHTML += option;

        })
    }

    function selectLecture() {


        let lectureTable = document.querySelector(".lecture-tbody");

        let selectedLectureVal = "";
        for (let i=0; i<selectLectureBox.options.length; i++) {
            if(selectLectureBox.options[i].selected) {
                selectedLectureVal = selectLectureBox.options[i].value;

            }
        }


        let tdList = document.querySelectorAll(".lecture-no input");

        lectureList.forEach(function (data,index) {

            for (let i=0; i<tdList.length; i++) {
                let tdVal = tdList[i].value;
                if (tdVal == data.lectureNo) {
                    return;
                }

            }
            if (selectedLectureVal == data.lectureNo) {
                const tr = document.createElement("tr");
                tr.innerHTML = '<tr>'
                                    +'<td class="check-box"><input type="checkbox" name="noCheck"/></td>'
                                    +'<td class="lecture-no"><input type="text" name="lectureNoList" value="'+data.lectureNo+'"/></td>'
                                    +'<td>'+data.lectureName+'</td>'
                                    +'<td>'+data.memberName+'</td>'
                                    +'<td class="start-date"></td>'
                                    +'<td class="end-date"></td>'
                                    +'<td><input type="text" name="classDesc"></input></td>'
                                +'</tr>';

                lectureTable.appendChild(tr);

            }

        })

        dateSet();

    }

    function dateSet() {
        let startTdList = document.querySelectorAll(".start-date");
        let endTdList = document.querySelectorAll(".end-date");


        for (let startTd of startTdList) {
            startTd.innerHTML = "";
            startTd.innerHTML += startDate.value;
        }

        for (let endTd of endTdList) {
            endTd.innerHTML = "";
            endTd.innerHTML += endDate.value;
        }


    }


    document.addEventListener('DOMContentLoaded' , init);
</script>
</body>
</html>
