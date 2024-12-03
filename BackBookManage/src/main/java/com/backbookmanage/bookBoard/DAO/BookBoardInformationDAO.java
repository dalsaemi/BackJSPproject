package com.backbookmanage.bookBoard.DAO;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.backbookmanage.bookBoard.DTO.BookBoardInformationDTO;
import com.backbookmanage.common.JDBCUtil;

public class BookBoardInformationDAO {
	public boolean boardInsert(BookBoardInformationDTO bDTO) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean insertCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into bookBoard_information(`board_title`,`board_contents`,`board_recommend`,`isbn`,`board_rating`,`member_id`) values(?,?,?,?,?,?);";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, bDTO.getBoard_title());
            pstmt.setString(2, bDTO.getBoard_contents());
            pstmt.setInt(3, bDTO.getBoard_recommend());
            pstmt.setString(4, bDTO.getIsbn());
            pstmt.setFloat(5, bDTO.getBoard_rating());
            pstmt.setString(6, bDTO.getMember_id());

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
}
