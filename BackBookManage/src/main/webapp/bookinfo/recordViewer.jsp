<%@page import="java.util.Date"%>
<%@page import="com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//String board_id_s = String.valueOf(request.getAttribute("board_id"));
String board_id_s = request.getParameter("board_id");  // URL 파라미터로 받은 board_id
request.setAttribute("board_id",board_id_s);
RequestDispatcher dispatcher = request.getRequestDispatcher("/boardInfoSearch.do");
dispatcher.include(request, response);

BookBoardInformationDTO bDTO = new BookBoardInformationDTO();
bDTO = (BookBoardInformationDTO)request.getAttribute("bDTO");
int board_id = bDTO.getBoard_id();
String board_title = bDTO.getBoard_title();
String board_contents = bDTO.getBoard_contents();
int board_recommend = bDTO.getBoard_recommend();
Date board_date = bDTO.getBoard_date();
String isbn = bDTO.getIsbn();
Float Board_rating = bDTO.getBoard_rating();
String member_id = bDTO.getMember_id();
%>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세 보기</title>
</head>
<body>
  <div class="container">
      <div class="post-header">
          <h1>게시글 상세 정보</h1>
      </div>

      <div class="post-info">
          <p><strong>글 아이디:</strong> <span id="board_id"><%=board_id%></span></p>
          <p><strong>글쓴이 닉네임:</strong> <span id="author_name"><%=member_id %></span></p>
          <p><strong>작성시간:</strong> <span id="created-time"><%=board_date %></span></p>
      </div>

      <div class="post-info">
          <p><strong>제목:</strong> <span id="title"><%=isbn %>을 사용하여 제목 구하기</span></p>
          <p class="content"><strong>내용:</strong><br> <span id="content"><%=board_contents %></span></p>
      </div>

      <div class="post-info">
          <p><strong>좋아요:</strong> <span class="likes" id="likes"><%=board_recommend %></span> 개</p>
          <p><strong>책 ID:</strong> <span class="book-id" id="book-id"><%=isbn %></span></p>
          <p><strong>평점:</strong> <span class="rating" id="rating"><%=Board_rating%></span> 점</p>
      </div>
      <button onClick="location.href='<%=request.getContextPath()%>/bookinfo/getRecord.jsp'">내 페이지로 돌아가기</button>
  </div>
</body>
</html>