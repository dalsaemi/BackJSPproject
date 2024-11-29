package com.backbookmanage.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
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
 * Servlet implementation class MemberCheckManagerController
 */
@WebServlet("/checkManager.do")
public class MemberCheckManagerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberCheckManagerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String member_id = (String) request.getAttribute("member_id"); // 세션에서 ID 가져오기
		System.out.println("checkManager.do 컨트롤러 실행");
		
		if (member_id != null) {
			MemberInformationDAO memberDAO = new MemberInformationDAO();
			boolean isManager;
			isManager = memberDAO.isManager(member_id);
			
            request.setAttribute("isManager", isManager);
        } else {
        	System.out.println("checkManager.do 컨트롤러의 Parameter가 없습니다");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
