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
                <label for="id">아이디</label>
                <div class="input-with-btn">
                    <input id="id" name="memberId" type="text" placeholder="아이디 입력 (6~20자)"
                           minlength="6" maxlength="20" required autocomplete="username" />
                    <span class="check-icon success" style="display:none;">✅</span>
                    <span class="check-icon fail" style="display:none;">❌</span>
                    <button type="button" class="btn-submit" id="btnCheckId">중복확인</button>
                </div>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input id="pw" name="memberPassword" type="password"
                       placeholder="문자, 특수문자, 숫자 포함 8~20자"
                       minlength="8" maxlength="20" required autocomplete="new-password"
                       pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[^\w\s]).{8,20}$" />
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group">
                <label for="pw2">비밀번호 확인</label>
                <input id="pw2" name="memberPwdConfirm" type="password" required autocomplete="new-password" />
            </div>

            <!-- 전화번호 -->
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input id="phone" name="phone" type="tel"
                       placeholder="휴대폰 번호 입력 ('-' 제외 11자리)"
                       pattern="^01[016789][0-9]{7,8}$" autocomplete="tel" />
            </div>

            <!-- 이메일 -->
            <div class="form-group">
                <label for="email">이메일</label>
                <input id="email" name="email" type="email" placeholder="이메일 입력" autocomplete="email" />
            </div>

            <!-- 생년월일(년/월/일 선택) -->
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

        <input type="hidden" name="role" value="STUDENT" />
        <button id="btnSubmit" class="btn-submit" type="submit" disabled>회원가입</button>
    </form>
</div>

<script>

    // ===== 아이디 중복확인 + 제출 제어 =====
    (function setupDuplicateCheck() {
        const idInput = document.getElementById('id');
        const btnCheck = document.getElementById('btnCheckId');
        const submitBtn = document.getElementById('btnSubmit');
        const okIcon = document.querySelector('.check-icon.success');
        const noIcon = document.querySelector('.check-icon.fail');

        let idLocked = false;

        idInput.addEventListener('input', () => {
            idLocked = false;
            submitBtn.disabled = true;
            okIcon.style.display = 'none';
            noIcon.style.display = 'none';
            idInput.removeAttribute('readonly');
        });

        btnCheck.addEventListener('click', () => {
            const val = idInput.value.trim();
            if (val.length < 6 || val.length > 20) {
                alert('아이디는 6~20자로 입력하세요.');
                idInput.focus();
                return;
            }

            fetch('${pageContext.request.contextPath}/idDuplicateCheck.co?checkId=' + encodeURIComponent(val))
                .then(res => res.text())
                .then(code => {
                    if (code === 'NNNNN') {        // 이미 존재
                        okIcon.style.display = 'none';
                        noIcon.style.display = 'inline';
                        alert('이미 존재하는 ID입니다.');
                        submitBtn.disabled = true;
                        idLocked = false;
                    } else {                       // 사용 가능
                        if (confirm('사용 가능한 ID입니다. 이 아이디로 확정할까요?')) {
                            idInput.setAttribute('readonly', 'readonly');
                            okIcon.style.display = 'inline';
                            noIcon.style.display = 'none';
                            idLocked = true;
                            submitBtn.disabled = false;
                        }
                    }
                })
                .catch(err => {
                    console.error('아이디 중복확인 오류:', err);
                    alert('중복확인 중 오류가 발생했습니다.');
                });
        });

        document.getElementById('registerForm').addEventListener('submit', (e) => {
            const pw = document.getElementById('pw').value;
            const pw2 = document.getElementById('pw2').value;
            if (!idLocked) {
                e.preventDefault();
                alert('아이디 중복확인을 완료해 주세요.');
                return;
            }
            if (pw !== pw2) {
                e.preventDefault();
                alert('비밀번호가 일치하지 않습니다.');
            }
            // birthDate hidden 값이 비어있으면 막기
            if (!document.getElementById('birthDate').value) {
                e.preventDefault();
                alert('생년월일을 선택해 주세요.');
            }
        });
    })();
</script>
</body>
</html>
