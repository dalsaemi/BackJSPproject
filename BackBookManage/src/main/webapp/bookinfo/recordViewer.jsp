<%@page import="java.util.Date, java.text.SimpleDateFormat, org.json.JSONObject, org.json.JSONArray"%>
<%@page import="com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	JSONObject itemResult; 
%>
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
SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
String datetostr = format.format(board_date);

String isbn = bDTO.getIsbn();
Float Board_rating = bDTO.getBoard_rating();
String member_id = bDTO.getMember_id();

// 책 제목 구하기
dispatcher = request.getRequestDispatcher("/bookSelect.do?id=" + isbn + "&command=record");
dispatcher.include(request, response);
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

// 추천 누르기 위한 로그인 체크
HttpSession callSession = request.getSession();
String loginmember = (String) callSession.getAttribute("member_id"); // 로그인 시 저장된 사용자 이름
if(loginmember == null) {
	loginmember = "none";
}
// 추천 중복 체크
boolean isLiked = false;
System.out.println("board_id: " + board_id + ", member_id: " + member_id);
dispatcher = request.getRequestDispatcher("/boardLike.do?board_id=" + board_id + "&member_id=" + member_id);
dispatcher.include(request, response);
if (request.getAttribute("isLiked") != null) {
	isLiked = (Boolean) request.getAttribute("isLiked");
}

//관리자는 삭제 버튼 뜨게
boolean isManager = false;
if(session.getAttribute("is_manager") != null) {
	isManager = (boolean) session.getAttribute("is_manager");
}

%>
<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세 보기</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/recordViewer_styles.css">
</head>
<body>
  <div class="viewer-container">
      <div class="post-header">
          <h1>게시글 제목 : <%=board_title%></h1>
      </div>

      <div class="post-info">
          <p><strong>글 아이디: </strong> <span id="board_id"><%=board_id%></span></p>
          <p><strong>글쓴이 닉네임: </strong> <span id="author_name"><%=member_id %></span></p>
          <p><strong>작성시간: </strong> <span id="created-time"><%= datetostr %></span></p>
      </div>

      <div class="post-info">
          <p><strong>책 제목: </strong> <span id="title">
          <% if (result != null && itemResult != null) { %>
          	<%= itemResult.getString("title") %>
          <%} %>
          </span></p>
          <p class="content"><strong>내용: </strong><br> <span id="content"><%=board_contents %></span></p>
      </div>

      <div class="post-info">
          <p><strong>좋아요: </strong> <span class="likes" id="likes"><%=board_recommend %></span> 개</p>
          <p><strong>책 ID: </strong> <span class="book-id" id="book-id"><%=isbn %></span></p>
          <p><strong>평점: </strong> <span class="rating" id="rating"><%=Board_rating%></span> 점</p>
      </div>
      
      <button id="likeButton" class="<%= isLiked ? "liked" : "" %>"
       data-board-id="<%= board_id %>" data-member-id="<%= loginmember %>">♡</button>
      <button onClick="location.href='<%= request.getContextPath()%>/index.jsp'">메인 화면으로</button>
      <% if (!loginmember.equals("none") && !isManager) { %>
		<button onClick="location.href='<%= request.getContextPath()%>/bookinfo/getRecord.jsp'">작성 글 모아보기</button>
      <% } %>
      <% if (isManager) { %>
      	<button onClick="location.href='<%= request.getContextPath()%>/adminBoard.do'">게시판 관리창으로</button>
      <% } %>
      <% if (loginmember.equals(member_id) || isManager) { %>
      <form action="<%=request.getContextPath()%>/bookinfo/recordUpdate.jsp">
	  		<input type="hidden" name="book_isbn" value="<%=isbn %>">
	  		<input type="hidden" name="book_cover" value="<%=itemResult.getString("cover")%>">
	  		<input type="hidden" name="book_title" value="<%=itemResult.getString("title") %>">
	  		<input type="hidden" name="board_title" value="<%= board_title %>">
	  		<input type="hidden" name="board_contents" value="<%=board_contents %>">
	  		<input type="hidden" name="board_rating" value="<%= Board_rating %>">
	  		<input type="hidden" name="board_id" value="<%= board_id %>">
			<button type="submit">수정</button>
	  </form>
      <button onClick="confirmDelete(<%= board_id %>)">삭제</button>
      <% } %>
  </div>
  <script>
	//삭제 확인 함수
	var isManager = <%= isManager %>;
	function confirmDelete(boardId) {
	    if (confirm("게시물을 삭제하시겠습니까? 삭제하면 복구할 수 없습니다.")) {
	        // 삭제 요청 전송
	        fetch("<%= request.getContextPath() %>/boardDelete.do", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/x-www-form-urlencoded"
	            },
	            body: "boardId=" + boardId
	        })
	        .then(response => response.text())
	        .then(data => {
	            alert(data); // 서버에서 받은 메시지 출력
	            if (isManager) {
	            	window.location.href = "<%= request.getContextPath() %>/adminBoard.do";
	            } else {
	            	window.location.href = "<%= request.getContextPath() %>/bookinfo/getRecord.jsp";
	            }
	        })
	        .catch(error => {
	            alert("오류가 발생했습니다. 다시 시도해주세요.");
	            console.error(error);
	        });
	    }
	}
  </script>
  <script src="<%= request.getContextPath() %>/js/like_js.js" type="module"></script>
</body>
</html>