# 🚀 프로젝트명 (Project Name)
> 회원 관리와 게시판, 기자재 관리 기능을 갖춘 JSP 기반 웹 애플리케이션

## 📘 개요 (Overview)
본 프로젝트는 Spring과 JSP를 이용한 MVC 패턴 기반 웹 애플리케이션 으로,
회원관리, 게시판 CRUD, 승인 요청 처리 등 다양한 기능으로 구성되었습니다.
Oracle 데이터베이스와 JDBC를 통해 데이터 연동을 수행하며,
Intellij 환경에서 실행 가능합니다.


## 🧱 기술 스택 (Tech Stack)
| 구분 | 사용 기술 |
|------|------------|
| Frontend | HTML, CSS, JavaScript, JSP |
| Backend | Java (Servlet, JDBC)|
| Server| Apache Tomcat |
| Database | Oracle |
| Tools | Intellij, Git, GitHub |

## 🛠️ 설치 및 실행 (Installation & Run)
# 1. 프로젝트 클론
git clone https://github.com/username/project.git

# 2. Intellij에서 Import
- 파일 > 새로 만들기 > 기존 소스에 있는 프로젝트
- 복제한 프로젝트 폴더 선택 후 Import

# 3. 데이터베이스(Oracle) 설정
- Oracle 실행 후 데이터베이스 및 테이블 생성
- src/main/webapp/WEB-INF/classes/sql 폴더 내 SQL 스크립트 실행
- JDBC 연결 정보(application.properties 또는 JDBCTemplate.java) 수정

# 4. Spring boot 설정
- 실행 / 디버그 구성 > 빌드 및 실행 수정

# 5. 웹 애플리케이션 실행
- 브라우저에서 접속
http://localhost:8005/login.co

## 📂 프로젝트 구조 (Directory Structure)
project/
 ├── src/
 │   ├── com/kh/classLink/config/    
 │   ├── com/kh/classLink/controller/     # Servlet 컨트롤러
 │   ├── com/kh/classLink/model/dao/      # 데이터 접근 로직 (DAO)
 │   ├── com/kh/classLink/model/vo/       # VO (Value Object)
 │   ├── com/kh/classLink/service/        # 비즈니스 로직
 │   └── com/kh/classLink/utils/         # 공용 유틸 (JDBCTemplate 등)
 ├── webapp/
 │   ├── WEB-INF/
 │   │   ├── views/                  # JSP 뷰 페이지
 │   │   └── web.xml                 # 배포 서술자
 │   ├── resources/                  # CSS, JS, 이미지
 └── README.md


 project/
 ├── src/
 │   ├── com/kh/classLink/config/    
 │   ├── com/kh/classLink/controller/     # Servlet 컨트롤러
 │   ├── com/kh/classLink/model/dao/      # 데이터 접근 로직 (DAO)
 │   ├── com/kh/classLink/model/vo/       # VO (Value Object)
 │   ├── com/kh/classLink/service/        # 비즈니스 로직
 │   └── com/kh/classLink/utils/         # 공용 유틸 (JDBCTemplate 등)
 ├── webapp/
 │   ├── WEB-INF/
 │   │   ├── views/                  # JSP 뷰 페이지
 │   │   └── web.xml                 # 배포 서술자
 │   ├── resources/                  # CSS, JS, 이미지
 │   └── index.jsp                   # 메인 페이지
 └── README.md

## 🌟 주요 기능 (Key Features)
✅ 회원가입 / 로그인 / 로그아웃 기능
✅ 게시글 등록, 조회, 수정, 삭제 (CRUD)
✅ Oracle DB 연동을 통한 데이터 관리
✅ MVC 패턴 기반 구조로 모듈화된 개발
✅ JSP include를 통한 공통 레이아웃 구성

## 📸 화면 미리보기 (Preview)

| 기능 | 미리보기 |
|------|-----------|
| 로그인 화면 | ![Login Page](./assets/login.gif) |
| 회원가입 화면 | ![Register Page](./assets/register.png) |
| 게시판 목록 | ![Board List](./assets/board-list.jpg) |
| 게시글 작성 | ![Post Write](./assets/post-write.gif) |


## 💡 학습 포인트 (Learning Points)

- JSP & Spring 기반 MVC 구조 설계 방법 학습
- JDBC를 통한 데이터베이스 연결 및 SQL 처리 로직 구현
- Tomcat 서버를 활용한 배포 및 실행 환경 이해
- JSP 내 JSTL / EL 사용으로 동적 페이지 구현


## 팀원 소개(협업시 추가)

| 이름 | 포지션 | Contact |
| 전수환 | 조장 | --- |
| 김정훈 | DB관리자 | --- |
| 임성훈 | 이슈관리자 | --- |
| 박혜정 | 일정관리자 | --- |
| 전원희 | 형상관리자 | --- |

