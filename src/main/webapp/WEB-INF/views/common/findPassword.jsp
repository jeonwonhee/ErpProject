<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 비밀번호 찾기</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\auth.css">
    </head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script type="text/javascript"
            src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js">
    </script>

    <body class="find-pw">
        <div class="pw-wrapper">
            <h1 class="title">비밀번호 찾기</h1>

            <div class="card">

                <label class="field-label">아이디</label>
                <div class="input-group">
                    <input type="text" name="memberId" class="input-box member-id" placeholder="아이디를 입력하세요">
                </div>

                <label class="field-label">이메일</label>
                <div class="input-password-change">
                    <input type="email" name="email" class="input-password-email" placeholder="이메일을 입력하세요">
                    <button class="btn-email" onclick="emailOrder()">인증번호 요청</button>
                </div>

            </div>

            <button class="pw-submit">다음</button>
        </div>

    <script>
        (function(){
            emailjs.init({
                publicKey: "_v4MZnquWup_n2DAS",
            });
        })();



        function emailOrder() {
            let memberIdDiv = document.querySelector(".member-id");
            let memberEmailDiv = document.querySelector(".input-password-email");
            let memberId = memberIdDiv.value;
            let memberEmail = memberEmailDiv.value;

            $.ajax({
                url : "orderPasswordFind.co",
                type : "post",
                data : {
                    memberId : memberId,
                    email : memberEmail
                },
                success: function(data){
                    console.log(data);
                    if (data.result === 1) {
                        sendEmail(data,memberId,memberEmail);

                        memberIdDiv.innerHTML = "";
                        memberEmailDiv.innerHTML = "";
                    } else {
                        console.log("비밀번호 찾기 호출 에러.");
                    }
                },
                error: function(err){
                    console.log("아이디 체크 요청 실패 : ", err);
                }
            })


        }



        function sendEmail(data,memberId,memberEmail) {

            const passwordChangeLink = 'http://localhost:8005/findPassword.co?token='+data.token;


            var data = {
                service_id: 'service_q1z97ep',
                template_id: 'template_own72rx',
                user_id: '_v4MZnquWup_n2DAS',
                template_params: {
                    memberId : memberId,
                    email : memberEmail,
                    passwordChangeLink : passwordChangeLink
                }
            };

            $.ajax('https://api.emailjs.com/api/v1.0/email/send', {
                type: 'POST',
                data: JSON.stringify(data),
                contentType: 'application/json',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Content-Transfer-Encoding': 'base64'
                }
            }).done(function() {
                alert('Your mail is sent!');
            }).fail(function(error) {
                alert('Oops... ' + JSON.stringify(error));
            });

        }
    </script>
    </body>
</html>
