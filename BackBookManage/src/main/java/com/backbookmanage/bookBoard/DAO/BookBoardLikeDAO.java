package com.backbookmanage.bookBoard.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.backbookmanage.bookBoard.DTO.BookBoardLikeDTO;
import com.backbookmanage.common.JDBCUtil;
import com.backbookmanage.member.DTO.MemberInformationDTO;

public class BookBoardLikeDAO {
	// 좋아요 중복 확인
	public boolean likeCheck(int board_id, String member_id) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isLiked = false;
        try {
        	conn = JDBCUtil.getConnection();
        	String strQuery = "select * from bookboard_like where board_id = ? and member_id = ?";
        	
        	pstmt = conn.prepareStatement(strQuery);
        	pstmt.setInt(1, board_id);
        	pstmt.setString(2, member_id);
        	rs = pstmt.executeQuery();
        	isLiked = rs.next();
        } catch (Exception e) {
        	System.out.println("Exception" + e);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        System.out.println("likeCheck 결과: board_id=" + board_id + ", member_id=" + member_id + ", isLiked=" + isLiked);
        return isLiked;
	}
	// 좋아요 하기
	public boolean likeInsert(BookBoardLikeDTO bDTO) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean insertCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into bookboard_like values(?,?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setInt(1, bDTO.getBoard_id());
            pstmt.setString(2, bDTO.getMember_id());
            
            int count = pstmt.executeUpdate();
            
            if (count == 1) {
            	insertCheck = true;
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return insertCheck;
	}
	// 좋아요 취소
	public boolean likeDelete(BookBoardLikeDTO bDTO) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean deleteCheck = false;
        try {
            conn = JDBCUtil.getConnection();
             String strQuery = "delete from bookboard_like where board_id = ? and member_id = ?";
             pstmt = conn.prepareStatement(strQuery);
             pstmt.setInt(1, bDTO.getBoard_id());
             pstmt.setString(2, bDTO.getMember_id());

             int count = pstmt.executeUpdate();

             if (count == 1) {
                deleteCheck = true;
             }

         } catch (Exception ex) {
             System.out.println("Exception" + ex);
         } finally {
            JDBCUtil.close(rs, pstmt, conn);
         }
         return deleteCheck;
	}
}
