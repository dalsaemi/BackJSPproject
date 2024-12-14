package com.backbookmanage.bookBoard.DTO;

public class BookBoardLikeDTO {
	private int board_id; // 게시판 번호
	private String member_id; // 추천 누른 회원의 ID
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}
