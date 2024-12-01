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
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/recordWrt.css">
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
      
      <!-- 별점 표시 -->
      <label for="file">책 평점</label>
	  <div class="rating">
	      <label class="rating__label rating__label--half" for="starhalf">
	          <input type="radio" id="starhalf" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--full" for="star1">
	          <input type="radio" id="star1" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--half" for="star1half">
	          <input type="radio" id="star1half" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--full" for="star2">
	          <input type="radio" id="star2" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--half" for="star2half">
	          <input type="radio" id="star2half" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--full" for="star3">
	          <input type="radio" id="star3" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--half" for="star3half">
	          <input type="radio" id="star3half" class="rating__input" name="rating" checked>
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--full" for="star4">
	          <input type="radio" id="star4" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--half" for="star4half">
	          <input type="radio" id="star4half" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
	      <label class="rating__label rating__label--full" for="star5">
	          <input type="radio" id="star5" class="rating__input" name="rating" value="">
	          <span class="star-icon"></span>
	      </label>
    </div>

      <!-- 버튼 -->
      <div class="button-container">
        <button type="submit">작성하기</button>
      </div>
    </form>
  </div>
  <!-- 별점기능 구현 -->
  <script type="text/javascript">
  	const rateWrap = document.querySelectorAll('.rating'),
    label = document.querySelectorAll('.rating .rating__label'),
    input = document.querySelectorAll('.rating .rating__input'),
    labelLength = label.length,
    opacityHover = '0.5';
	
	let stars = document.querySelectorAll('.rating .star-icon');
	
	// 초기 상태 확인
	checkedRate();
	
	// 별점 클릭 이벤트 처리
	input.forEach((radio) => {
	    radio.addEventListener('change', () => {
	        checkedRate();
	    });
	});
	
	rateWrap.forEach(wrap => {
	    wrap.addEventListener('mouseenter', () => {
	        stars = wrap.querySelectorAll('.star-icon');
	
	        stars.forEach((starIcon, idx) => {
	            starIcon.addEventListener('mouseenter', () => {
	                initStars(); 
	                filledRate(idx, labelLength); 
	
	                for (let i = 0; i < stars.length; i++) {
	                    if (stars[i].classList.contains('filled')) {
	                        stars[i].style.opacity = opacityHover;
	                    }
	                }
	            });
	
	            starIcon.addEventListener('mouseleave', () => {
	                starIcon.style.opacity = '1';
	                checkedRate(); 
	            });
	
	            wrap.addEventListener('mouseleave', () => {
	                starIcon.style.opacity = '1';
	            });
	        });
	    });
	});
	
	function filledRate(index, length) {
	    if (index <= length) {
	        for (let i = 0; i <= index; i++) {
	            stars[i].classList.add('filled');
	        }
	    }
	}
	
	function checkedRate() {
	    let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');
	
	    initStars();
	    checkedRadio.forEach(radio => {
	        let previousSiblings = prevAll(radio);
	
	        for (let i = 0; i < previousSiblings.length; i++) {
	            previousSiblings[i].querySelector('.star-icon').classList.add('filled');
	        }
	
	        radio.nextElementSibling.classList.add('filled');
	
	        function prevAll(radio) {
	            let radioSiblings = [],
	                prevSibling = radio.parentElement.previousElementSibling;
	
	            while (prevSibling) {
	                radioSiblings.push(prevSibling);
	                prevSibling = prevSibling.previousElementSibling;
	            }
	            return radioSiblings;
	        }
	    });
	}
	
	function initStars() {
	    stars.forEach(star => {
	        star.classList.remove('filled');
	    });
	}
  </script>
</body>
</html>