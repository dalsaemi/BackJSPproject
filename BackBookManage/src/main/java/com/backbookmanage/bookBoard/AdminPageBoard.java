package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO;

/**
 * Servlet implementation class AdminPageBoard
 */
@WebServlet("/adminBoard.do")
public class AdminPageBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		ArrayList<BookBoardInformationDTO> allBoards = new ArrayList<BookBoardInformationDTO>();
		
		allBoards = bDAO.selectAllBoard();
		
		request.setAttribute("allBoards", allBoards);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/adminpage_board.jsp");
		dispatcher.forward(request, response);
	}
}
