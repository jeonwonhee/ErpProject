package com.kh.classLink.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
public class LoginCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String uri = request.getRequestURI();

        // ✅ 로그인 관련 페이지, 정적 리소스는 검사 제외
        if (uri.contains("/login.co") ||
                uri.contains("/logout.co") ||
                uri.contains("/insertMember.co") ||
                uri.contains("/stRegister.co") ||
                uri.contains("/findPassword.co") ||
                uri.contains("/changePassword.co") ||
                uri.contains("/error") ||
                uri.contains("/css/") ||
                uri.contains("/js/") ||
                uri.contains("/styles/") ||
                uri.contains("/images/")) {
            log.info("✅ 로그인 체크 제외 경로: {}", uri);
            return true;
        }

        // ✅ 세션 확인
        if (session == null || session.getAttribute("loginMember") == null) {
            log.warn("⚠️ 미인증 사용자 요청: {}", uri);
            response.sendRedirect(request.getContextPath() + "/login.co");
            return false;
        }

        log.info("🔐 인증된 사용자 요청 - URL: {}", uri);
        return true;
    }
}
