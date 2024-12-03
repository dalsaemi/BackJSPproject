<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("/chart.do");
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
        <%@ include file="/main/header.jsp" %>
        <div class="content-wrapper">
            <%@ include file="/main/sidebar.jsp" %>

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
                        <canvas id="goalChart" width="100px" height="100px"></canvas>
                    </div>
                </div>
                
                <!-- 서버 데이터를 JavaScript로 전달 -->
             	<script>
	                const booksRead = <%= request.getAttribute("booksRead") %>
	                const booksRemaining = <%= request.getAttribute("booksRemaining") %>
	                 
	                 // 자꾸 null값 들어가서 확인용
	                console.log("읽은 책 수:", booksRead);
	                console.log("남은 책 수:", booksRemaining);
            	 </script>
         
	             <!-- JavaScript 파일 로드 -->
	             <script src="<%= request.getContextPath() %>/js/recordpageChart.js"></script>

                 	<div class="section stats-section">
                    <div class="section-title">독서 통계</div>
                    <div class="chart-placeholder">
                    	<canvas id="lineChart" width="800" height="400"></canvas>
                  	</div>
                  	
                  	<script>
	                 // JSP에서 Java 배열을 JavaScript 배열로 변환
	                    const lineChartData = [
	                        <% 
	                            int[] data = (int[]) request.getAttribute("lineChartData");
	                            for (int i = 0; i < data.length; i++) {
	                                out.print(data[i]);
	                                if (i < data.length - 1) out.print(", ");
	                            }
	                        %>
	                    ];
	
	                    console.log("라인 차트 데이터:", lineChartData);
					</script>

                  	<script>
					    const six = document.getElementById('lineChart').getContext('2d');
					    new Chart(six, {
					        type: 'line',
					        data: {
					            labels: ['7', '8', '9', '10', '11', '12'], // 예시 라벨
					            datasets: [{
					                label: '하반기 독서량',
					                data: lineChartData, // 서버에서 받은 데이터 사용
					                borderColor: '#42A5F5',
					                backgroundColor: 'rgba(66, 165, 245, 0.2)',
					                borderWidth: 1
					            }]
					        },
					        options: {
					            responsive: true,
					            plugins: {
					                legend: {
					                    position: 'top',
					                },
					                title: {
					                    display: true,
					                    text: '라인 차트 - 독서 통계'
					                }
					            }
					        }
					    });
					</script>
                </div>
             </div>
        </div>
    </div>
</body>
</html>