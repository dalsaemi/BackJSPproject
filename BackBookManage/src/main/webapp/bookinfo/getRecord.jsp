<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/getRecord.css">
    <title>내 기록 모아보기</title>
    <style>
        
    </style>
</head>
<body>
    <div class="container">
        <!-- 헤더 -->
        <header>
            <div class="logo">
                <img src="#" alt="로고">
                <span>웹사이트이름</span>
            </div>
            <nav>
                <a href="#">서비스소개</a>
                <a href="#">공지사항</a>
                <a href="#">도서관찾기</a>
                <a href="#">고객센터</a>
            </nav>
        </header>

        <div class="content-wrapper">
            <div class="sidebar">
                <ul>
                    <li><a href="#">나의 독서 기록</a></li>
                    <li><a href="#">자주 가는 도서관</a></li>
                    <li><a href="#">작성 글 모아보기</a></li>
                    <li><a href="#">즐겨찾기 목록</a></li>
                    <li><a href="#">회원정보 및 계정 관리</a></li>
                </ul>
            </div>
            <div class="myrecord">
                <h1>내 기록 모아보기</h1> <!-- 인터페이스 보여주기 위해 임시 코드, 이후 try-catch 및 for문 응용 -->
                <div class="post-list">
                    <!-- 글 1 -->
                    <div class="post-item">
                        <img src="#" alt="글 1 이미지">
                        <h3>책 제목 or ID</h3>
                        <p>기록 제목</p>
                        <div class="date">날짜</div>
                    </div>
                    <!-- 글 2 -->
                    <div class="post-item">
                        <img src="#" alt="글 2 이미지">
                        <h3>차라수트라는...</h3>
                        <p>Text</p>
                        <div class="date">2024-09-09</div>
                    </div>
                    <!-- 글 3 -->
                    <div class="post-item">
                        <img src="#" alt="글 3 이미지">
                        <h3>이것이 자바다</h3>
                        <p>Text2</p>
                        <div class="date">2024-09-08</div>
                    </div>
                    <!-- 글 4 -->
                    <div class="post-item">
                        <img src="#" alt="글 4 이미지">
                        <h3>모두의 데이터...</h3>
                        <p>Text3</p>
                        <div class="date">2024-09-07</div>
                    </div>
                    <!-- 글 5 -->
                    <div class="post-item">
                        <img src="#" alt="글 5 이미지">
                        <h3>운전면허...</h3>
                        <p>이걸왜</p>
                        <div class="date">2024-08-09</div>
                    </div>
                    <!-- 글 6 -->
                    <div class="post-item">
                        <img src="#" alt="글 6 이미지">
                        <h3>자바스크립트 입문</h3>
                        <p>Text4</p>
                        <div class="date">2024-07-10</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
