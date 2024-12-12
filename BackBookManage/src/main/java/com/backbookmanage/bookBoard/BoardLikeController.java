package com.backbookmanage.bookBoard;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.backbookmanage.bookBoard.DAO.BookBoardInformationDAO;
import com.backbookmanage.bookBoard.DAO.BookBoardLikeDAO;
import com.backbookmanage.bookBoard.DTO.BookBoardLikeDTO;

/**
 * Servlet implementation class BoardLikeController
 */
@WebServlet("/boardLike.do")
public class BoardLikeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// GET 방식으로 좋아요 상태 확인
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("boardLike.do 컨트롤러 실행");
    	BookBoardLikeDAO lDAO = new BookBoardLikeDAO();
        BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
        
        // 요청 파라미터 가져오기
        String boardIdParam = request.getParameter("board_id");
        String member_id = request.getParameter("member_id");

        System.out.println("boardIdParam: " + boardIdParam + ", member_id: " + member_id);
        JSONObject responseJson = new JSONObject();

        try {
            // 요청 파라미터 검증
            if (boardIdParam == null || member_id == null) {
                responseJson.put("success", false);
                responseJson.put("message", "board_id 또는 member_id가 누락되었습니다.");
            } else {
                int board_id = Integer.parseInt(boardIdParam);

                // 좋아요 상태 확인
                boolean isLiked = lDAO.likeCheck(board_id, member_id);
                
                // 추천 수 가져오기
                int board_recommend = bDAO.getRecommendCount(board_id);

                responseJson.put("success", true);
                responseJson.put("isLiked", isLiked);
                responseJson.put("board_recommend", board_recommend); // 추천 수 추가
                
                request.setAttribute("isLiked", isLiked);
                System.out.println("isLiked: " + isLiked);
            }
        } catch (Exception e) {
            // 에러 발생 시 처리
        	System.out.println("에러 발생");
            responseJson.put("success", false);
            responseJson.put("message", "서버 오류: " + e.getMessage());
            e.printStackTrace();
        }

        // JSON 응답 반환
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(responseJson.toString());
        //System.out.println("컨트롤러 끝 responseJson: " + responseJson.toString());
    }
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BookBoardInformationDAO bDAO = new BookBoardInformationDAO();
		
		BookBoardLikeDTO lDTO = new BookBoardLikeDTO();
		BookBoardLikeDAO lDAO = new BookBoardLikeDAO();
		// 요청 데이터 읽기
        BufferedReader reader = request.getReader();
        StringBuilder requestBody = new StringBuilder();
        String line;

        while ((line = reader.readLine()) != null) {
            requestBody.append(line);
        }
        
     // JSON 데이터 파싱
        JSONObject requestJson = new JSONObject(requestBody.toString());
        int board_id = requestJson.getInt("board_id");
        String member_id = requestJson.getString("member_id");
        boolean isLiked = false;
        boolean success = false;
        
        lDTO.setBoard_id(board_id);
        lDTO.setMember_id(member_id);

        // member_id가 "none"이면 처리하지 않음
        if (member_id == null || member_id.equals("none")) {
            JSONObject responseJson = new JSONObject();
            responseJson.put("success", false);
            responseJson.put("message", "로그인 후 좋아요를 눌러주세요.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(responseJson.toString());
            return; // 처리 종료
        } 
        
    	isLiked = lDAO.likeCheck(board_id, member_id);
    	bDAO.likeCalc(isLiked, board_id);
    	if (!isLiked) {
    		success = lDAO.likeInsert(lDTO);
    	} else {
    		success = lDAO.likeDelete(lDTO);
    	}     
        
        // board_recommend 값 업데이트
        int updatedRecommend = bDAO.getRecommendCount(board_id);

        // JSON 응답 생성
        JSONObject responseJson = new JSONObject();
        responseJson.put("success", success);
        responseJson.put("isLiked", !isLiked);
        responseJson.put("board_recommend", updatedRecommend);  // 변경된 추천 수 추가

        // 응답 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.out.println(responseJson.toString());
        response.getWriter().write(responseJson.toString());
        
        
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/bookinfo/recordViewer.jsp");
//        dispatcher.forward(request, response);
	}

}
