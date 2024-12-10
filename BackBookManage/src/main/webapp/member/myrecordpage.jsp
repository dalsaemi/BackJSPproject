<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   
   //멤버 한달 읽은 수 불러오기
   RequestDispatcher dispatcher = request.getRequestDispatcher("/chart.do");
   dispatcher.include(request, response);
   int booksRead = (int)request.getAttribute("booksRead");
   
   //dispatcher = request.getRequestDispatcher("/recentBoardSearch.do");
   //dispatcher.include(request, response);
   //int recentBoards = (int)request.getAttribute("recentBoards");
   //System.out.println("이거 맞아요? :" +recentBoards);
   
   //멤버 목표 설정값 불러오기
   dispatcher = request.getRequestDispatcher("/monthlyBoardGet.do");
   dispatcher.include(request, response);
   int bookGoal = (int)request.getAttribute("bookGoal");
   
   //남은 책 수 초기화
   int booksRemaining = bookGoal - booksRead;
   
   //확인용 로그
   /*
   System.out.println("booksRead : "+booksRead);
   System.out.println("bookGoal : "+bookGoal);
   System.out.println("booksRemaining : "+booksRemaining);
   */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/myrecordpage_styles.css?1">
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
                    <img name="book_image" src="#" alt="책 이미지"> <!-- 이미지 받아와서 배치하도록 추후 수정 -->
                    <div class="info">
                        <p>최근 읽은 책</p>
                        <p><strong>책 이름</strong></p>
                        <p>저자</p>
                        <p>출판사</p>
                        <p>출판년도</p>
                        <p>별점</p>
                    </div>
                </div>

                <div class="section goal-section">
                    <div class="goal-box">
                        <h3>이번 달 나의 목표</h3>
                        <p>독서 목표: 
                        <select id="bookGoal" name="bookGoal" size="1">
                            <option value="5" <%if(bookGoal == 5){%>selected="selected"<%}%>>5</option>
                            <option value="10" <%if(bookGoal == 10){%>selected="selected"<%}%>>10</option>
                            <option value="15" <%if(bookGoal == 15){%>selected="selected"<%}%>>15</option>
                            <option value="20" <%if(bookGoal == 20){%>selected="selected"<%}%>>20</option>
                        </select>
                        권</p>
                        <p>읽은 책: <%= booksRead %>권</p>
                        <p>목표 달성까지 <span id="remainingBooks"><%= booksRemaining %></span>권 남았어요!</p>
                    </div>
                    <div class="goal-box">
                        <h3>목표 달성치</h3>
                        <!-- chart show -->
                        <canvas id="goalChart" width="100px" height="100px"></canvas>
                    </div>
                </div>
                
                <script>
				    document.addEventListener("DOMContentLoaded", function () {
				        const booksRead = <%= booksRead %>;
				        let booksRemaining = <%= booksRemaining %>;
				
				        // 차트 컨텍스트
				        const ctx = document.getElementById('goalChart').getContext('2d');
				
				        // 도넛 차트 생성
				        const goalChart = new Chart(ctx, {
				            type: 'doughnut',
				            data: {
				                labels: ['읽은 책', '남은 책'],
				                datasets: [{
				                    data: [booksRead, booksRemaining], // 서버에서 전달된 데이터 사용
				                    backgroundColor: ['#FFD700', '#FFFFFF'], // 노란색, 하얀색
				                    borderColor: ['#FFD700', '#CCCCCC'],     // 테두리 색상
				                    borderWidth: 1,
				                    radius: 150
				                }]
				            },
				            options: {
				                responsive: true,
				                plugins: {
				                    legend: {
				                        position: 'bottom' // 범례 위치
				                    }
				                }
				            }
				        });
				
				        // 책 목표와 목표 달성까지 남은 권수 실시간 업데이트
				        document.querySelector("#bookGoal").addEventListener("change", function() {
				            const selectedOption = document.querySelector("#bookGoal > option:checked").value;
				            booksRemaining = selectedOption - booksRead; // 남은 책 수 재계산
				
				            // 실시간으로 남은 책 수 업데이트
				            document.getElementById("remainingBooks").textContent = booksRemaining;
				            
				            //한달 목표 db에 업데이트
				            var form = document.createElement('form');
						    form.method = 'GET';
						    form.action = '<%= request.getContextPath() %>/monthlyBoardUpdate.do';
						
						    var input = document.createElement('input');
						    input.type = 'hidden';
						    input.name = 'bookGoal';
						    input.value = selectedOption;
						    console.log("bookGoal"+selectedOption);
						
						    form.appendChild(input);
						    document.body.appendChild(form);
						    form.submit();
						    console.log("실행");
				            <%
					            //request.setAttribute("bookGoal", bookGoal);
					            //dispatcher = request.getRequestDispatcher("/monthlyBoardUpdate.do");
	   							//dispatcher.include(request, response);
   							%>
				
				            // 차트 데이터 갱신
				            goalChart.data.datasets[0].data = [booksRead, booksRemaining]; // 차트의 데이터 배열 갱신
				            goalChart.update(); // 차트 업데이트
				        });
				    });
				</script>

                <div class="section stats-section">
                    <div class="section-title">독서 통계</div>
                    <div class="chart-placeholder">
                        <canvas id="lineChart" width="800" height="400"></canvas>
                    </div>
                </div>
             </div>
        </div>
    </div>
</body>
</html>
