package com.lec.soundbooker.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.lec.soundbooker.dto.UploadBoardCommentDto;
import com.lec.soundbooker.dto.UploadBoardDto;

public class UploadBoardDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static UploadBoardDao instance = new UploadBoardDao();
	public	static UploadBoardDao getInstance() {
		return instance;
	};
	private UploadBoardDao() {}
	private Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle11g");
			conn= ds.getConnection();
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	//(1) 글 목록(startRow ~ endRow)
	public ArrayList<UploadBoardDto> getUploadBoardlist(int startRow, int endRow){
		ArrayList<UploadBoardDto> dtos = new ArrayList<UploadBoardDto>();
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT * " + 
				"    FROM (SELECT ROWNUM RN, A.* " + 
				"        FROM (SELECT * " + 
				"            FROM UPLOADBOARD ORDER BY UGROUP DESC, USTEP) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int 	unum		= rs.getInt("unum");
				String 	rid			= rs.getString("rid");
				String 	utitle		= rs.getString("utitle");
				String	ucontent	= rs.getString("ucontent");
				String	ufilename	= rs.getString("ufilename");
				Date	urdate		= rs.getDate("urdate");
				String	uip			= rs.getString("uip");
				int		ugroup		= rs.getInt("ugroup");
				int		ustep		= rs.getInt("ustep");
				int		uindent		= rs.getInt("uindent");
				int		ubCommentCnt	= getUploadCommentTotCnt(unum);
				dtos.add(new UploadBoardDto(unum, rid, utitle, ucontent, ufilename, urdate, uip, ugroup, ustep, uindent, ubCommentCnt ));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	!= null) rs.close();
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
	//(2) 글 갯수
	public int getUploadBoardTotCnt() {
		int totCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM UPLOADBOARD";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	!= null) rs.close();
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	//(3) 글 쓰기(원글쓰기)
	public int uploadWrite(String rid, String utitle, String ucontent, String ufilename, String uip) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME," + 
				"        uIP, uGROUP, uSTEP, uINDENT)" + 
				"VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), ?, ?, ?, ?, " + 
				"        ?, (SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 0, 0)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, utitle);
			pstmt.setString(3, ucontent);
			pstmt.setString(4, ufilename);
			pstmt.setString(5, uip);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("원글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "원글쓰기 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	//(4) 글 번호(unum)로 글전체 내용(BoardDto) 가져오기
	public UploadBoardDto uploadContent(int unum) {
		UploadBoardDto dto = null;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT * FROM UPLOADBOARD WHERE uNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String 	rid			= rs.getString("rid");
				String 	utitle		= rs.getString("utitle");
				String	ucontent	= rs.getString("ucontent");
				String	ufilename	= rs.getString("ufilename");
				Date	urdate		= rs.getDate("urdate");
				String	uip			= rs.getString("uip");
				int		ugroup		= rs.getInt("ugroup");
				int		ustep		= rs.getInt("ustep");
				int		uindent		= rs.getInt("uindent");
				
				dto = new UploadBoardDto(unum, rid, utitle, ucontent, ufilename, urdate, uip, ugroup, ustep, uindent);
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	!= null) rs.close();
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dto;
	}
	//(5) 글 수정하기(uid, utitle, ucontent, ufilename, uip 수정)
	public int modify(int unum, String utitle, String ucontent,String ufilename, String uip) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "UPDATE UPLOADBOARD SET uTITLE     = ?," + 
				"                       uCONTENT   = ?," + 
				"                       uFILENAME  = ?," + 
				"                       uIP        = ?" + 
				"            WHERE uNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, utitle);
			pstmt.setString(2, ucontent);
			pstmt.setString(3, ufilename);
			pstmt.setString(4, uip);
			pstmt.setInt(5, unum);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 수정 성공" : "글번호(unum) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 수정 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	//(6-1) 글 삭제하기 (unum으로 댓글 삭제)
	private void deleteUploadComment(int unum) {
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM UPLOADBOARD_COMMENT WHERE uNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 삭제 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	//(6-2) 글 삭제하기(unum로)
	public int delete(int unum) {
		int result = FAIL;
		deleteUploadComment(unum);
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM UPLOADBOARD WHERE uNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 삭제 성공" : "글번호(unum) 오류");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "글 삭제 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}	
	//(7) 답변글 쓰기 전 단계(원글의 fgroup과 같고, 원글의 fstep보다 크면 fstep을 하나 증가하기)
	private	void preReplyStep(int ugroup, int ustep) {
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "UPDATE UPLOADBOARD SET uSTEP = uSTEP + 1 WHERE uGROUP = ? AND uSTEP > ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ugroup);
			pstmt.setInt(2, ustep);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "preReplyStep에서 오류");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	//(8) 답변글 쓰기
	public int reply(String rid, String utitle, String ucontent, String ufilename, String uip, int ugroup, int ustep, int uindent) {
		int result = FAIL;
		preReplyStep(ugroup, ustep);
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME," + 
				"        uIP, uGROUP, uSTEP, uINDENT)" + 
				"VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), ?, ?, ?, ?, " + 
				"        ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, utitle);
			pstmt.setString(3, ucontent);
			pstmt.setString(4, ufilename);
			pstmt.setString(5, uip);
			pstmt.setInt(6, ugroup);
			pstmt.setInt(7, ustep+1);
			pstmt.setInt(8, uindent+1);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("답변글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "답변글쓰기 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (9) 특정에 댓글 달기
	public int uploadComment(String rid, String urcontent, String urip,int unum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT,urIP,uNUM)" + 
				"VALUES ((SELECT NVL(MAX(urNUM),0)+1 FROM UPLOADBOARD_COMMENT), ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, urcontent);
			pstmt.setString(3, urip);
			pstmt.setInt(4, unum);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("댓글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "댓글쓰기 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (10) 글의 댓글 갯수
	public int getUploadCommentTotCnt(int unum) {
		int totCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM UPLOADBOARD_COMMENT WHERE UNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	!= null) rs.close();
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	
	// (9) 댓글 수정
	public int uploadCommentModify(String urcontent, int unum, int urnum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "UPDATE UPLOADBOARD_COMMENT SET URCONTENT = ?" + 
				"        WHERE UNUM=? AND URNUM=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, urcontent);
			pstmt.setInt(2, unum);
			pstmt.setInt(3, urnum);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("댓글수정 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "댓글수정 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	
	// (10) 댓글 삭제
	public int uploadCommentDelete(int unum, int urnum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM UPLOADBOARD_COMMENT WHERE UNUM = ? AND URNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			pstmt.setInt(2, urnum);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("댓글삭제 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "댓글삭제 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (11) 특정글의 댓글 UNUM으로 가져오기
	public ArrayList<UploadBoardCommentDto> getUploadBoardCommentlist(int unum){
		ArrayList<UploadBoardCommentDto> dtos = new ArrayList<UploadBoardCommentDto>();
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT * FROM UPLOADBOARD_COMMENT WHERE uNUM = ? ORDER BY urRDATE DESC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, unum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int		urnum		= rs.getInt("urnum");
				String 	rid			= rs.getString("rid");
				String	urcontent	= rs.getString("urcontent");
				Date	urrdate		= rs.getDate("urrdate");
				String	urip		= rs.getString("urip");
				dtos.add(new UploadBoardCommentDto(urnum, rid, urcontent, urrdate, urip, unum));
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	!= null) rs.close();
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return dtos;
	}
}
