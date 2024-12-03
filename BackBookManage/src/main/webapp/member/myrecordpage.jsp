<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("/myrecordpage.do");
	dispatcher.include(request, response);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/member/myrecordpage_styles.css">
    <title>독서 기록 웹사이트</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                        <p>읽은 책: <%= request.getAttribute("booksRead") %>권</p>
                        <p>목표 달성까지 <%= request.getAttribute("booksRemaining") %>권 남았어요!</p>
                    </div>
                    <div class="goal-box">
                        <h3>목표 달성치</h3>
                        <!-- 아래에 그래프를 넣겠습니다! -->
                        <canvas id="goalChart" width="100" height="100"></canvas>
                    </div>
                </div>
                
                <!-- 서버 데이터를 JavaScript로 전달 -->
             <script>
                 const booksRead = <%= request.getAttribute("booksRead") %>;
                 const booksRemaining = <%= request.getAttribute("booksRemaining") %>;
                 
                 // 자꾸 null값 들어가서 확인용
                 console.log("읽은 책 수:", booksRead);
                 console.log("남은 책 수:", booksRemaining);
             </script>
         
             <!-- JavaScript 파일 로드 -->
             <script src="<%= request.getContextPath() %>/js/recordpageChart.js"></script>

                <div class="section stats-section">
                    <div class="section-title">독서 통계</div>
                    <div class="chart-placeholder">[그래프 자리]</div>
                </div>
              </div>
        </div>
    </div>
</body>
</html>