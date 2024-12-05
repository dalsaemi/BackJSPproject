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
 * Servlet implementation class BoardSimpleShowController
 */
@WebServlet("/boardSimpleShow.do")
public class BoardSimpleShowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardSimpleShowController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		System.out.println("/boardSimpleShow.do컨트롤러 실행");
		
		int myBoard = Integer.parseInt(String.valueOf(request.getAttribute("myBoard")));
		System.out.println("myBoard : "+myBoard);
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		ArrayList<String> boardInfo = bDAO.boardSimpleShow(myBoard);
		if (boardInfo == null) {
			boardInfo = new ArrayList<>();
			System.out.println("게시글 미리보기 정보를 찾을 수 없습니다.");
		}
		request.setAttribute("boardInfo", boardInfo);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
