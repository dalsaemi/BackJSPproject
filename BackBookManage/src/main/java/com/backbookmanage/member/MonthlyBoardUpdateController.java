package com.backbookmanage.member;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.backbookmanage.member.DAO.MemberInformationDAO;

@WebServlet("/monthlyBoardUpdate.do")
public class MonthlyBoardUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MonthlyBoardUpdateController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 데이터 받기
        String bookGoalParam = request.getParameter("bookGoal");
        String member_id = String.valueOf(request.getSession().getAttribute("member_id"));

        // 데이터 검사, 없으면 그대로 종료
        if (bookGoalParam == null || member_id == null) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"status\":\"fail\", \"message\":\"bookGoal or member_id is missing.\"}");
            out.flush();
            return;
        }

        int bookGoal = Integer.parseInt(bookGoalParam);

        // DB 업데이트
        MemberInformationDAO mDao = new MemberInformationDAO();
        boolean updateCheck = mDao.memberMonthlyBoardUpdate(bookGoal, member_id);

        // 응답할 객체 생성
        response.setContentType("application/json"); //응답 방식 json으로 설정
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        //응답 작성하고 전송
        if (updateCheck) {
            out.print("{\"status\":\"success\", \"message\":\"Book goal updated successfully.\"}");
        } else {
            out.print("{\"status\":\"fail\", \"message\":\"Failed to update book goal.\"}");
        }
        out.flush();
    }
}
