package com.backbookmanage.bookBoard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;

/**
 * Servlet implementation class AVGRatingController
 */
@WebServlet("/avgRating.do")
public class AVGRatingController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String isbn = request.getParameter("isbn");
		BookBoardInformationDAO boardinfo = new BookBoardInformationDAO();
		float avgRate = boardinfo.avgBoardRating(isbn);
		request.setAttribute("avgRate", avgRate);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */

}
