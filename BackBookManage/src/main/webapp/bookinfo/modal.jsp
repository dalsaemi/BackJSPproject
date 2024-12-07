<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, org.json.JSONObject, org.json.JSONArray, com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO" %>
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
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("/avgRating.do?isbn="+ itemResult.getString("isbn"));
	dispatcher.include(request, response);
	float avgRating = (float) request.getAttribute("avgRate");
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
    <button id="modalCloseButton"></button>
    <% if (result != null && itemResult != null) { %>
    <h3><%= itemResult.getString("title") %></h3>
    <img src="<%= itemResult.getString("cover") %>" height="100px" width="60px"/>
    <p><%= itemResult.getString("author") %></p>
    <p><%= itemResult.getString("publisher") %></p>
    <p><%= itemResult.getString("pubDate") %></p>
    <%= itemResult.getString("description") %>
    <h3>작성된 리뷰</h3>
    
	<%
		dispatcher = request.getRequestDispatcher("/boardReviewSelect.do?isbn="+ itemResult.getString("isbn"));
		dispatcher.include(request, response);
		
		ArrayList<BookBoardInformationDTO> listResults = new ArrayList<BookBoardInformationDTO>();
		listResults = (ArrayList<BookBoardInformationDTO>) request.getAttribute("boardSelectResult");

		if (avgRating >= 0) {
	%>
    <p>평균 평점 : <%= avgRating %></p>
    
    <table id="modal-review">
	    <colgroup>
	        <col width="25%">
	        <col width="40%">
	        <col width="20%">
	        <col width="15%">
	      </colgroup>
    	<tr>
	      <th scope="col">작성자</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성날짜</th>
	      <th scope="col">추천수</th>
    	</tr>
    <% 
    		for (BookBoardInformationDTO board : listResults) {
				if(listResults.size() != 0) {	
	%>
		<tr id="review-list" onClick="location.href='<%= request.getContextPath() %>/bookinfo/recordViewer.jsp?board_id=<%= board.getBoard_id() %>'">
    		<td><%= board.getMember_id() %></td>
    		<td><%= board.getBoard_title() %></td>
    		<td><%= board.getBoard_date() %></td>
    		<td><%= board.getBoard_recommend() %></td>
		</tr>
	<%	
				}
    		}
	%>
	
    </table>

	<% 
		} else { // if avgRate end
	%>
	<p>작성된 리뷰가 없습니다.</p>
	<%
		}
    } else { 
	%>
	    <p>책 정보가 없습니다.API 응답: <%= result %></p> 
	<% 	
	} 
	%>
  </div>
</div>
</body>
</html>