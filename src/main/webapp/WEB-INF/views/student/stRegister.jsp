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

    <%-- Spring Security 사용 시
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    --%>
</head>
<body class="register">
<div class="card">
    <h1>회원가입 페이지</h1>
    <p class="desc">해당하는 회원가입 유형을 선택하세요</p>

    <form id="registerForm" action="${pageContext.request.contextPath}/stRegister.co" method="post" novalidate>
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
                    <!-- 🔹 id를 JS에서 쓰는 이름과 맞춤 -->
                    <input id="memberId" name="memberId" type="text" placeholder="아이디 입력 (6~20자)"
                           minlength="6" maxlength="20" required autocomplete="username" />
                    <span class="check-icon success" style="display:none;">✅</span>
                    <span class="check-icon fail" style="display:none;">❌</span>
                    <button type="button" class="btn-submit" onclick="idDupiCheck()">중복확인</button>
                </div>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input id="pw" name="memberPassword" type="password"
                       placeholder="문자, 특수문자, 숫자 포함 8~20자"
                       minlength="8" maxlength="20" required autocomplete="new-password"
                       pattern="^(?=.*[A-Za-z])(?=.*\\d)(?=.*[^\\w\\s]).{8,20}$" />
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label for="pw2">비밀번호 확인</label>
                <input id="pw2" name="memberPwdConfirm" type="password"
                       required autocomplete="new-password" onblur="passwordChk();" />
                <!-- 메시지 표시용 -->
                <div id="pwdChkMsg" style="margin-top:4px; font-size:0.9rem;"></div>
            </div>

            <!-- 전화번호 -->
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input id="phone" name="phone" type="tel" maxlength="11"
                       placeholder="휴대폰 번호 입력 ('-' 제외 11자리)"
                       pattern="^01[016789][0-9]{7,8}$" autocomplete="tel" />
            </div>

            <!-- 이메일 -->
            <div class="form-group">
                <label for="email">이메일</label>
                <input id="email" name="email" type="email" placeholder="이메일 입력" autocomplete="email" />
            </div>

            <!-- 생년월일 -->
            <div class="form-group">
                <label for="birthDate">생년월일</label>
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

        <input type="hidden" name="role" value="STUDENT" />

        <!-- 회원가입 버튼 -->
        <button type="button" class="btn-submit" onclick="submitRegisterForm()">
            회원가입
        </button>
    </form>
</div>

<script>
    // 🔹 비밀번호 일치 체크
    function passwordChk() {
        const pw = document.getElementById("pw");
        const pw2 = document.getElementById("pw2");
        const msg = document.getElementById("pwdChkMsg");

        if (!pw.value || !pw2.value) {
            msg.textContent = "";
            return;
        }

        if (pw.value === pw2.value) {
            msg.textContent = "비밀번호가 일치합니다.";
            msg.style.color = "green";
        } else {
            msg.textContent = "비밀번호가 일치하지 않습니다.";
            msg.style.color = "red";
        }
    }

    // 🔹 아이디 중복확인
    function idDupiCheck() {
        const idInput = document.getElementById("memberId");
        const memberId = idInput.value.trim();

        if (!memberId) {
            alert("아이디를 입력해주세요.");
            idInput.focus();
            return;
        }

        // 아이디 길이 기본체크
        if (memberId.length < 6 || memberId.length > 20) {
            alert("아이디는 6~20자 사이로 입력해주세요.");
            idInput.focus();
            return;
        }

        // fetch 사용 (jQuery 안 써도 됨)
        fetch("${pageContext.request.contextPath}/idDuplicateCheck.co?memberId=" + encodeURIComponent(memberId))
            .then(function (res) {
                if (!res.ok) {
                    throw new Error("서버 오류");
                }
                return res.text(); // 컨트롤러에서 String("NNNNN" 등) 반환한다고 가정
            })
            .then(function (result) {
                console.log("ID CHECK RESULT:", result);

                if (result === "NNNNN") { // 이미 존재
                    alert("이미 존재하는 아이디입니다.");
                    idInput.focus();
                } else { // 사용 가능
                    if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
                        idInput.readOnly = true;

                        // 필요하면 '중복확인 완료' 표시
                        const okIcon = document.querySelector(".check-icon.success");
                        const failIcon = document.querySelector(".check-icon.fail");
                        if (okIcon) okIcon.style.display = "inline";
                        if (failIcon) failIcon.style.display = "none";
                    } else {
                        idInput.focus();
                    }
                }
            })
            .catch(function (err) {
                console.error("아이디 체크 요청 실패:", err);
                alert("중복확인 중 오류가 발생했습니다.");
            });
    }

    // 🔹 회원가입 버튼 클릭 시 검증 + 제출
    function submitRegisterForm() {
        const birth = document.getElementById("birthDate").value;
        const pw = document.getElementById("pw").value;
        const pw2 = document.getElementById("pw2").value;

        if (!birth) {
            alert("생년월일을 선택해 주세요.");
            return;
        }

        if (pw !== pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            document.getElementById("pw2").focus();
            return;
        }

        alert("회원가입이 완료되었습니다.");
        document.getElementById("registerForm").submit();
    }
</script>
</body>
</html>
