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

import com.lec.soundbooker.dto.FreeBoardCommentDto;
import com.lec.soundbooker.dto.FreeBoardDto;
import com.lec.soundbooker.dto.UploadBoardCommentDto;
import com.lec.soundbooker.dto.UploadBoardDto;

public class FreeBoardDao {
	public static final int FAIL = 0;
	public static final int SUCCESS = 1;
	private static FreeBoardDao instance = new FreeBoardDao();
	public	static FreeBoardDao getInstance() {
		return instance;
	};
	private FreeBoardDao() {}
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
	// (1-1) 글의 댓글 갯수
	public int getFreeCommentTotCnt(int fnum) {
		int totCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM FREEBOARD_COMMENT WHERE FNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
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
	//(1-2) 글 목록(startRow ~ endRow)
	public ArrayList<FreeBoardDto> getFreeBoardlist(int startRow, int endRow){
		ArrayList<FreeBoardDto> dtos = new ArrayList<FreeBoardDto>();
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT V.*, " + 
				"  (SELECT MNAME FROM MEMBER WHERE V.mID=mID) MNAME," + 
				"  (SELECT RNAME FROM RECTEAM WHERE V.rID=rID) RNAME" + 
				"  FROM (SELECT ROWNUM RN, B.* " + 
				"        FROM (SELECT * FROM FREEBOARD ORDER BY fRDATE DESC) B) V" + 
				"  WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int 	fnum		= rs.getInt("fnum");
				String 	mid			= rs.getString("mid");
				String 	rid			= rs.getString("rid");
				String 	ftitle		= rs.getString("ftitle");
				String	fcontent	= rs.getString("fcontent");
				Date	frdate		= rs.getDate("frdate");
				String	fip			= rs.getString("fip");
				int		fbCommentCnt = getFreeCommentTotCnt(fnum);
				dtos.add(new FreeBoardDto(fnum, mid, rid, ftitle, fcontent, frdate, fip, fbCommentCnt));
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
	public int getFreeBoardTotCnt() {
		int totCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM FREEBOARD";
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
	public int freeBoardWrite(String mid, String rid, String ftitle, String fcontent, String fip) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fIP)" + 
				"VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, rid);
			pstmt.setString(3, ftitle);
			pstmt.setString(4, fcontent);
			pstmt.setString(5, fip);
			pstmt.executeUpdate();
			result = SUCCESS;
			System.out.println("자유게시판 원글쓰기 성공");
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "자유게시판 원글쓰기 실패");
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
	//(4) 글 번호(fNUM)로 글전체 내용(FreeBoardDto) 가져오기
	public FreeBoardDto freeBoardContent(int fnum) {
		FreeBoardDto dto = null;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT V.*, " + 
				"  (SELECT mID FROM MEMBER WHERE V.mID=mID) mID," + 
				"  (SELECT rID FROM RECTEAM WHERE V.rID=rID) rID" + 
				"  FROM (SELECT * FROM FREEBOARD ORDER BY fRDATE DESC) V" + 
				"  WHERE fNUM=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String 	mid			= rs.getString("mid");
				String 	rid			= rs.getString("rid");
				String 	ftitle		= rs.getString("ftitle");
				String	fcontent	= rs.getString("fcontent");
				Date	frdate		= rs.getDate("frdate");
				String	fip			= rs.getString("fip");
				dto = new FreeBoardDto(fnum, mid, rid, ftitle, fcontent, frdate, fip);
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
	//(5) 글 수정하기(fnum, ftitle, fcontent, fip 수정)
	public int modify(int fnum, String ftitle, String fcontent, String fip) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "UPDATE FREEBOARD SET fTITLE     = ?," + 
				"                     	   fCONTENT   = ?," + 
				"                     	   fIP        = ?" + 
				"            WHERE fNUM = ?";
		try {
			conn  = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ftitle);
			pstmt.setString(2, fcontent);
			pstmt.setString(3, fip);
			pstmt.setInt(4, fnum);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 수정 성공" : "글번호(fnum) 오류");
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
	//(6-1) 글 삭제하기 (fnum으로 댓글 삭제)
	private void deleteFreeComment(int fnum) {
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM FREEBOARD_COMMENT WHERE fNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e.getMessage() + "댓글 삭제 실패");
		} finally {
			try {
				if(pstmt!= null) pstmt.close();
				if(conn	!= null) conn.close();
			}catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	//(6-2) 글 삭제하기(fnum로)
	public int delete(int fnum) {
		int result = FAIL;
		deleteFreeComment(fnum);
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM FREEBOARD WHERE fNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
			result = pstmt.executeUpdate();
			System.out.println(result == SUCCESS ? "글 삭제 성공" : "글번호(fnum) 오류");
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

	// (7) 특정에 댓글 달기
	public int freeCommentWrite(String mid, String rid, String frcontent, String frip, int fnum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT," + 
				"             frIP,fNUM)" + 
				"    VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_COMMENT), ?, ?, ?," + 
				"             ?,?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, rid);
			pstmt.setString(3, frcontent);
			pstmt.setString(4, frip);
			pstmt.setInt(5, fnum);
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
	// (8) 특정글의 댓글 fnum으로 가져오기
	public ArrayList<FreeBoardCommentDto> getFreeCommentlist(int fnum){
		ArrayList<FreeBoardCommentDto> dtos = new ArrayList<FreeBoardCommentDto>();
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT * FROM FREEBOARD_COMMENT WHERE FNUM = ? ORDER BY frRDATE DESC";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int		frnum		= rs.getInt("frnum");
				String 	mid			= rs.getString("mid");
				String 	rid			= rs.getString("rid");
				String	frcontent	= rs.getString("frcontent");
				Date	frrdate		= rs.getDate("frrdate");
				String	frip		= rs.getString("frip");
				dtos.add(new FreeBoardCommentDto(frnum, mid, rid, frcontent, frrdate, frip, fnum));
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
	// (9) 댓글 수정
	public int freeCommentModify(String frcontent, int fnum, int frnum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "UPDATE FREEBOARD_COMMENT SET FRCONTENT = ?" + 
				"        WHERE FNUM=? AND FRNUM=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, frcontent);
			pstmt.setInt(2, fnum);
			pstmt.setInt(3, frnum);
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
	
	// (10) 댓글 삭제
	public int freeCommentDelete(int fnum, int frnum) {
		int result = FAIL;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		String sql = "DELETE FROM FREEBOARD_COMMENT WHERE FNUM = ? AND FRNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fnum);
			pstmt.setInt(2, frnum);
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
}
