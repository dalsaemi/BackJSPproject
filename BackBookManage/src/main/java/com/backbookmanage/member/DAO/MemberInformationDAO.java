package com.backbookmanage.member.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Date;

import com.backbookmanage.common.JDBCUtil;
import com.backbookmanage.member.DTO.MemberInformationDTO;

public class MemberInformationDAO {
	
	//멤버 로그인 확인
	public boolean memberLoginCheck(String getMember_id, String password) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select member_id, member_password from member_information where member_id = ? and member_password = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, getMember_id);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return loginCon;
	}
	
	//관리자 확인
	public boolean isManager(String getMember_id) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean is_manager = false;
        System.out.println("is_manager 구하기"); //확인용 로그
        try {
			conn = JDBCUtil.getConnection();
            String strQuery = "select is_manager from member_information where member_id = ?";

            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, getMember_id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
            	is_manager = rs.getBoolean("is_manager");
            }
            
            //-----확인용 로그-----
            /*
            if(is_manager) {
            	System.out.println("is_manager : true");
            }
            else {
            	System.out.println("is_manager : false");
            }
            */
            //------------------
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        
        return is_manager;
	}
	
	//멤버 추가 (회원가입)
    public boolean memberInsert(MemberInformationDTO mDTO) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean insertCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into member_information values(?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, mDTO.getMember_id());
            pstmt.setString(2, mDTO.getMember_name());
            pstmt.setString(3, mDTO.getMember_password());
            pstmt.setString(4, mDTO.getMember_email());
            pstmt.setDate(5, mDTO.getMember_birth());
            pstmt.setBoolean(6, mDTO.isIs_manager());
            pstmt.setString(7, Character.toString(mDTO.getMember_gender()));

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
    
    //멤버 삭제
    public boolean memberDelete(String member_id) {
       Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean deleteCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
        	int count = 0;
        	
        	// 외래 키 체크 활성화
        	String query3 = "set foreign_key_checks = 1;";
        	pstmt = conn.prepareStatement(query3);
        	pstmt.executeUpdate();

        	// 삭제 쿼리 실행
        	String query2 = "delete from member_information where member_id = ?";
        	pstmt = conn.prepareStatement(query2);
        	pstmt.setString(1, member_id);
        	count = pstmt.executeUpdate();

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
    
    //멤버 정보 수정
    public boolean memberUpdate(MemberInformationDTO mDTO) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean updateCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "update member_information set member_name=?, member_password=?, member_email=?, member_birth=?, is_manager=?, member_gender=? where member_id = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, mDTO.getMember_name());
            pstmt.setString(2, mDTO.getMember_password());
            pstmt.setString(3, mDTO.getMember_email());
            pstmt.setDate(4, mDTO.getMember_birth());
            pstmt.setBoolean(5, mDTO.isIs_manager());
            pstmt.setString(6, String.valueOf(mDTO.getMember_gender()));
            pstmt.setString(7, mDTO.getMember_id());
            
            //확인용 로그
            //System.out.println(mDTO.getMember_gender());
            //System.out.print(pstmt);

            int count = pstmt.executeUpdate();

            if (count == 1) {
            	updateCheck = true;
            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        return updateCheck;
    }
    
    //멤버 정보 보기
    public ArrayList<String> memberSelect(String member_id) {
       Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> info = new ArrayList<>();
        try {
           conn = JDBCUtil.getConnection();
           String strQuery = "select * from member_information where member_id = ?";
           pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
	            info.add(rs.getString("member_id"));
	            info.add(rs.getString("member_name"));
	            info.add(rs.getString("member_password"));
	            info.add(rs.getString("member_email"));
	            info.add(rs.getString("member_birth"));
	            info.add(rs.getString("is_manager"));
	            info.add(rs.getString("member_gender"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
           JDBCUtil.close(rs, pstmt, conn);
        }
        
        return info;
    }
    
    //멤버 목록 보기
    public ArrayList<String> memberIdList() {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<String> members = new ArrayList<>();
        try {
        	conn = JDBCUtil.getConnection();
        	String strQuery = "select member_id from member_information";
        	pstmt = conn.prepareStatement(strQuery);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	members.add(rs.getString("member_id"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        
        return members;
    }
    
    //멤버 한 달간 게시글 갯수 받기
    public int memberMonthlyBoard(String member_id) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int boardcount = 0;
        try {
        	conn = JDBCUtil.getConnection();
        	String strQuery = "select count(*) as MBcount from bookboard_information where member_id = ? and board_date >= curdate() - interval 1 month and board_date < curdate() + interval 1 day";
        	pstmt = conn.prepareStatement(strQuery);
        	pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	boardcount = Integer.parseInt(rs.getString("MBcount"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        
        return boardcount;
    }
    
    //멤버 최근 게시글 id 받기
    public int memberRecentBoard(String member_id) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int board_id = 0;
        try {
        	conn = JDBCUtil.getConnection();
        	String strQuery = "select board_id from bookboard_information where board_date = (select max(board_date) from bookboard_information where member_id = ?) limit 1";
        	pstmt = conn.prepareStatement(strQuery);
        	pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	board_id = Integer.parseInt(rs.getString("MBcount"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        
        return board_id;
    }
    
    //멤버 한 달간 목표 추가
    public boolean memberMonthlyBoardInsert(String member_id) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean insertCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "insert into member_goal values(?,10)";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, member_id);

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
    
    //멤버 한 달간 목표 얻기
    public int memberMonthlyBoardGet(String member_id) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int MonthlyGoal = 0;
        try {
        	conn = JDBCUtil.getConnection();
        	String strQuery = "select member_monthly_board from member_goal where member_id = ?";
        	pstmt = conn.prepareStatement(strQuery);
        	pstmt.setString(1, member_id);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
            	MonthlyGoal = Integer.parseInt(rs.getString("member_monthly_board"));
            }
        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
    	
    	return MonthlyGoal;
    }
    
    //멤버 한 달간 목표 업데이트
    public boolean memberMonthlyBoardUpdate(int MonthlyGoal, String member_id) {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean updateCheck = false;
        try {
        	conn = JDBCUtil.getConnection();
            String strQuery = "update member_goal set member_monthly_board = ? where member_id = ?";
            pstmt = conn.prepareStatement(strQuery);
            pstmt.setString(1, String.valueOf(MonthlyGoal));
            pstmt.setString(2, member_id);

            int count = pstmt.executeUpdate();

            if (count == 1) {
            	updateCheck = true;
            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);
        } finally {
        	JDBCUtil.close(rs, pstmt, conn);
        }
        
    	return updateCheck;
    }
}
