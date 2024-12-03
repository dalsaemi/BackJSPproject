package com.backbookmanage.bookBoard.DTO;
import java.sql.Clob;

public class BookBoardInformationDTO {
	private int board_id;
	private String member_id;
	private String isbn;
	private float board_rating;
	private int board_recommend;
	private String board_contents;
	private String board_title;
	
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public float getBoard_rating() {
		return board_rating;
	}
	public void setBoard_rating(float board_rating) {
		this.board_rating = board_rating;
	}
	public int getBoard_recommend() {
		return board_recommend;
	}
	public void setBoard_recommend(int board_recommend) {
		this.board_recommend = board_recommend;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
}
