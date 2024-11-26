package com.backbookmanage.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
 * Servlet implementation class JoinController
 */
@WebServlet("/register.do")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String member_id = request.getParameter("member_id");
		String member_password = request.getParameter("member_password");
		String member_name = request.getParameter("member_name");
		String member_birth = request.getParameter("member_birth");
		String member_email = request.getParameter("member_email");
		String domain = request.getParameter("domain");
		member_email = member_email + "@" + domain;
		String member_gender = request.getParameter("member_gender");
		
		MemberInformationDTO mDto = new MemberInformationDTO();
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
		
		mDto.setIs_manager(false); // 회원가입할 때는 관리자말고 일반 유저로
		mDto.setMember_gender(member_gender.charAt(0));
		
		MemberInformationDAO mDao = new MemberInformationDAO();
		boolean insertCheck = mDao.memberInsert(mDto);
		
		if (insertCheck) {
			request.setAttribute("joinResult", insertCheck);
			HttpSession session = request.getSession();
			session.setAttribute("idKey", member_id);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("joinResult", 0);			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/Register.jsp");
			dispatcher.forward(request, response);
		}
		
		
	}

}
