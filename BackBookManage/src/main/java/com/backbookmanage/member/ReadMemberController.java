package com.backbookmanage.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.backbookmanage.member.DAO.MemberInformationDAO;
import com.backbookmanage.member.DTO.MemberInformationDTO;

/**
 * Servlet implementation class ReadMemberController
 */
@WebServlet("/readMember.do")
public class ReadMemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("readMember.do컨트롤러 실행");
		String member_id = (String) request.getSession().getAttribute("member_id"); // 세션에서 ID 가져오기
        
        if (member_id != null) {
            // DAO와 DTO 사용
            MemberInformationDAO memberDAO = new MemberInformationDAO();
            MemberInformationDTO mDTO = new MemberInformationDTO();
            mDTO.setMember_id(member_id);

            // ID로 회원 정보 검색
            ArrayList<String> memberInfo = memberDAO.memberSelect(member_id);

            if (memberInfo != null && !memberInfo.isEmpty()) {
                request.setAttribute("memberInfo", memberInfo); // JSP에서 사용할 속성 설정
            } else {
                request.setAttribute("error", "회원 정보를 찾을 수 없습니다.");
            }
        } else {
            request.setAttribute("error", "로그인이 필요합니다.");
        }

        // JSP로 포워딩
        // RequestDispatcher dispatcher = request.getRequestDispatcher("/mypage.jsp");
        // dispatcher.forward(request, response);
	}


}
