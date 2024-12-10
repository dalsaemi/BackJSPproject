package com.backbookmanage.bookBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO;

@WebServlet("/boardUpdate.do")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		
		String isbn = request.getParameter("book_isbn");
		String cover = request.getParameter("book_cover");
		String book_title = request.getParameter("book_title");
		String board_title = request.getParameter("title");
		String board_contents = request.getParameter("content");
		float board_rating = Float.parseFloat(request.getParameter("rating"));
		int board_id = Integer.parseInt(request.getParameter("board_id"));
		
		boolean updateCheck = bDAO.boardUpdate(board_title, board_contents, board_rating, board_id);

		if (updateCheck) {
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/recordViewer.jsp?board_id="+ String.valueOf(board_id));
			dispatcher.forward(request, response);
		}
		
		
		
	}

}
