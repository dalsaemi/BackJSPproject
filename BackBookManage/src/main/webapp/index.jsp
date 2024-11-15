<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 웹사이트</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/index_styles.css">
</head>
<body>
<main>
        <!--header-->
        <header class="header">
            <div class="header-inner">
                <div class="logo">웹사이트이름</div>
                <div class="search-bar">
                    <input type="text" placeholder="도서 검색">
                    <button>🔍</button>
                </div>
                <!--menu-->
                <nav class="nav-links">
                    <a href="#">서비스소개</a>
                    <a href="#">공지사항</a>
                    <a href="#">도서관찾기</a>
                    <a href="#">고객센터</a>
                </nav>
            </div>
        </header>
        
        <!--banner-->
        <div class="banner"></div>

        <!--main-content-->
        <div class="main-content">
            <!--login-->
            <div class="login">
                <h2>로그인</h2>
                <form>
                    <input type="text" placeholder="사용자 아이디">
                    <input type="password" placeholder="비밀번호">
                    <button id="signin" type="submit">로그인</button>
                    <div id="idpass">
                        <label id="remember"><input type="checkbox">아이디 저장</label>
                        <a href="#" id="forget">아이디/비밀번호 찾기</a>
                    </div>
                </form>
                <button class="signup">회원가입</button>
            </div>
            <!--book-section-->
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
        </div>
        <!--info-section-->
        <div class="info-section">
            <!--announcements-->
            <section class="announcements-faq">
                <button>공지사항</button>
                <button>자주 묻는 질문</button>
                <ul>
                    <li>공지사항 1 <span>2024-09-10</span></li>
                    <li>공지사항 2 <span>2024-09-15</span></li>
                    <li>공지사항 3 <span>2024-09-16</span></li>
                    <li>공지사항 4 <span>2024-09-17</span></li>
                    <li>공지사항 5 <span>2024-09-18</span></li>
                    <li>공지사항 6 <span>2024-09-19</span></li>
                </ul>
            </section>
            <!--faq-->
            <!-- <section class="faq">
                <h3>자주 묻는 질문</h3>
                <ul>
                    <li>Q. 도서관 등록은 어떻게 하나요?</li>
                    <li>Q. 프론트엔트와 백엔드, 당신의 선택은?</li>
                    <li>Q. 기록 수정은 어떻게 하나요?</li>
                </ul>
            </section> -->
            <!--customer-support-->
        
            <div id="etc">
                <section class="customer-support">
                    <h3>고객센터</h3>
                    <p>문의사항이 있으신가요?</p>
                </section>
                <!--library-registration-->
                <section class="library-registration">
                    <h3>도서관 등록</h3>
                    <p>자주 방문하는 도서관을 등록하세요!</p>
                </section>
            </div>
        </div> 
    </main>
    <!-- 메인 콘텐츠 끝 -->

    <!-- 푸터 시작 -->
    <footer>
        <div id="footerdiv">
            <ul>    
                <li>웹사이트이름</li>
                <li>Contact Us</li>
                <li>TEL   010-XXXX-XXXX</li>
                <li>EMAIL   X@XXX.com</li>
                <li>COPYRIGHT (C) 1조 서윤정, 김하늘, 김민지 ALL RIGHTS RESERVED</li>
            </ul>
        </div>
    </footer>
    <!-- 푸터 끝 -->
</body>
</html>