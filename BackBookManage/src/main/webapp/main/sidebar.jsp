<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main/sidebar_styles.css">
</head>
<body>
	<div class="sidebar">
		<ul>
	     	<li><a href="<%=request.getContextPath() %>/member/myrecordpage.jsp">나의 독서 기록</a></li>
	  		<li><a href="#">자주 가는 도서관</a></li>
	  		<li><a href="<%=request.getContextPath() %>/bookinfo/getRecord.jsp">작성 글 모아보기</a></li>
	 		<li><a href="#">즐겨찾기 목록</a></li>
	   		<li><a href="<%=request.getContextPath() %>/member/mypage.jsp">회원정보 및 계정 관리</a></li>
	    </ul>
	</div>
</body>
</html>