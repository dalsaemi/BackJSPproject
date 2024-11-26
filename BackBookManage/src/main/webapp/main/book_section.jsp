<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="book-section">
        <!--book-container-->
        <div class="book-container">
            <div class="tab-menu">
                <button>신규 도서</button>
                <button>베스트 도서</button>
                <button>베스트 리뷰</button>
                <button>나의 즐겨찾기</button>
            </div>
            <!--book-cards-->
            <div class="book-cards">
                <div class="book-card">
                    <img src="<%=request.getContextPath() %>/image/1.png" alt="리뷰 1 이미지">
                    <ul class="book-info">
                        <li class="bReview-title">소설 ABCD를 읽고...</li>
                        <li class="bReview-booktitle">ABCD, 김OO 지음</li>
                        <li class="bReview-writer">User1님의 리뷰</li>
                    </ul>
                </div>
                <div class="book-card">
                    <img src="<%=request.getContextPath() %>/image/2.png" alt="리뷰 2 이미지">
                    <ul class="book-info">
                        <li class="bReview-title">알을 깨는 새가 되어</li>
                        <li class="bReview-booktitle">데미안, 헤르만 헤세</li>
                        <li class="bReview-writer">토리님의 리뷰</li>
                    </ul>
                </div>
                <div class="book-card">
                    <img src="<%=request.getContextPath() %>/image/3.png" alt="리뷰 3 이미지">
                    <ul class="book-info">
                        <li class="bReview-title">사랑이란 무엇인가</li>
                        <li class="bReview-booktitle">소나기, 황순원 지음</li>
                        <li class="bReview-writer">가나다님의 리뷰</li>
                    </ul>
                </div>
                <div class="book-card">
                    <img src="<%=request.getContextPath() %>/image/4.png" alt="리뷰 4 이미지">
                    <ul class="book-info">
                        <li class="bReview-title">당신의 하트에 니코마코스</li>
                        <li class="bReview-booktitle">니코마코스 윤리학, 아리스토텔레스 지음</li>
                        <li class="bReview-writer">윤리좋아님의 리뷰</li>
                    </ul>
                </div>
            </div>
        </div>
      </section>
</body>
</html>