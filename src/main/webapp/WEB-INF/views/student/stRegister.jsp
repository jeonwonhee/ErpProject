<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>KH EduERP | 회원가입</title>

    <link rel="stylesheet" href="/styles/default.css" />
    <link rel="stylesheet" href="/styles/style.css" />
    <link rel="stylesheet" href="/styles/auth.css" />

    <!-- 🔹 jQuery (ajax 쓰니까 추가 필수) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body class="register">
<div class="card">
    <h1>회원가입 페이지</h1>
    <p class="desc">해당하는 회원가입 유형을 선택하세요</p>

    <form id="registerForm" action="${pageContext.request.contextPath}/stRegister.co" method="post" novalidate>

        <!-- 학습자 유형 -->
        <div class="user-type">
            <label>
                <input type="radio" name="userType" value="STUDENT" checked />
                <div class="card">
                    <div class="emoji">👩‍🎓</div>
                    <div class="role-name">학생</div>
                </div>
            </label>
        </div>

        <div class="form-card">

            <!-- 수강반 -->
            <div class="form-group">
                <label for="classNo">수강반</label>
                <select id="classNo" name="classNo" required>
                    <option value="">반 선택</option>

                    <c:forEach var="cls" items="${classList}">
                        <option value="${cls.classNo}">
                                ${cls.className}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- 이름 -->
            <div class="form-group">
                <label for="name">이름</label>
                <input id="name" name="memberName" type="text" placeholder="이름을 입력하세요" required autocomplete="name" />
            </div>

            <!-- 아이디 + 중복확인 -->
            <div class="form-group">
                <label for="memberId">아이디</label>
                <div class="input-with-btn">
                    <input id="memberId" name ="memberId" maxlength="20" type="text" placeholder="아이디 입력 (6~20자)">
                    <span class="check-icon success" style="display:none;">✅</span>
                    <span class="check-icon fail" style="display:none;">❌</span>
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
                    <div class="form-group">
                        <input
                                type="date"
                                id="birthDate"
                                name="birthDate"
                                required
                        />
                    </div>
                </div>
            </div>

            <!-- 🔹 기본은 disabled → 중복확인 통과하면 enable -->
            <button disabled class="btn-submit erroll-submit" type="submit">회원가입</button>
        </div>

    </form>
</div>

<script>
    // ===============================
    // 전역 상태: 아이디 중복확인 완료 여부
    // ===============================
    let isIdChecked = false;

    // ===============================
    // 비밀번호 일치 체크 (onblur에서 호출)
    // ===============================
    function passwordChk() {
        const userPwd = document.getElementById("userPwd");
        const pwdChk = document.getElementById("pwdChk");
        const pwdChkDiv = document.getElementById("pwdChkDiv");

        if (!userPwd.value || !pwdChk.value) {
            pwdChkDiv.textContent = "";
            return;
        }

        if (userPwd.value === pwdChk.value) {
            pwdChkDiv.textContent = "비밀번호가 일치합니다.";
            pwdChkDiv.style.color = "green";
        } else {
            pwdChkDiv.textContent = "비밀번호가 일치하지 않습니다.";
            pwdChkDiv.style.color = "red";
        }
    }

    // ===============================
    // 아이디 중복확인 (버튼 onclick에서 호출)
    // ===============================
    function idDupiCheck() {
        const idInput = document.getElementById("memberId");
        const memberId = idInput.value.trim();

        const okIcon   = document.querySelector(".check-icon.success");
        const failIcon = document.querySelector(".check-icon.fail");
        const submitBtn = document.querySelector(".erroll-submit");

        // 아이디 기본 검증
        if (!memberId) {
            alert("아이디를 입력해주세요.");
            idInput.focus();
            return;
        }
        if (memberId.length < 6 || memberId.length > 20) {
            alert("아이디는 6~20자로 입력해주세요.");
            idInput.focus();
            return;
        }

        // 실제 중복확인 호출
        $.ajax({
            url : "${pageContext.request.contextPath}/idDuplicateCheck.co",
            type : "get",
            data : { memberId : memberId },
            success: function(result){
                const trimmed = String(result).trim();
                console.log("✅ 중복확인 응답:", trimmed);

                if (trimmed === "NNNNN") {
                    // 이미 존재
                    alert("이미 존재하는 ID입니다.");
                    if (okIcon)  okIcon.style.display  = "none";
                    if (failIcon) failIcon.style.display = "inline";
                    isIdChecked = false;
                    if (submitBtn) submitBtn.disabled = true;
                    idInput.readOnly = false;
                } else if (trimmed === "NNNNY") {
                    // 사용 가능
                    if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
                        idInput.readOnly = true;
                        if (okIcon)  okIcon.style.display  = "inline";
                        if (failIcon) failIcon.style.display = "none";
                        isIdChecked = true;
                        if (submitBtn) submitBtn.disabled = false;
                    }
                } else {
                    // 혹시 응답이 이상할 때
                    alert("중복확인 응답이 예상과 다릅니다: " + trimmed);
                    isIdChecked = false;
                    if (submitBtn) submitBtn.disabled = true;
                }
            },
            error: function(err){
                console.error("아이디 체크 요청 실패 : ", err);
                alert("중복확인 중 오류가 발생했습니다.");
                isIdChecked = false;
                if (submitBtn) submitBtn.disabled = true;

            }
        });
    }

    // ===============================
    // 폼 제출 시 최종 검증
    // ===============================
    document.getElementById("registerForm").addEventListener("submit", function(e) {
        const classNo   = document.getElementById("classNo").value.trim();
        const name      = document.getElementById("name").value.trim();
        const memberId  = document.getElementById("memberId").value.trim();
        const userPwd   = document.getElementById("userPwd").value.trim();
        const pwdChk    = document.getElementById("pwdChk").value.trim();
        const phone     = document.getElementById("phone").value.trim();
        const email     = document.getElementById("email").value.trim();
        const birthDate = document.getElementById("birthDate").value.trim();

        // 1) 아이디 중복확인 했는지
        if (!isIdChecked) {
            e.preventDefault();
            alert("아이디 중복확인을 해주세요.");
            return;
        }

        // 2) 필수값 체크
        if (!classNo) {
            e.preventDefault();
            alert("수강반을 선택해 주세요.");
            document.getElementById("classNo").focus();
            return;
        }
        if (!name) {
            e.preventDefault();
            alert("이름을 입력해 주세요.");
            document.getElementById("name").focus();
            return;
        }
        if (!memberId) {
            e.preventDefault();
            alert("아이디를 입력해 주세요.");
            document.getElementById("memberId").focus();
            return;
        }
        if (!userPwd || !pwdChk) {
            e.preventDefault();
            alert("비밀번호를 모두 입력해 주세요.");
            document.getElementById("userPwd").focus();
            return;
        }
        if (userPwd !== pwdChk) {
            e.preventDefault();
            alert("비밀번호가 일치하지 않습니다.");
            document.getElementById("pwdChk").focus();
            return;
        }
        if (!phone) {
            e.preventDefault();
            alert("전화번호를 입력해 주세요.");
            document.getElementById("phone").focus();
            return;
        }
        if (!email) {
            e.preventDefault();
            alert("이메일을 입력해 주세요.");
            document.getElementById("email").focus();
            return;
        }
        if (!birthDate) {
            e.preventDefault();
            alert("생년월일을 선택해 주세요.");
            document.getElementById("birthDate").focus();
            return;
        }

        // 여기까지 통과하면 진짜 submit (서버로 전송)
        // alert("회원가입이 완료되었습니다."); // 이건 서버까지 성공 확인 후 쓰는 게 더 안전
    });
</script>


    </body>
    </html>
