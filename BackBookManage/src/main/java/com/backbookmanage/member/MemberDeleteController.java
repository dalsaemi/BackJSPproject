package com.backbookmanage.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.backbookmanage.member.DAO.MemberInformationDAO;
import com.backbookmanage.member.DTO.MemberInformationDTO;

/**
 * Servlet implementation class MemberDeleteController
 */
@WebServlet("/memberDelete.do")
public class MemberDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("memberDelete.do 컨트롤러 실행");
		String member_id = request.getParameter("member_id");
		String fowardURL = request.getParameter("fowardURL");
        
        if (member_id != null) {
            // DAO와 DTO 사용
            MemberInformationDAO memberDAO = new MemberInformationDAO();
            MemberInformationDTO mDTO = new MemberInformationDTO();
            mDTO.setMember_id(member_id);

            // ID로 회원 정보 검색
            boolean deleteCheck = memberDAO.memberDelete(member_id);

            if (deleteCheck) {
                request.setAttribute("member_id", member_id);  // id구분을 위한 member_id 반환
            } else {
                System.out.println("회원 삭제에 실패했습니다");
            }
        } else {
        	System.out.println("memberDelete.do의 인수값이 잘못 주어졌습니다.");
        }
        
        // JSP로 포워딩
        RequestDispatcher dispatcher;
        if(fowardURL != null && fowardURL != "") {
        	// 현재 세션을 무효화
            HttpSession session = request.getSession(false); // 기존 세션을 가져옴
            if (session != null) {
                session.invalidate();  // 세션 종료
            }
            
            dispatcher = request.getRequestDispatcher(fowardURL);
        }else {
            dispatcher = request.getRequestDispatcher("/member/adminpage.jsp");
        }
        dispatcher.forward(request, response);
	}

}
