package com.kh.classLink;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.kh.classLink.model.mapper")
public class ClassLinkApplication {

	public static void main(String[] args) {
		SpringApplication.run(ClassLinkApplication.class, args);
	}

}
