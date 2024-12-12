<%@page import="com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO"%>
<%@page import="com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO"%>
<%@page import="java.util.ArrayList, org.json.JSONObject, org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	JSONObject itemResult; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/recordWrt.css">
<title>게시글 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	// 멤버 이름
	RequestDispatcher dispatcher = request.getRequestDispatcher("/readMember.do");
	dispatcher.include(request, response);
	
	ArrayList<String> memberInfo = (ArrayList<String>) request.getAttribute("memberInfo");
	if (memberInfo == null) {
	    memberInfo = new ArrayList<>();
	}
	String member_id = memberInfo.get(0);
	String member_name = memberInfo.get(1);
	
	float board_rating = Float.parseFloat(request.getParameter("board_rating"));

%>
</body>
	<h1>독서 기록 작성</h1>
    <form action="<%=request.getContextPath()%>/boardUpdate.do" method="post">
      <image src="<%=request.getParameter("book_cover")%>">
      <h3>책 제목 : <%=request.getParameter("book_title")%></h3>
      <!-- 제목 -->
      <label for="title">제목</label>
      <input type="text" id="title" name="title" value="<%= request.getParameter("board_title") %>" required>
      <input type="hidden" name="board_id" value=<%= request.getParameter("board_id") %>>
      <br>

      <!-- 작성자 -->
      <label for="author">작성자</label>
      <input type="text" id="author" name="author" value=<%= member_name  %> readonly>
      <input type="hidden" name="member_id" value=<%= member_id %>>
      <br>

      <!-- ISBN (수정 불가능) -->
      <label for="isbn">ISBN</label>
      <input type="text" id="isbn" name="isbn" class="readonly-field" value="<%= request.getParameter("book_isbn") %>" readonly>
      <br>

      <!-- 본문 -->
      <label for="content">본문</label>
      <textarea id="content" name="content" required><%= request.getParameter("board_contents") %></textarea>
      <br>

      <!-- 파일 첨부 -->
      <!-- 
      <label for="file">파일 첨부</label>
      <input type="file" id="file" name="file">
      <br>
       -->
      <!-- 별점 표시 -->
		<label for="file">책 평점</label>
		<div class="rating">
		    <label class="rating__label rating__label--half" for="starhalf">
		        <input type="radio" id="starhalf" class="rating__input" name="rating" value="0.5" <%= board_rating == 0.5 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star1">
		        <input type="radio" id="star1" class="rating__input" name="rating" value="1" <%= board_rating == 1.0 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star1half">
		        <input type="radio" id="star1half" class="rating__input" name="rating" value="1.5" <%= board_rating == 1.5 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star2">
		        <input type="radio" id="star2" class="rating__input" name="rating" value="2" <%= board_rating == 2.0 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star2half">
		        <input type="radio" id="star2half" class="rating__input" name="rating" value="2.5" <%= board_rating == 2.5 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star3">
		        <input type="radio" id="star3" class="rating__input" name="rating" value="3" <%= board_rating == 3.0 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star3half">
		        <input type="radio" id="star3half" class="rating__input" name="rating" value="3.5" <%= board_rating == 3.5 ? "checked" : "" %> >
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star4">
		        <input type="radio" id="star4" class="rating__input" name="rating" value="4" <%= board_rating == 4.0 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star4half">
		        <input type="radio" id="star4half" class="rating__input" name="rating" value="4.5" <%= board_rating == 4.5 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star5">
		        <input type="radio" id="star5" class="rating__input" name="rating" value="5" <%= board_rating == 5.0 ? "checked" : "" %>>
		        <span class="star-icon"></span>
		    </label>
		</div>
		
		<p>선택한 점수: <span id="scoreDisplay"><%= board_rating %></span></p>

	     <!-- 버튼 -->
	     <div class="button-container">
	       <button type="submit">작성하기</button>
	       <button onclick="history.back()">취소</button>
	     </div>
    </form>
  </div>
  
  <!-- 별점기능 구현 -->
  <script type="text/javascript">
  const rateWrap = document.querySelectorAll('.rating'),
  label = document.querySelectorAll('.rating .rating__label'),
  input = document.querySelectorAll('.rating .rating__input'),
  scoreDisplay = document.getElementById('scoreDisplay'),  // 점수 표시 요소
  opacityHover = '0.5'; // Hover 불투명도
	
	let stars = document.querySelectorAll('.rating .star-icon');
	
	//초기 상태 확인
	checkedRate();
	
	//별점 클릭 이벤트 처리
	input.forEach((radio) => {
	radio.addEventListener('change', () => {
	    checkedRate();
	    updateScore();  // 점수 업데이트 함수 호출
	});
	});
	
	rateWrap.forEach(wrap => {
	wrap.addEventListener('mouseenter', () => {
	    stars = wrap.querySelectorAll('.star-icon');
	
	    stars.forEach((starIcon, idx) => {
	        starIcon.addEventListener('mouseenter', () => {
	            initStars(); 
	            filledRate(idx); 
	            updateHoverOpacity(idx); // hover 상태에서 별의 투명도를 처리
	
	            // Hover 상태에서 점수 업데이트 (마우스 올린 별점)
	            updateScore(idx); 
	        });
	
	        starIcon.addEventListener('mouseleave', () => {
	            starIcon.style.opacity = '1';
	            checkedRate();  // 원래 상태로 돌아감
	            updateScore();   // 선택된 점수로 업데이트
	        });
	
	        wrap.addEventListener('mouseleave', () => {
	            starIcon.style.opacity = '1';
	        });
	    });
	});
	});
	
	//클릭한 별을 채움
	function filledRate(index) {
	stars.forEach((star, idx) => {
	    if (idx <= index) {
	        star.classList.add('filled');
	    }
	});
	}
	
	//클릭된 별점에 맞는 점수를 화면에 표시
	function updateScore(idx = null) {
	let checkedRadio = document.querySelector('.rating input[type="radio"]:checked');
	if (checkedRadio) {
	    scoreDisplay.textContent = checkedRadio.value; // 선택된 라디오 버튼의 value 값을 점수로 표시
	} else if (idx !== null) {
	    // hover 시 임시 점수 표시
	    scoreDisplay.textContent = (idx + 1) * 0.5; // index 기반으로 점수 표시
	}
	}
	
	//Hover 상태에서 이미 채워진 별의 투명도를 조정
	function updateHoverOpacity(index) {
	stars.forEach((star, idx) => {
	    if (idx <= index) {
	        star.style.opacity = opacityHover; // Hover한 별을 흐리게 처리
	    }
	});
	}
	
	//클릭된 별점을 기준으로 모든 별을 채우는 함수
	function checkedRate() {
		
	let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');
	initStars(); // 별 초기화
	
	checkedRadio.forEach(radio => {
	    let previousSiblings = prevAll(radio);
	    for (let i = 0; i < previousSiblings.length; i++) {
	        previousSiblings[i].querySelector('.star-icon').classList.add('filled');
	    }
	    radio.nextElementSibling.classList.add('filled');
	});
	}
	
	function initStars() {
	stars.forEach(star => {
	    star.classList.remove('filled');
	});
	}
	
	function prevAll(radio) {
	let radioSiblings = [],
	    prevSibling = radio.parentElement.previousElementSibling;
	
	while (prevSibling) {
	    radioSiblings.push(prevSibling);
	    prevSibling = prevSibling.previousElementSibling;
	}
	return radioSiblings;
	}

  </script>
</html>