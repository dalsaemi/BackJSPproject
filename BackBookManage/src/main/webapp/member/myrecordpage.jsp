<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	JSONObject itemResult; 
%>
<%
   request.setCharacterEncoding("UTF-8");
   
   //멤버 한달 읽은 수 불러오기
   RequestDispatcher dispatcher = request.getRequestDispatcher("/chart.do");
   dispatcher.include(request, response);
   ArrayList<Integer> booksRead = (ArrayList<Integer>)request.getAttribute("booksRead");
   int thisMonthRead = booksRead.get(5); //이번달에 읽은 책
   
   //멤버 최근 읽은 책 정보 불러오기
   dispatcher = request.getRequestDispatcher("/recentBoardSearch.do");
   dispatcher.include(request, response);
   String recentBook = (request.getAttribute("recentBook")).toString();
   float myrat = Float.parseFloat(request.getAttribute("myrat").toString());
   
   //멤버 목표 설정값 불러오기
   dispatcher = request.getRequestDispatcher("/monthlyBoardGet.do");
   dispatcher.include(request, response);
   int bookGoal = (int)request.getAttribute("bookGoal");
   
   //남은 책 수 초기화
   int booksRemaining = bookGoal - thisMonthRead;
   
   //확인용 로그
   /*
   System.out.println("booksRead : "+booksRead);
   System.out.println("bookGoal : "+bookGoal);
   System.out.println("booksRemaining : "+booksRemaining);
   */
   
 	//6개월 값 가져오기
	LocalDate currentDate = LocalDate.now();
	int currentMonth = currentDate.getMonthValue();
	
	ArrayList<Integer> lastSixMonths = new ArrayList<Integer>();
	
	//currentMonth = 2; //값 확인용
	
	for (int i = 0; i < 6; i++) {
	       int month = currentMonth - i;
	       if (month <= 0) {
	           month += 12; // 1월 이전으로 넘어가면 12월로 순환
	       }
	       lastSixMonths.add(month);
	   }
	   
	// 리스트를 뒤집어서 최신 월부터 표시되도록 정렬 (내림차순)
	Collections.reverse(lastSixMonths);
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
                    <%if(recentBook.equals("noBoard")){%>
	                	<div class="info">
	                		<p>최근에 읽은 책이 없습니다.</p>
	                	</div>
		           	<%}else{ 
		           		dispatcher = request.getRequestDispatcher("/bookSelect.do?id=" + recentBook + "&command=record");
	                	dispatcher.include(request, response);
	                	String result = (String)request.getAttribute("responseBody");
	                	if (result != null) {
	                		try {
	                			JSONObject jsonObject = new JSONObject(result);
	                			JSONArray itemArray = jsonObject.getJSONArray("item");
	                			if (itemArray.length() > 0) {
	                	            itemResult = itemArray.getJSONObject(0);  // 첫 번째 요소
	                	        }
	                		} catch(Exception e) {
	                			System.out.println("item 객체를 가져오는데 오류 발생: " + e.getMessage());
	                		}
	                	}
	                	if (result != null && itemResult != null) {
		           	%>
		           		<img name="book_image" src="<%= itemResult.getString("cover") %>" alt="책 이미지"> <!-- 이미지 받아와서 배치하도록 추후 수정 -->
	                    <div class="info">
	                        <p>최근 읽은 책</p>
	                        <p><strong><%=itemResult.getString("title")%></strong></p>
	                        <p>저자:<%=itemResult.getString("author")%></p>
	                        <p>출판사:<%=itemResult.getString("publisher")%></p>
	                        <p>출판년도:<%=itemResult.getString("pubDate")%></p>
	                        <p>나의 평가:<%=myrat%></p>
	                    </div>
		           	<% }}%>
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
                        <p>읽은 책: <%= thisMonthRead %>권</p>
                        <p>목표 달성까지 <span id="remainingBooks"><%= booksRemaining %></span>권 남았어요!</p>
                    </div>
                    <div class="goal-box">
                        <h3>목표 달성치</h3>
                        <!-- chart show -->
                        <canvas id="goalChart" width="100px" height="100px"></canvas>
                    </div>
                </div>
                <div class="section stats-section">
                    <div class="section-title">독서 통계</div>
                    <div class="chart-placeholder">
                        <canvas id="lineChart" width="800" height="400"></canvas>
                    </div>
                </div>
                <script>
				    document.addEventListener("DOMContentLoaded", function () {
				        const thisMonthRead = <%= thisMonthRead %>;
				        let booksRemaining = <%= booksRemaining %>;
				
				        // 차트 컨텍스트
				        const ctx = document.getElementById('goalChart').getContext('2d');
				
				        // 도넛 차트 생성
				        const goalChart = new Chart(ctx, {
				            type: 'doughnut',
				            data: {
				                labels: ['읽은 책', '남은 책'],
				                datasets: [{
				                    data: [thisMonthRead, booksRemaining], // 서버에서 전달된 데이터 사용
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
				            booksRemaining = selectedOption - thisMonthRead; // 남은 책 수 재계산
				
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
				            goalChart.data.datasets[0].data = [thisMonthRead, booksRemaining]; // 차트의 데이터 배열 갱신
				            goalChart.update(); // 차트 업데이트
				        });
				    });
					    
					//6개월 값 받기
					var lastSixMonths = <%= lastSixMonths.toString() %>;
					var labels = lastSixMonths;
					var booksReadList = <%= booksRead %>;
					
					//6개월간의 독서량 표시
					document.addEventListener("DOMContentLoaded", function () {
					    const ctx = document.getElementById('lineChart').getContext('2d');
					    const lineChart = new Chart(ctx, {
					        type: 'line',
					        data: {
					            labels: lastSixMonths,
					            datasets: [{
					                label: '지난 6개월 독서량',
					                data: booksReadList,
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
					            },
					            scales: {
					            	y: {
					                    min: 0,
					                    // 데이터의 최대값이 10보다 적을 경우 10을 최대값으로
						                max: Math.max(10, Math.max(...booksReadList)),
						                beginAtZero: true,
						                ticks: {
						                    stepSize: 1
					                    }
					                }
					            }
					        }
					    });
					});
               </script>
             </div>
        </div>
    </div>
</body>
</html>
