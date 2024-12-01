package com.backbookmanage.member;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backbookmanage.member.DAO.MemberInformationDAO;
import com.backbookmanage.member.DTO.MemberInformationDTO;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/memberUpdate.do")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String member_id = request.getParameter("member_id");
		String member_name = request.getParameter("member_name");
		String member_password = request.getParameter("member_password");
		String member_email = request.getParameter("member_email");
		String member_birth = request.getParameter("member_birth");
		String member_gender = request.getParameter("member_gender");
		
		MemberInformationDTO mDto = new MemberInformationDTO();
		System.out.println("memberUpdate.do 컨트롤러 실행");
		
		mDto.setMember_id(member_id);
		mDto.setMember_name(member_name);
	    mDto.setMember_password(member_password);
	    mDto.setMember_email(member_email);
	     //  생년월일 String -> java.sql.Date 타입으로 변환
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date utilDate;
		Date sqlBirth;
		try {
			utilDate = format.parse(member_birth);
			sqlBirth = new Date(utilDate.getTime());
			mDto.setMember_birth(sqlBirth);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		mDto.setIs_manager(false);
		mDto.setMember_gender(member_gender.charAt(0));
		
		MemberInformationDAO mDao = new MemberInformationDAO();
		boolean updateCheck = mDao.memberUpdate(mDto);
		
		ArrayList<String> memberInfo = mDao.memberSelect(member_id);
		
		if (updateCheck) {
			if (memberInfo != null && !memberInfo.isEmpty()) {
                request.setAttribute("memberInfo", memberInfo);
            }
			HttpSession session = request.getSession();
			RequestDispatcher dispatcher = request.getRequestDispatcher("/member/mypage.jsp");
			dispatcher.forward(request, response);
		} else {		
			RequestDispatcher dispatcher = request.getRequestDispatcher("/member/memberUpdate.jsp");
			dispatcher.forward(request, response);
		}
	}

}
