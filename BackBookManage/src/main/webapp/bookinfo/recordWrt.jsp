<!-- 독서 기록 작성 페이지 -->

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

ArrayList<String> memberInfo;
String member_id = "";
String member_name = "";

RequestDispatcher dispatcher = request.getRequestDispatcher("/readMember.do");
dispatcher.include(request, response);

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bookinfo/recordWrt.css">
  <title>독서 기록 작성</title>
</head>
<body>
<%
if (request.getAttribute("error") != null) {
%>
<p> 로그인을 해주세요 </p>
<button onclick="history.back()">뒤로가기</button>
<%	
} else {
	memberInfo = (ArrayList<String>) request.getAttribute("memberInfo");
	if (memberInfo == null) {
	    memberInfo = new ArrayList<>();
	}
	member_id = memberInfo.get(0);
	member_name = memberInfo.get(1);

%>
  <div class="container">
    <h1>독서 기록 작성</h1>
    <form action="<%=request.getContextPath()%>/boardAdd.do" method="post" onsubmit="return radioCheck()">
      <image src="<%=request.getParameter("book_cover")%>">
      <h3>책 제목 : <%=request.getParameter("book_title")%></h3>
      <!-- 제목 -->
      <label for="title">제목</label>
      <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>
      <br>

      <!-- 작성자 -->
      <label for="author">작성자</label>
      <input type="text" id="author" name="author" value=<%=member_name%> readonly>
      <input type="hidden" name="member_id" value=<%=member_id %>>
      <br>

      <!-- ISBN (수정 불가능) -->
      <label for="isbn">ISBN</label>
      <input type="text" id="isbn" name="isbn" class="readonly-field" value="<%=request.getParameter("book_isbn")%>" readonly>
      <br>

      <!-- 본문 -->
      <label for="content">본문</label>
      <textarea id="content" name="content" placeholder="내용을 입력하세요" required></textarea>
      <br>

      <!-- 별점 표시 -->
		<label for="file">책 평점</label>
		<div class="rating">
		    <label class="rating__label rating__label--half" for="starhalf">
		        <input type="radio" id="starhalf" class="rating__input" name="rating" value="0.5">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star1">
		        <input type="radio" id="star1" class="rating__input" name="rating" value="1">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star1half">
		        <input type="radio" id="star1half" class="rating__input" name="rating" value="1.5">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star2">
		        <input type="radio" id="star2" class="rating__input" name="rating" value="2">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star2half">
		        <input type="radio" id="star2half" class="rating__input" name="rating" value="2.5">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star3">
		        <input type="radio" id="star3" class="rating__input" name="rating" value="3">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star3half">
		        <input type="radio" id="star3half" class="rating__input" name="rating" value="3.5">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star4">
		        <input type="radio" id="star4" class="rating__input" name="rating" value="4">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--half" for="star4half">
		        <input type="radio" id="star4half" class="rating__input" name="rating" value="4.5">
		        <span class="star-icon"></span>
		    </label>
		    <label class="rating__label rating__label--full" for="star5">
		        <input type="radio" id="star5" class="rating__input" name="rating" value="5">
		        <span class="star-icon"></span>
		    </label>
		</div>
		
		<p>선택한 점수: <span id="scoreDisplay">0.0</span></p>

	     <!-- 버튼 -->
	     <div class="button-container">
	       <button type="submit">작성하기</button>
	     </div>
    </form>
  </div>
 <% } %>
  <!-- 별점기능 구현 -->
  <script type="text/javascript">
  function radioCheck() {
      // 모든 라디오 버튼 선택
      const radios = document.getElementsByName("rating");
      let isChecked = false;

      // 라디오 버튼 중 하나라도 체크되었는지 확인
      for (const radio of radios) {
          if (radio.checked) {
              isChecked = true;
              break;
          }
      }

      // 체크되지 않았을 경우 경고창을 띄우고 제출을 막음
      if (!isChecked) {
          alert("별점을 입력해주세요!");
          return false; // 폼 제출 방지
      }

      // 체크된 경우 폼 제출 허용
      return true;
  }
  
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
</body>
</html>