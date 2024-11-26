package com.backbookmanage.member.DTO;
import java.sql.Date;

public class MemberInformationDTO {
	private String member_id;
    private String member_name;
    private String member_password;
    private String member_email;
    private Date member_birth;
    private boolean is_manager;
    private char member_gender;
    
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_password() {
		return member_password;
	}
	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Date getMember_birth() {
		return member_birth;
	}
	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}
	public boolean isIs_manager() {
		return is_manager;
	}
	public void setIs_manager(boolean is_manager) {
		this.is_manager = is_manager;
	}
	public char getMember_gender() {
		return member_gender;
	}
	public void setMember_gender(char member_gender) {
		this.member_gender = member_gender;
	}
}