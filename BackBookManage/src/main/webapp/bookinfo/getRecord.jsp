<%@page import="java.util.ArrayList, org.json.JSONObject, org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	JSONObject itemResult; 
%>
<%
request.setCharacterEncoding("UTF-8");
RequestDispatcher dispatcher = request.getRequestDispatcher("/myBoardSearch.do");
dispatcher.include(request, response);
ArrayList<Integer> myBoards = (ArrayList<Integer>)request.getAttribute("myBoards");

//회원 수 계산
int myBoardCount = myBoards.size();

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/getRecord_styles.css">
    <title>내 기록 모아보기</title>
    <style>
        
    </style>
</head>
<body>
	
    <div class="container">
        <!-- 헤더 -->
        <%@ include file="/main/header.jsp" %>

        <div class="content-wrapper">
            <%@ include file="/main/sidebar.jsp" %>
            <div class="myrecord">
                <h1>내 기록 모아보기</h1> <!-- 인터페이스 보여주기 위해 임시 코드, 이후 try-catch 및 for문 응용 -->
                <p>기록 수: <%= myBoardCount %></p>
                <div class="post-list">
                <%
                	if (myBoardCount == 0){
                %>
                <p>내 기록이 없습니다.<p>
                <%
                	} else {
                		for (int myBoard : myBoards) {
                        	request.setAttribute("myBoard", myBoard);
    	                	dispatcher = request.getRequestDispatcher("/boardSimpleShow.do");
    	                	dispatcher.include(request, response);
    	                	ArrayList<String> boardInfo = (ArrayList<String>)request.getAttribute("boardInfo");
    	                	dispatcher = request.getRequestDispatcher("/bookSelect.do?id=" + boardInfo.get(2) + "&command=record");
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
                    <!-- 글 생성 -->
                    <div class="post-item" onclick="location.href='<%=request.getContextPath()%>/bookinfo/recordViewer.jsp?board_id=<%=myBoard%>'">
                        <img src="<%= itemResult.getString("cover") %>" alt="글 1 이미지">
                        <h3><%=itemResult.getString("title")%></h3>
                        <p>책 별점 : <%=boardInfo.get(3)%></p>
                        <p><%=boardInfo.get(0)%></p>
                        <p>추천 수 : <%= boardInfo.get(4) %></p>
                        <div class="date"><%=boardInfo.get(1)%></div>
                    </div>
                <% }}} %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>