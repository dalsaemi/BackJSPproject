package com.backbookmanage.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.member.DAO.MemberInformationDAO;

/**
 * Servlet implementation class MemberListShowController
 */
@WebServlet("/listShow.do")
public class MemberListShowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberListShowController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		MemberInformationDAO memberDAO = new MemberInformationDAO();
		ArrayList<String> members = memberDAO.memberIdList();
		if (members == null) {
		    members = new ArrayList<>();
		}
		request.setAttribute("members", members);
		//response.sendRedirect(request.getContextPath() + "/listShow.do");
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/adminpage.jsp");
		//dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
