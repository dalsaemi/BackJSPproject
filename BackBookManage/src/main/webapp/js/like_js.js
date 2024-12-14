document.addEventListener("DOMContentLoaded", () => {
    const likeButton = document.getElementById("likeButton");
    const likesSpan = document.getElementById("likes");

    if (!likeButton || !likesSpan) {
        console.error("likeButton 또는 likesSpan 요소를 찾을 수 없습니다.");
        return;
    }
	// 좋아요 버튼의 데이터 속성에서 게시판 ID와 회원 ID를 가져오기
    const board_id_str = likeButton.getAttribute('data-board-id');
    const member_id = likeButton.getAttribute('data-member-id');
    const board_id = parseInt(board_id_str);

    if (!board_id || !member_id) {
        console.error("board_id 또는 member_id가 누락되었습니다.");
        return;
    }

    // 서버에 좋아요 상태 확인 요청
    fetch(`/BackBookManage/boardLike.do?board_id=${board_id}&member_id=${member_id}`)
        .then((response) => {
			console.log('json 실행');
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json(); // JSON 데이터를 반환
        })
        .then((data) => {
            if (data.success) {
                // 서버로부터 받은 좋아요 상태
                const isLiked = data.isLiked;

                // 버튼 상태 업데이트
                if (isLiked) {
                    likeButton.classList.add("liked");
                } else {
                    likeButton.classList.remove("liked");
                }
				console.log("서버에서 받은 데이터:", data);
                // 가져온 추천 수 표시
                likesSpan.textContent = data.board_recommend;
            } else {
                console.error("서버에서 실패 응답:", data.message);
            }
        })
        .catch((error) => {
            console.error("좋아요 상태 확인 중 오류:", error);
        });
});

const likeButton = document.getElementById("likeButton");
const likesSpan = document.getElementById("likes");
// 추천 버튼 이벤트 리스너
likeButton.addEventListener("click", function () {
	// 게시판 번호와 좋아요 누른 회원 ID를 가져오기
    const board_id_str = likeButton.getAttribute('data-board-id');
    const member_id = likeButton.getAttribute('data-member-id');
    const board_id = parseInt(board_id_str);

    console.log("클릭된 게시물 ID:", board_id);
    console.log("회원 ID:", member_id);

    // 좋아요 상태를 로컬에서 추적
    let isLiked = likeButton.classList.contains("liked");  // "liked" 클래스로 좋아요 상태 확인
    console.log("현재 좋아요 상태:", isLiked);

    if (member_id === "none" || member_id == null) {
        alert("로그인 후 좋아요를 눌러주세요.");
        return;
    }

     // 서버로 좋아요 상태 전송
    fetch("/BackBookManage/boardLike.do", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            board_id: board_id,
            member_id: member_id,
        }), // JSON 데이터로 전송
    })
        .then((response) => { // 서버 응답 상태 확인
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            return response.json(); // JSON 데이터를 반환
        })
        .then((data) => {
            console.log("서버에서 받은 데이터:", data);

            const newIsLiked = data.isLiked;  // 서버에서 받은 새로운 좋아요 상태

            // 추천 수 업데이트
            likesSpan.textContent = data.board_recommend;

            // 좋아요 상태에 맞게 "liked" 클래스 토글
            likeButton.classList.toggle("liked", newIsLiked);
        })
        .catch((error) => {
            console.error("Error:", error);
            alert("서버 요청에 실패했습니다.");
        });
});
