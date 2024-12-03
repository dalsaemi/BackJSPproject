package com.backbookmanage.bookBoard.DAO;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	//해당 멤버가 쓴 가장 최신 글 id값 찾기 (recordWrt.jsp -> recordViewer.jsp)
	public int boardIdSearch(String member_id) {
		int board_id = 0;
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "select board_id from bookBoard_information where board_date = (select max(board_date) from bookBoard_information) and member_id = ? order by board_id desc limit 1;";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member_id);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	board_id = Integer.parseInt(rs.getString("board_id"));
            }
        } catch (Exception ex) {
        	System.out.println("내 최신글 불러오기 실패");
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
		return board_id; //integer타입으로 id값만 return
	}
	
	//해당 멤버가 쓴 글의 id 리스트 뿌려주기 (getRecord.jsp)
	public ArrayList<Integer> myBoardSearch(String member_id) {
		ArrayList<Integer> myBoardList = new ArrayList<Integer>();
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "select board_id from bookBoard_information where member_id = ? order by board_date desc;";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member_id);
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	myBoardList.add(Integer.parseInt(rs.getString("board_id")));
            }
        } catch (Exception ex) {
        	System.out.println("내 작성글 리스트 불러오기 실패");
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
		return myBoardList; //integer list형식으로 id값만 return
	}
	
	//해당 글의 레코드 표시할 정보만 리스트로 뿌려주기 (getRecord.jsp)
	public ArrayList<String> boardSimpleShow(int board_id) {
		ArrayList<String> boardSList = new ArrayList<String>();
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "select * from bookBoard_information where board_id = ?;";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, Integer.toString(board_id));
            
            /*String member_id="";*/ String board_title=""; /*String board_contents=""; String board_recommend="";*/
            String board_date=""; String isbn=""; String board_rating="";
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	board_title = rs.getString("board_title");
            	//board_contents = rs.getString("board_contents");
            	//board_recommend = rs.getString("board_recommend");
            	board_date = rs.getString("board_date");
            	isbn = rs.getString("isbn");
            	board_rating = rs.getString("board_rating");
            	//member_id = rs.getString("member_id");
            }
            boardSList.add(board_title);
            boardSList.add(board_date);
            boardSList.add(isbn);
            boardSList.add(board_rating);
        } catch (Exception ex) {
        	System.out.println("작성글 간단 정보 불러오기 실패");
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
		return boardSList; //string list 형식으로 return
	}
	
	//해당 글의 모든 information 뿌려주기 (recordViewer.jsp)
	public BookBoardInformationDTO boardSearch(int board_id) {
		BookBoardInformationDTO bDTO = new BookBoardInformationDTO();
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "select * from bookBoard_information where board_id = ?;";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, Integer.toString(board_id));
            
            String member_id=""; String board_title=""; String board_contents=""; String board_recommend="";
            String board_date=""; String isbn=""; String board_rating="";
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	board_title = rs.getString("board_title");
            	board_contents = rs.getString("board_contents");
            	board_recommend = rs.getString("board_recommend");
            	board_date = rs.getString("board_date");
            	isbn = rs.getString("isbn");
            	board_rating = rs.getString("board_rating");
            	member_id = rs.getString("member_id");
            }
            
            bDTO.setBoard_id(board_id);
            bDTO.setBoard_title(board_title);
            bDTO.setBoard_contents(board_contents);
            bDTO.setBoard_recommend(Integer.parseInt(board_recommend));
            bDTO.setBoard_date(null);
            bDTO.setIsbn(isbn);
            bDTO.setBoard_rating(Float.parseFloat(board_rating));
            bDTO.setMember_id(member_id);
        } catch (Exception ex) {
        	System.out.println("작성글 정보 불러오기 실패");
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
		return bDTO; //DTO형식으로 return
	}
}
