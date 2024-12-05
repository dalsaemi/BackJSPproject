<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%! 
	JSONObject itemResult; 
%>
<%
	// BookSearch 페이지에서 상세 보기 버튼 누르면 나오는 컨텐츠
	request.setCharacterEncoding("UTF-8");
	// RequestDispatcher dispatcher = request.getRequestDispatcher("/bookSelect.do");
	// dispatcher.include(request, response);
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/modal_styles.css">
</head>
<body>
<div id="modalContainer">
  <div id="modalContent">
    <button id="modalCloseButton">닫기</button>
    <% if (result != null && itemResult != null) { %>
    <h3><%= itemResult.getString("title") %></h3>
    <img src="<%= itemResult.getString("cover") %>" height="100px" width="60px"/>
    <p><%= itemResult.getString("title") %></p>
    <p><%= itemResult.getString("author") %></p>
    <p><%= itemResult.getString("publisher") %></p>
    <p><%= itemResult.getString("pubDate") %></p>
    <%= itemResult.getString("description") %>
<% } else { %>
    <p>책 정보가 없습니다.API 응답: <%= result %></p> 
<% } %>
  </div>
</div>
</body>
</html>