package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.member.DAO.MemberInformationDAO;

/**
 * Servlet implementation class RecentBoardSearchController
 */
@WebServlet("/recentBoardSearch.do")
public class RecentBoardSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecentBoardSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("/recentBoardSearch.do컨트롤러 실행");
		
		MemberInformationDAO mDAO = new MemberInformationDAO();
		String member_id = (String) request.getSession().getAttribute("member_id");
		Integer recentBoards = mDAO.memberRecentBoard(member_id);
		if (recentBoards == null) {
			System.out.println("멤버의 최근 게시글 내역을 찾을 수 없습니다.");
			recentBoards = 0;
		}
		request.setAttribute("recentBoards", (int)recentBoards);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
