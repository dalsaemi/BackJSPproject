<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
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
          <p><strong>글 아이디:</strong> <span id="board_id">12345</span></p>
          <p><strong>글쓴이 닉네임:</strong> <span id="author_name">user123</span></p>
          <p><strong>작성시간:</strong> <span id="created-time">2024-11-29 14:30</span></p>
      </div>

      <div class="post-info">
          <p><strong>제목:</strong> <span id="title">책에 대한 생각</span></p>
          <p class="content"><strong>내용:</strong><br> <span id="content">이 책은 매우 유익하며, 다양한 시각을 제공합니다. 독서 후 많은 생각을 하게 되었습니다.</span></p>
      </div>

      <div class="post-info">
          <p><strong>좋아요:</strong> <span class="likes" id="likes">150</span> 개</p>
          <p><strong>책 ID:</strong> <span class="book-id" id="book-id">98765</span></p>
          <p><strong>평점:</strong> <span class="rating" id="rating">4.5</span> 점</p>
      </div>
  </div>
</body>
</html>