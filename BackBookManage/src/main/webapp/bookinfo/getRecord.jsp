<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/getRecord.css">
    <title>내 기록 모아보기</title>
    <style>
        
    </style>
</head>
<body>
	<jsp:include page="${request.getContextPath()}/main/header.jsp" />
    <div class="container">
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
                <p>기록 수: <%= myBoardCount %></p>
                <div class="post-list">
                <%
                	if (myBoardCount == 0){
                %>
                <p>내 기록이 없습니다.<p>
                <%
                	}else{
                		for (int myBoard : myBoards) {
                        	request.setAttribute("myBoard", myBoard);
    	                	dispatcher = request.getRequestDispatcher("/boardSimpleShow.do");
    	                	dispatcher.include(request, response);
    	                	ArrayList<String> boardInfo = (ArrayList<String>)request.getAttribute("boardInfo");
	            %>
                    <!-- 글 생성 -->
                    <div class="post-item" onclick="location.href='<%=request.getContextPath()%>/bookinfo/recordViewer.jsp?board_id=<%=myBoard%>'">
                        <img src="#" alt="글 1 이미지">
                        <h3>책isbn : <%=boardInfo.get(2)%></h3>
                        <p>책 별점 : <%=boardInfo.get(3)%></p>
                        <p><%=boardInfo.get(0)%></p>
                        <div class="date"><%=boardInfo.get(1)%></div>
                    </div>
                <% }} %>
                </div>
            </div>
        </div>
    </div>
</body>
</html>