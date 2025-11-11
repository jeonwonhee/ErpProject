<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KH EduERP | 회원가입</title>

        <link rel="stylesheet" href="/styles/default.css">
        <link rel="stylesheet" href="/styles/style.css">
        <link rel="stylesheet" href="/styles/auth.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <style>

            .lecture-name {
                display: none;
            }
        </style>
    </head>
    <body class="register">
        <div class="card">
            <h1>회원가입 페이지</h1>
            <p class="desc">해당하는 회원가입 유형을 선택하세요</p>
            <form action="${pageContext.request.contextPath}/insertMember.co" method="post">
                <div class="user-type">
                    <label>
                        <input type="radio" name="role" value="TEACHER" onchange='fc_changeRole()'>
                        <div class="card">
                            <div class="emoji">👨‍🏫</div>
                            <div class="role-name">강사</div>
                        </div>
                    </label>
                    <label>
                        <input type="radio" name="role" value="ADMIN" onchange='fc_changeRole()'>
                        <div class="card">
                            <div class="emoji">🛠</div>
                            <div class="role-name">관리자</div>
                        </div>
                    </label>
                </div>

                <div class="form-card">
                    <div class="form-group  lecture-name">
                        <label for="name">담당 수업명</label>
                        <input id="name" type="text" maxlength="100" name="lectureName" placeholder="수업명을 입력하세요">
                    </div>

                    <div class="form-group">
                        <label for="name">이름</label>
                        <input id="name" type="text" maxlength="30" name="memberName" placeholder="이름을 입력하세요">
                    </div>


                <div class="form-group">
                    <label for="memberId">아이디</label>
                    <div class="input-with-btn">
                        <input id="memberId" name ="memberId" maxlength="20" type="text" placeholder="아이디 입력 (6~20자)">
                        <span class="check-icon success">✅</span>
                        <span class="check-icon fail">❌</span>
                        <button class="btn-submit" type="button" onclick="idDupiCheck()">중복확인</button>
                    </div>

                    <div class="form-group">
                        <label for="userPwd">비밀번호</label>
                        <input id="userPwd" type="password" maxlength="20" name="memberPassword" placeholder="문자, 특수문자, 숫자 포함 8~20자">
                        <div id="pwdChkDiv"></div>
                    </div>

                    <div class="form-group">
                        <label for="pwdChk">비밀번호 확인</label>
                        <input id="pwdChk" type="password" maxlength="20" placeholder="비밀번호 재입력" onblur="passwordChk();">
                    </div>

                    <div class="form-group">
                        <label for="phone">전화번호</label>
                        <input id="phone" type="tel" name="phone" maxlength="11" placeholder="휴대폰 번호 입력 ('-'제외 11자리)">
                    </div>

                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input id="email" type="email" name="email" maxlength="20" placeholder="이메일 입력">
                    </div>

                    <div class="form-group">
                        <label>생년월일</label>
                        <div class="birth-selects" name="birthDate">
                            <select><option>년도</option></select>
                            <select><option>월</option></select>
                            <select><option>일</option></select>
                        </div>
                    </div>
                </div>

            <button disabled class="btn-submit erroll-submit">회원가입</button>
        </div>

        <script>

            function fc_changeRole() {
                let roleRadio = document.querySelectorAll('.user-type input');
                console.log(roleRadio);
                let lectureName = document.querySelector('.lecture-name');
                for (let i=0; i< roleRadio.length; i++) {
                    console.log(roleRadio[i]);

                    if (roleRadio[i].checked) {
                        if (roleRadio[i].defaultValue === 'TEACHER') {
                            lectureName.style.display = 'block';
                        } else {
                            lectureName.style.display = 'none';
                        }
                    }
                }
            }

            function passwordChk() {
                let userPwd = document.getElementById("userPwd");
                let pwdChk = document.getElementById("pwdChk");

                console.log("userPwd",userPwd)
                console.log("pwdChk",pwdChk)

                if (userPwd.value == pwdChk.value) {
                    pwdChkDiv.textContent = '비밀번호가 일치 합니다.'
                    pwdChkDiv.style.color='green';
                } else {
                    pwdChkDiv.textContent = '비밀번호가 일치 하지 않습니다.'
                    pwdChkDiv.style.color='red';
                }
            }

            function idDupiCheck() {
                const idInput = document.getElementById("memberId");

                $.ajax({
                    url : "idDuplicateCheck.co",
                    type : "get",
                    data : {
                        memberId : idInput.value
                    },
                    success: function(result){
                        console.log("TEST",result);
                        if(result === "NNNNN") { //존재한다면
                            alert("이미 존재하는 ID입니다.");
                            idInput.focus();
                        } else { //존재하지 않는다면
                            if(confirm("사용가능한 아이디입니다. 사용하시겠습니까?")){
                                idInput.setAttribute("readonly", true);

                                const submitBtn = document.querySelector(".erroll-submit");
                                submitBtn.removeAttribute("disabled");
                            } else{
                                idInput.focus();
                            }
                        }
                    },
                    error: function(err){
                        console.log("아이디 체크 요청 실패 : ", err);
                    }
                })
            }

        </script>
    </body>

</html>