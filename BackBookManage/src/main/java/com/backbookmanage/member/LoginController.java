package com.backbookmanage.member;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.member.DAO.MemberInformationDAO;
import com.backbookmanage.member.DTO.MemberInformationDTO;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 로그인 요청 처리
        request.setCharacterEncoding("UTF-8");

        // 사용자가 입력한 아이디와 비밀번호
        String member_id = request.getParameter("member_id");
        String member_password = request.getParameter("member_password");

        // DTO 객체 생성
        MemberInformationDTO mDto = new MemberInformationDTO(); // 기본 생성자 사용

        // set 메서드를 사용하여 값을 설정
        mDto.setMember_id(member_id);
        mDto.setMember_password(member_password);

        // DAO 객체 생성하여 로그인 검증
        MemberInformationDAO mDao = new MemberInformationDAO();
        boolean loginCheck = mDao.memberLoginCheck(mDto.getMember_id(), mDto.getMember_password());
        boolean is_manager = mDao.isAdmin(mDto.getMember_id());

        if (loginCheck) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            request.getSession().setAttribute("member_id", mDto.getMember_id());
            request.getSession().setAttribute("is_manager", is_manager);

            // 로그인 성공 후 메인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // 로그인 실패 시 에러 페이지로 리다이렉트
        	response.sendRedirect(request.getContextPath() + "/member/LogError.jsp");
        }
    }
}

