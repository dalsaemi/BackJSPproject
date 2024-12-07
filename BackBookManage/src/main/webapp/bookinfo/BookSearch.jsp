<%@page import="com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject, org.json.JSONArray, com.backbookmanage.common.PagingBean" %>
<%! 
	JSONArray itemResults; 
	JSONObject obj;
	int itemNum;
	PagingBean pg;
	String inputSearch;
%>
<%
	request.setCharacterEncoding("UTF-8");
	
	inputSearch = (String)request.getAttribute("inputSearch");
	String results = (String)request.getAttribute("responseBody");
	String currentPageStr = (String)request.getAttribute("currentPage");
	String maxResultsStr = (String)request.getAttribute("maxResults");
	int currentPage = Integer.parseInt(currentPageStr);
	int maxResults = Integer.parseInt(maxResultsStr);
	int groupPerPageCnt = 5;
	if(results == null) {
		results = null;
	} else {
		JSONObject jsonObject = new JSONObject(results);
		try {
			itemNum =  jsonObject.getInt("totalResults");
			itemResults = jsonObject.getJSONArray("item");
		}
		catch(Exception e) {
			itemNum = 0;
		}
		pg = new PagingBean(currentPage, itemNum, maxResults, groupPerPageCnt);
        
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>책 검색</title>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/BookSearch_styles.css">
</head>
<body>
	<%@ include file="/main/header.jsp" %>
	<!-- 정렬 기능 - API 확인 후 추가 -->
    <table border="1" summary="책 검색 API 결과" class="tb_type">
    <caption>검색 결과 <%= itemNum %>개</caption>
      <colgroup>
        <col width="10%">
        <col width="20%">
        <col width="15%">
        <col width="15%">
        <col width="15%">
        <col width="10%">
      </colgroup>
      <thead>
        <tr>
          <th scope="col">책표지</th>
          <th scope="col">책이름</th>
          <th scope="col">저자</th>
          <th scope="col">출판사</th>
          <th scope="col">출판년도</th>
          <th scope="col">별점</th>
          <th scope="col">책 세부정보</th>
          <th scope="col">기록 페이지</th>
        </tr>
      </thead>
      <tbody id="result">
      <% 
      	if (results == null || itemResults == null || itemNum == 0) { 
      %>
        <tr class="oldlist">
          <td colspan="8">검색 결과가 없습니다.</td>
        </tr>
      <% 
      	} else { 
      		for (int i = 0; i < itemResults.length(); i++) {
      			obj = itemResults.getJSONObject(i);
      			String cover = obj.getString("cover");
      			String title = obj.getString("title");
      			
      			BookBoardInformationDAO boardinfo = new BookBoardInformationDAO();
      			float avgRate = boardinfo.avgBoardRating(obj.getString("isbn"));
      %>
        <tr class="template">
          <td><img src="<%=cover%>" height="80px" width="50px"/></td>
          <td><%= title %></td>
          <td><%= obj.getString("author") %></td>
          <td><%= obj.getString("publisher") %></td>
          <td><%= obj.getString("pubDate") %></td>
          <% if(avgRate > 0) { %>
          <td><%= avgRate %></td>
          <% } else { %>
          <td>리뷰가 없습니다.</td>
          <% } %>
          <td>
		  	<button class="modalOpenButton" data-id='<%= obj.getString("isbn")%>'>
		  		세부페이지
		  	</button>
          </td>
          <td>
		  	<form action="<%=request.getContextPath()%>/bookinfo/recordWrt.jsp">
		  		<input type="hidden" name="book_isbn" value="<%= obj.getString("isbn") %>">
		  		<input type="hidden" name="book_cover" value="<%=cover%>">
		  		<input type="hidden" name="book_title" value="<%=title%>">
				<button type="submit">기록하기</button>
			</form>	
		  </td>
        </tr>
        
      <% 
      		}
      	}
      %>
      </tbody>
    </table>
    <%-- 모달 창 --%>
	<%@include file="/bookinfo/modal.jsp" %>
	<script src="<%= request.getContextPath() %>/js/modal_js.js" type="module"></script>
    <%-- 페이징 --%>
    <a class = "next" href="<%= request.getContextPath() %>/bookSearch.do?inputSearch=<%= inputSearch %>&pageNo=1&maxResults=<%= maxResults %>&">[맨앞으로]</a>
    <a class = "next" href="<%= request.getContextPath() %>/bookSearch.do?inputSearch=<%= inputSearch %>&pageNo=<%= pg.getPrevPageno() %>&maxResults=<%= maxResults %>">[이전]</a> 

    <%
    	for(int i = pg.getPageSno(); i <= pg.getPageEno(); i++) {
	%>
		<a class = "next" href="<%= request.getContextPath() %>/bookSearch.do?inputSearch=<%= inputSearch %>&pageNo=<%= i %>&maxResults=<%= maxResults %>">
	<% 			
      	
      		if(pg.getPageno() == i) {
     %>
      		[<%=i %>]		
   	<%
     		} else { 
     %>
     	 <%= i %>		
   	<%
     		}
    	}
     %>

    	</a> 
    <a class = "next" href="<%= request.getContextPath() %>/bookSearch.do?inputSearch=<%= inputSearch %>&pageNo=<%= pg.getNextPageno() %>&maxResults=<%= maxResults %>">[다음]</a>
    <a class = "next" href="<%= request.getContextPath() %>/bookSearch.do?inputSearch=<%= inputSearch %>&pageNo=<%= pg.getTotalPage() %>&maxResults=<%= maxResults %>">[맨뒤로]</a>
</body>

</html>