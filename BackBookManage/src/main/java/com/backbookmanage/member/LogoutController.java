package com.backbookmanage.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout.do")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 현재 세션을 무효화
        HttpSession session = request.getSession(false); // 기존 세션을 가져옴
        if (session != null) {
            session.invalidate();  // 세션 종료
        }

        // 로그아웃 후 로그인 페이지로 리다이렉트
        response.sendRedirect("index.jsp");
    }
}
