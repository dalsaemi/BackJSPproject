<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실패</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/member/LogError_styles.css?2">
</head>
<body>
    <div class="error-container">
        <h1>로그인 실패</h1>
        <p>아이디 또는 비밀번호가 잘못되었습니다.</p>
        <p class = "p-under">메인 페이지로 돌아가서 다시 로그인을 시도해주세요.</p>
        <p><a href="<%= request.getContextPath() %>/index.jsp">메인 페이지로 돌아가기</a></p>
    </div>
</body>
</html>