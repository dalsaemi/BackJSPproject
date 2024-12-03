package com.backbookmanage.bookBaord;

import java.io.IOException;
import java.sql.Clob;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO;
import com.backbookmanage.member.DAO.MemberInformationDAO;

/**
 * Servlet implementation class BoardAddController
 */
@WebServlet("/boardAdd.do")
public class BoardAddController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardAddController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		System.out.println("/boardAdd.do컨트롤러 실행");
		
		String member_id = request.getParameter("member_id");
		String isbn = request.getParameter("isbn");
		float board_rating = Float.parseFloat(request.getParameter("rating"));
		int board_recommend = 0;
		String board_contents = request.getParameter("content");
		String board_title = request.getParameter("isbn");
		
		BookBoardInformationDTO bDTO = new BookBoardInformationDTO();
		bDTO.setMember_id(member_id);
		bDTO.setIsbn(isbn);
		bDTO.setBoard_rating(board_rating);
		bDTO.setBoard_recommend(board_recommend);
		bDTO.setBoard_contents(board_contents);
		bDTO.setBoard_title(board_title);
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		boolean insertCheck = bDAO.boardInsert(bDTO);
		
		if (insertCheck) {
			System.out.println("게시글 등록 성공");
			//페이지 포워딩
			RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/recordViewer.jsp");
	        dispatcher.forward(request, response);
		} else {
			System.out.println("게시글 등록 실패");
		}
	}

}
