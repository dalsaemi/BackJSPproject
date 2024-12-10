package com.backbookmanage.bookBoard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;

/**
 * Servlet implementation class BoardDeleteController
 */
@WebServlet("/boardDelete.do")
public class BoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardId = request.getParameter("boardId");
        response.setContentType("text/plain; charset=UTF-8");
        
        BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
        boolean deleteCheck = bDAO.boardDelete(boardId);
		
		try (PrintWriter out = response.getWriter()) {
            if (deleteCheck) {
                out.print("게시물이 성공적으로 삭제되었습니다.");
            } else {
                out.print("삭제할 게시물을 찾을 수 없습니다.");
            }
        }
	}

}
