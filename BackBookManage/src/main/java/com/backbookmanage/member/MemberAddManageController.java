package com.backbookmanage.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.sql.Date;

/**
 * Servlet implementation class MemberAddManageController
 */
@WebServlet("/addManage.do")
public class MemberAddManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberAddManageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
String member_id = request.getParameter("member_id"); // 세션에서 ID 가져오기
        
        if (member_id != null) {
            // DAO와 DTO 사용
            MemberDAO memberDAO = new MemberDAO();
            MemberDTO mDTO = new MemberDTO();
            ArrayList<String> memberinfo = memberDAO.memberSelect(member_id);
            //회원 정보 세팅
            mDTO.setMember_id(memberinfo.get(0));
            mDTO.setMember_name(memberinfo.get(1));
            mDTO.setMember_password(memberinfo.get(2));
            mDTO.setMember_email(memberinfo.get(3));
            //String을 Date 타입으로 변환
            String birthString = memberinfo.get(4);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식을 지정 (예: "2024-11-25")
            try {
                java.util.Date utilDate = dateFormat.parse(birthString); // String을 Date로 변환
                java.sql.Date member_birth = new java.sql.Date(utilDate.getTime()); // java.util.Date를 java.sql.Date로 변환
                mDTO.setMember_birth(member_birth); // 변환한 Date 값을 setter에 전달
            } catch (Exception e) {
                e.printStackTrace(); // 예외가 발생하면 출력
            }
            mDTO.setIs_manager(true);
            char gender = memberinfo.get(6).charAt(0);
            mDTO.setMember_gender(gender);

            // ID로 회원 정보 검색
            boolean updateCheck = memberDAO.memberUpdate(mDTO);

            if (updateCheck) {
                request.setAttribute("member_id", member_id);  // id구분을 위한 member_id 반환
            } else {
                System.out.print("회원 권한을 바꿀 수 없습니다");
            }
        } else {
        	System.out.print("로그인이 필요합니다");
        }
        // JSP로 포워딩
        RequestDispatcher dispatcher = request.getRequestDispatcher("/adminpage.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
