package com.backbookmanage.member;

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
 * Servlet implementation class chartCotroller
 */
@WebServlet("/chart.do")
public class ChartController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/chart.do 컨트롤러 실행");
		String member_id = String.valueOf(request.getSession().getAttribute("member_id"));
        
        MemberInformationDAO mDAO = new MemberInformationDAO();
        ArrayList<Integer> booksRead = mDAO.member6MonthBoardCount(member_id);
		
        // 데이터를 JSP에 전달
        request.setAttribute("booksRead", booksRead);
    }
}
