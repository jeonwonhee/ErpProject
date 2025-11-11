package com.kh.classLink.config;

import com.kh.classLink.interceptor.LoginCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns("/**")  // 모든 경로에 적용
                .excludePathPatterns(
                        "/login.co",
                        "/logout.co",
                        "/stRegister.co",
                        "/insertMember.co",
                        "/idDupiCheck.co",
                        "/findPassword.co",
                        "/styles/**",
                        "/images/**",
                        "/js/**"
                );  // 로그인 관련 페이지는 제외
    }
}