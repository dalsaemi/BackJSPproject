package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;

/**
 * Servlet implementation class MyBoardSearchController
 */
@WebServlet("/myBoardSearch.do")
public class MyBoardSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyBoardSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		System.out.println("/myBoardSearch.do컨트롤러 실행");
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		String member_id = (String) request.getSession().getAttribute("member_id");
		ArrayList<Integer> myBoards = bDAO.myBoardSearch(member_id);
		if (myBoards == null) {
			System.out.println("멤버의 게시글 내역을 찾을 수 없습니다.");
			myBoards = new ArrayList<>();
		}
		request.setAttribute("myBoards", myBoards);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
