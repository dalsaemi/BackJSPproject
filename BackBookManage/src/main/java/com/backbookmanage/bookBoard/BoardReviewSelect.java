package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO;

@WebServlet("/boardReviewSelect.do")
public class BoardReviewSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isbn = request.getParameter("isbn");
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		ArrayList<BookBoardInformationDTO> listBoard = new ArrayList<BookBoardInformationDTO>();
		listBoard = bDAO.selectBookReview(isbn);
		
//		for(int i = 0; i < listBoard.size(); i++)
//			System.out.println(listBoard.get(i).getBoard_title());
		request.setAttribute("boardSelectResult", listBoard);
	}

}
