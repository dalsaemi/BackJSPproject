<!-- 독서 기록 작성 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>독서 기록 작성</title>
</head>
<body>
  <div class="container">
    <h1>독서 기록 작성</h1>
    <form action="/submit" method="POST" enctype="multipart/form-data">
      <!-- 제목 -->
      <label for="title">제목</label>
      <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
      <br>

      <!-- 작성자 -->
      <label for="author">작성자</label>
      <input type="text" id="author" name="author" placeholder="작성자를 입력하세요" required>
      <br>

      <!-- ISBN (수정 불가능) -->
      <label for="isbn">ISBN</label>
      <input type="text" id="isbn" name="isbn" class="readonly-field" readonly>
      <br>

      <!-- 본문 -->
      <label for="content">본문</label>
      <textarea id="content" name="content" placeholder="내용을 입력하세요" required></textarea>
      <br>

      <!-- 파일 첨부 -->
      <label for="file">파일 첨부</label>
      <input type="file" id="file" name="file">
      <br>

      <!-- 버튼 -->
      <div class="button-container">
        <button type="submit">작성하기</button>
      </div>
    </form>
  </div>
</body>
</html>