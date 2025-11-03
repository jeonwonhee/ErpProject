package com.kh.classLink.config;

import com.kh.classLink.interceptor.LoginCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/*
    Spring MVC설정을 위한 Configuration 객체 클래스
    WebMvcConfigurer 인터페이스를 구현하여 Spring mvc의 다양한 설정을 커스터마이징
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    /*
        인터셉터를 등록하는 메서드
        여러개의 인터페이스를 등록할 수 있고 등록 순서대로 실행
        InterceptorRegistry를 통해 인터셉터를 등록
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns( // 특정 경로의 인터셉터를 동작시키겠다.
                        "/**"
                ).excludePathPatterns( //다만 이 경로들은 인터셉터적용에서 제외
                        "/",
                        "/login.me",
                        "/enrollForm.me",
                        "/insert.me",
                        "/idDulpicateCheck.me",
                        "/static/**"
                );
    }
}
