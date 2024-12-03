<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%! 
	JSONArray itemResult; 
	JSONObject obj;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String result = (String)request.getAttribute("responseBody");
	if(result != null) {
		JSONObject jsonObject = new JSONObject(result);
		System.out.println(jsonObject);
		try {
			itemResult = jsonObject.getJSONArray("item");
		} catch(Exception e) {
			System.out.println("API 호출 에러");
		}
        
        
	} else {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookSection.do?bookSection=new");
		dispatcher.include(request, response);
	}
%>
	<section class="book-section">
        <!--book-container-->
        <div class="book-container">
            <div class="tab-menu">
                <button onClick="location.href='<%= request.getContextPath() %>/bookSection.do?bookSection=new'">신규 도서</button>
                <button onClick="location.href='<%= request.getContextPath() %>/bookSection.do?bookSection=bestBook'">베스트 도서</button>
                <button>베스트 리뷰</button> <%--기능 추가하기 --%>
            </div>
            <!--book-cards-->
            <div class="book-cards">
            <% 
            	for (int i = 0; i < itemResult.length(); i++) {
      				obj = itemResult.getJSONObject(i);
      		%>
                <div class="book-card">
                    <img src="<%= obj.getString("cover") %> " height="200px" width="150px" alt="리뷰 1 이미지">
                    <ul class="book-info">
                        <li class="bReview-title"><%= obj.getString("title") %></li>
                        <li class="bReview-booktitle"><%= obj.getString("author") %></li>
                        <li class="bReview-writer"><%= obj.getString("pubDate") %></li>
                    </ul>
                </div>
             <% 
             	} 
             %>   
            </div>
        </div>
      </section>
</body>
</html>