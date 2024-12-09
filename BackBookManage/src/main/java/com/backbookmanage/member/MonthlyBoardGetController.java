package com.backbookmanage.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.member.DAO.MemberInformationDAO;

/**
 * Servlet implementation class MonthlyBoardGetController
 */
@WebServlet("/monthlyBoardGet.do")
public class MonthlyBoardGetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MonthlyBoardGetController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("/monthlyBoardGet.do 컨트롤러 실행");
		String member_id = String.valueOf(request.getSession().getAttribute("member_id"));
        
        MemberInformationDAO mDAO = new MemberInformationDAO();
        Integer bookGoalWrapper = mDAO.memberMonthlyBoardGet(member_id);
        
        int bookGoal = (bookGoalWrapper != null) ? bookGoalWrapper : 0;
        
        // 데이터를 JSP에 전달
        request.setAttribute("bookGoal", bookGoal);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
