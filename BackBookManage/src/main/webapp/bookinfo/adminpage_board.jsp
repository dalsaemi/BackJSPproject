<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.backbookmanage.bookBoard.DTO.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 관리</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main/header_styles.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/adminboard_styles.css">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	ArrayList<BookBoardInformationDTO> allBoards = (ArrayList<BookBoardInformationDTO>) request.getAttribute("allBoards");
	
%>
	<header class="header">
        <div class="header-inner">
        	<a href="<%=request.getContextPath() %>/index.jsp">
            	<img class = "logo-img" src="${pageContext.request.contextPath}/image/logo_img.png" alt="로고" width = "50" height = "50">
            </a>
            <div class="logo"><a class = "index-title" href="<%=request.getContextPath() %>/index.jsp">&nbsp;PageFlow</a></div>
            <!--menu-->
            <nav class="nav-links">
                <a href="<%=request.getContextPath() %>/member/adminpage.jsp">회원 관리</a>
                <a href="<%=request.getContextPath() %>/adminBoard.do">게시판 관리</a>
            </nav>
        </div>
    </header>
    <h2>게시판 관리</h2>
    <table>
	    <colgroup>
	        <col width="10%">
	        <col width="40%">
	        <col width="20%">
	        <col width="30%">
	    </colgroup>
	    <thead>
	        <tr>
	          <th scope="col">번호</th>
	          <th scope="col">제목</th>
	          <th scope="col">작성자</th>
	          <th scope="col">작성날짜</th>
	        </tr>
      	</thead>
		<tbody id="result">
		<% 
    		if (allBoards != null && !allBoards.isEmpty()) { 
    			for (BookBoardInformationDTO board : allBoards) {
    	%>
    	<tr onClick="location.href='<%= request.getContextPath() %>/bookinfo/recordViewer.jsp?board_id=<%= board.getBoard_id() %>'">
	        <td><%= board.getBoard_id() %></td>
	        <td><%= board.getBoard_title() %></td>
	        <td><%= board.getMember_id() %></td>
	        <td><%= board.getBoard_date() %></td>
	    </tr>	
    	<% 		
    			}
    		} else {
    	%>
    	<tr>
	        <td colspan="4">게시판이 없습니다.</td>
	    </tr>
	    <%
    		}
	    %>	
		</tbody>
    	
    </table>
    
</body>
</html>