package com.backbookmanage.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class chartCotroller
 */
@WebServlet("/myrecordpage.do")
public class chartCotroller extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("/myrecordpage.do 컨트롤러 실행");
        // 가상 데이터 (목표와 읽은 책 수)
        int totalGoal = 10;  // 이번 달 목표 도서 수
        int booksRead = 5;   // 읽은 도서 수

        // 남은 도서 수 계산
        int booksRemaining = totalGoal - booksRead;

        // 데이터를 JSP에 전달
        request.setAttribute("booksRead", booksRead);
        request.setAttribute("booksRemaining", booksRemaining);
    }
}
