package com.backbookmanage.member;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class MonthlyBoardUpdateController
 */
@WebServlet("/monthlyBoardUpdate.do")
public class MonthlyBoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MonthlyBoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("monthlyBoardUpdate.do 컨트롤러 실행");
		String member_id = String.valueOf(request.getSession().getAttribute("member_id"));
		System.out.println("member_id : "+member_id);
		int bookGoal = Integer.parseInt(String.valueOf(request.getParameter("bookGoal")));
		System.out.println("bookGoal : "+bookGoal);
		
		MemberInformationDAO mDao = new MemberInformationDAO();
		boolean updateCheck = mDao.memberMonthlyBoardUpdate(bookGoal, member_id);
		
		if (updateCheck) {
			System.out.println("monthlyBoard 업데이트 완료");
		} else {		
			System.out.println("monthlyBoard 업데이트에 실패했습니다");
		}
		response.sendRedirect(request.getContextPath() + "/member/myrecordpage.jsp");
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/member/myrecordpage.jsp");
        //dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
