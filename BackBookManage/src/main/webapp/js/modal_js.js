
const modalOpenButtons = document.getElementsByClassName('modalOpenButton');
const modalCloseButton = document.getElementById('modalCloseButton');
const modalContainer = document.getElementById('modalContainer');

// 모달 열기 이벤트
Array.from(modalOpenButtons).forEach(button => {
  button.addEventListener('click', () => {
    const id = button.getAttribute('data-id');  // 태그의 `data-id` 속성 값을 가져오기
    console.log('모달 열기 버튼 클릭:', id); 
	
	// 서버로 데이터 요청
    fetch(`/BackBookManage/bookSelect.do?id=${id}&command=modal`)
      .then(response => response.text()) // 응답 데이터를 텍스트로 변환
      .then(html => {
        const parser = new DOMParser(); // DOMParser를 사용하여 텍스트 데이터를 HTML로 변환
        const doc = parser.parseFromString(html, 'text/html'); // HTML 파싱
        const modalContent = doc.querySelector('#modalContent'); // 파싱된 HTML에서 #modalContent를 찾음

        if (modalContent) {
          console.log('모달 콘텐츠 렌더링 성공'); 
          modalContainer.innerHTML = ''; // 기존 모달 컨테이너 내용을 초기화
          modalContainer.appendChild(modalContent); // 찾은 #modalContent를 모달 컨테이너에 추가
		  console.log(modalContainer.innerHTML);
          modalContainer.classList.add('active'); // 모달 컨테이너에 활성화 클래스 추가 -> css에서 display: none에서 display: flex로 변경
        } else {
          console.error('모달 콘텐츠 렌더링 실패');
        }
      })
      .catch(error => console.error('모달 로딩 실패:', error));
  });
});

// 닫기 버튼 이벤트
modalContainer.addEventListener('click', (event) => {
	console.log('클릭한 요소:', event.target);
	if (event.target && event.target.id === 'modalCloseButton') { // 클릭된 요소가 닫기 버튼이면
		console.log('닫기 버튼 클릭!');
	modalContainer.classList.remove('active'); // 모달 컨테이너에서 활성화 클래스 제거 -> display: flex에서 display: none으로 변경
  }
});