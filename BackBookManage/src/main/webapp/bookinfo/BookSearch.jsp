<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>책 검색</title>
</head>
<body>
	<!-- 정렬 기능 - API 확인 후 추가 -->
    <div class="search_book">
        <form class="srch" action="#" method="get">
          <label for="query">도서 검색</label>
          <input type="text" name="book_query" id="query" title="검색어" class="keyword" placeholder="검색할 단어를 입력하세요" value="">
          <input type="submit" id="search" name="search" value="검색" />
        </form>
    </div>
    
    <table border="1" summary="책 검색 API 결과" class="tb_type">
    <caption>검색 결과</caption>
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
        <tr class="oldlist">
          <td colspan="8">검색 결과가 없습니다.</td>
        </tr>
        <tr class="template" style="display: none">
          <td><img src="#" height="80px" width="50px"/></td>
          <td>title</td>
          <td>author</td>
          <td>publisher</td>
          <td>pubDate</td>
          <td>star</td>
          <td>
          	<form>
				<button type="submit">세부페이지</button>
			</form>	
          </td>
          <td>
		  	<form>
				<button type="submit">기록하기</button>
			</form>	
		  </td>
        </tr>
      </tbody>
    </table>
</body>

</html>