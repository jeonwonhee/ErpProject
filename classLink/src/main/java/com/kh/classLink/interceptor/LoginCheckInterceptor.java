package com.kh.classLink.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

/*
    HandlerInterceptor 인터페이스의 메서드는  :
    1. preHandle() : 컨트롤러 실행전 수행(가장 기본적으로 사용되는 메서드)
    2.postHandle() : 컨트롤러 실행 후 , 뷰가 렌더링 되기 전 실행
    3.afterCompletion() : 뷰 렌더링 후에 실행된다.
 */
@Slf4j
public class LoginCheckInterceptor implements HandlerInterceptor {

    //handler 요청의 목적지인 컨트롤러 정보
    //return type -> boolean : true(계속 진행) / false(처리 중단)
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //로그인 정보 가져오기
        HttpSession session = request.getSession(false);

        
        if (session == null || session.getAttribute("loginMember") == null) {
            log.warn("미인증 사용자 요청 : {}", request.getRequestURI());

            response.sendRedirect(request.getContextPath());

            return false;
        }
        log.info("인증된 사용자 요청 : {}", request.getRequestURI());
        return true;
    }

}
