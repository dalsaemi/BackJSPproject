<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/myrecordpage.css">
    <title>독서 기록 웹사이트</title>
</head>
<body>
    <div class="container"> <!-- 헤더 -->
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

            <div class="main-content">
                <div class="section recent-book">
                    <img name = "book_image" src="#" alt="책 이미지"> <!-- 이미지 받아와서 배치하도록 추후 수정 -->
                    <div class="info">
                        <p>최근 읽은 책</p>
                        <p><strong>책 이름</strong></p>
                        <p>저자</p>
                        <p>출판사</p>
                        <p>출판년도</p>
                        <p>별점</p>
                    </div>
                </div>

                <div class="section goal-section"> <!-- 텍스트 to 컨트롤러로 바꾸기 -->
                    <div class="goal-box">
                        <h3>이번 달 나의 목표</h3>
                        <p>독서 목표: 10권</p>
                        <p>읽은 책: 5권</p>
                        <p>목표 달성까지 5권 남았어요!</p>
                    </div>
                    <div class="goal-box">
                        <h3>기록 목표</h3>
                        <p>이번 달 목표: 3편</p>
                        <p>기록한 서평: 3편</p>
                        <p>축하합니다! 목표를 달성했어요!</p>
                    </div>
                </div>

                <div class="section stats-section">
                    <div class="section-title">독서 통계</div>
                    <div class="chart-placeholder">[그래프 자리]</div>
                </div>
              </div>
        </div>
    </div>
</body>
</html>