<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/index_styles.css">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main/header_styles.css">
</head>
<body>
	<!--header-->
        <header class="header">
            <div class="header-inner">
            	<a href="<%=request.getContextPath() %>/index.jsp">
            		<img class = "logo-img" src="${pageContext.request.contextPath}/image/logo_img.png" alt="로고" width = "50" height = "50">
            	</a>
                <div class="logo"><a class = "index-title" href="<%=request.getContextPath() %>/index.jsp">&nbsp;PageFlow</a></div>
                <div class="search-bar">
	                <form action="<%= request.getContextPath() %>/bookSearch.do" method="get" id="search-form">
					    <input type="text" name="inputSearch" placeholder="도서 검색">
					    <button type="submit">🔍</button>
					</form>
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
</body>
</html>