<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject, org.json.JSONArray" %>
<%! 
	JSONArray itemResults;
	JSONObject reviewapiResult;
	JSONObject obj;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/main/book_section_styles.css">

</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String results = (String)request.getAttribute("responseBody");
	String bookSectionMode = (String)request.getAttribute("bookSection");
	if(bookSectionMode == null) {
		bookSectionMode = "new";
	}
	ArrayList<BookBoardInformationDTO> bestReviewList = new ArrayList<BookBoardInformationDTO>();
	if (bookSectionMode.equals("new") || bookSectionMode.equals("bestBook")) {
		if(results != null) {
			JSONObject jsonObject = new JSONObject(results);
			try {
				itemResults = jsonObject.getJSONArray("item");
			} catch(Exception e) {
				System.out.println("API 호출 에러");
			}
	        
	        
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/bookSection.do?bookSection=new");
			dispatcher.include(request, response);
		}
	}
	else {
		bestReviewList = (ArrayList<BookBoardInformationDTO>) request.getAttribute("bestReviewList");
	}
%>
	<section class="book-section">
        <!--book-container-->
        <div class="book-container">
            <div class="tab-menu">
                <button onClick="location.href='<%= request.getContextPath() %>/bookSection.do?bookSection=new'" class='<%= bookSectionMode.equals("new") ? "currentMode" : "" %>'>신규 도서</button>
    			<button onClick="location.href='<%= request.getContextPath() %>/bookSection.do?bookSection=bestBook'" class='<%= bookSectionMode.equals("bestBook") ? "currentMode" : "" %>'>베스트 도서</button>
                <button onClick="location.href='<%= request.getContextPath() %>/bookSection.do?bookSection=bestReview'" class='<%= bookSectionMode.equals("bestReview") ? "currentMode" : "" %>'>베스트 리뷰</button>
            </div>
            <!--book-cards-->
            <div class="book-cards">
            <% 
            	if (bookSectionMode.equals("new") || bookSectionMode.equals("bestBook")) {
	            	for (int i = 0; i < itemResults.length(); i++) {
	      				obj = itemResults.getJSONObject(i);
      		%>
                <div class="book-card modalOpenButton" data-id='<%= obj.getString("isbn")%>'>
                    <img src="<%= obj.getString("cover") %> " height="200px" width="150px" alt="리뷰 1 이미지">
                    <ul class="book-info">
                        <li class="bReview-title"><%= obj.getString("title") %></li>
                        <li class="bReview-booktitle"><%= obj.getString("author") %></li>
                        <li class="bReview-writer"><%= obj.getString("pubDate") %></li>
                    </ul>
                </div>
             <% 
             		}
            	} else {
            		for (int i = 0; i < bestReviewList.size(); i++) {
            			String isbn = bestReviewList.get(i).getIsbn();
            			dispatcher = request.getRequestDispatcher("/bookSelect.do?id=" + isbn + "&command=record");
	                	dispatcher.include(request, response);
	                	String apiResults = (String)request.getAttribute("responseBody");
	                	if(apiResults != null) {
	                		try {
	                			JSONObject jsonObject = new JSONObject(apiResults);
	                			JSONArray itemArray = jsonObject.getJSONArray("item");
	                			if (itemArray.length() > 0) {
	                				reviewapiResult = itemArray.getJSONObject(0);  // 첫 번째 요소
	                	        }
	                		} catch(Exception e) {
	                			System.out.println("item 객체를 가져오는데 오류 발생: " + e.getMessage());
	                		}
	                	}
	                	if (apiResults != null && itemResult != null) {
             %>  
             	<div class="book-card" onClick="location.href='<%= request.getContextPath() %>/bookinfo/recordViewer.jsp?board_id=<%= bestReviewList.get(i).getBoard_id() %>'">
                    <img src="<%= reviewapiResult.getString("cover") %>" height="200px" width="150px" alt="리뷰 1 이미지">
                    <ul class="book-info">
                        <li class="bReview-title"><%= bestReviewList.get(i).getBoard_title() %></li>
                        <li class="bReview-booktitle"><%= reviewapiResult.getString("title") %></li>
                        <li class="bReview-writer"><%= bestReviewList.get(i).getMember_id() %> 님의 리뷰</li>
                    </ul>
                </div>
             <% 
	                	}
             		}
           		} 
            %>
            </div>
        </div>
        <%-- 모달 창 --%>
		<%@include file="/bookinfo/modal.jsp" %>
		<script src="<%= request.getContextPath() %>/js/modal_js.js" type="module"></script>
    </section>
    
</body>
</html>