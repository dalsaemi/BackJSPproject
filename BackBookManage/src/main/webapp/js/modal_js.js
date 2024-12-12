
const modalOpenButtons = document.getElementsByClassName('modalOpenButton');
const modalCloseButton = document.getElementById('modalCloseButton');
const modalContainer = document.getElementById('modalContainer');

// 모달 열기 이벤트
Array.from(modalOpenButtons).forEach(button => {
  button.addEventListener('click', () => {
    const id = button.getAttribute('data-id');
    console.log('모달 열기 버튼 클릭:', id);

    fetch(`/BackBookManage/bookSelect.do?id=${id}&command=modal`)
      .then(response => response.text())
      .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        const modalContent = doc.querySelector('#modalContent');

        if (modalContent) {
          console.log('모달 콘텐츠 렌더링 성공');
          modalContainer.innerHTML = ''; // 기존 내용 삭제
          modalContainer.appendChild(modalContent);
		  console.log(modalContainer.innerHTML);
          modalContainer.classList.add('active');
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
	if (event.target && event.target.id === 'modalCloseButton') {
		console.log('닫기 버튼 클릭!');
	modalContainer.classList.remove('active');
  }
});