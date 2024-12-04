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
import com.backbookmanage.common.JDBCUtil;

/**
 * Servlet implementation class BoardInfoSearchController
 */
@WebServlet("/boardInfoSearch.do")
public class BoardInfoSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardInfoSearchController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		System.out.println("/boardInfoSearch.do컨트롤러 실행");
		
		String board_id_s = String.valueOf(request.getAttribute("board_id"));
		//System.out.println("board_id_s :"+board_id_s);
		int board_id = 0;
		try{
			board_id = Integer.parseInt(board_id_s);
			//System.out.println("board_id :"+board_id);
			
			BookBoardInformationDTO bDTO = new BookBoardInformationDTO();
			BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
			bDTO = bDAO.boardSearch(board_id);
			
			request.setAttribute("bDTO", bDTO);
		}catch(Exception e) {
			System.out.println("/boardInfoSearch.do컨트롤러 오류");
			System.out.println(e);
		}
		//페이지 포워딩
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/recordViewer.jsp");
        //dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
