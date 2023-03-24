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

import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dto.ProjectDto;
import com.lec.soundbooker.dto.RecTeamDto;

public class RecTeamDao {
	public static final int LOGIN_FAIL = 0;
	public static final int LOGIN_SUCCESS = 1;
	public static final int EXIST = 0;
	public static final int NOTEXIST = 1;
	public static final int FAIL = 0;
	private static RecTeamDao instance = new RecTeamDao();
	public	static RecTeamDao getInstance() {
		return instance;
	};
	private RecTeamDao() {}
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
	//--------------------------공통---------------------------------
	// (1) 로그인
	public int loginCheck(String rid, String rpw) {
		int result = LOGIN_FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM RECTEAM WHERE rID=? and rPW=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, rpw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = LOGIN_SUCCESS;
			}else {
				result = LOGIN_FAIL;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (2) rID로 dto가져오기(로그인 성공시 session에 넣기 위함)
	public RecTeamDto getRteam(String rid) {
		RecTeamDto recTeam = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM RECTEAM WHERE rId=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String	rpw      =rs.getString("rpw");     
				String	rname    =rs.getString("rname");   
				String	rjob   	 =rs.getString("rjob");  
				int		pnum     =rs.getInt("pnum");    
				recTeam = new RecTeamDto(rid, rpw, rname, rjob, pnum);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return recTeam;
	}	
	//-------------------------프로젝트 관리자--------------------------
	// (1) 작업자 id 중복 체크 
	public int ridConfirm(String rid, String rname) {
		int result = EXIST;
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		=null;
		String sql = "SELECT * FROM RECTEAM WHERE rID=? AND RNAME=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			pstmt.setString(2, rname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXIST;
			}else {
				result = NOTEXIST;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(rs	 !=	null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (2) 작업자 등록 & 작업자 정보 수정
	public int join_modifyRecTeam(String rpw, String rname, String rid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE RECTEAM " + 
				"    SET RPW       = ?," + 
				"        RNAME     = ?" + 
				"    WHERE RID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rpw);
			pstmt.setString(2, rname);
			pstmt.setString(3, rid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	
	// (3-1) 작업자 삭제 (업데이트 게시판)
	private void deleteRecTeamStep1(String rid) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE UPLOADBOARD SET RID = '없는 회원'" + 
				"    WHERE rID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}		
	// (3-2) 작업자 삭제 (업데이트_댓글 )
	private void deleteRecTeamStep2(String rid) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE UPLOADBOARD_REPLY SET RID = '없는 회원'" + 
				"    WHERE rID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}		
	// (3-3) 작업자 삭제 (자유게시판 )
	private void deleteRecTeamStep3(String rid) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE FREEBOARD SET RID = '없는 회원'" + 
				"    WHERE rID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}		
	// (3-4) 작업자 삭제 (자유게시판-댓글 )
	private int deleteRecTeamStep4(String rid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE FREEBOARD_REPLY SET RID = '없는 회원'" + 
				"    WHERE rID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	} 
	// (3-5) 작업자 삭제
	public int opWithdrawal(String rid) {
		int result = FAIL;
		deleteRecTeamStep1(rid);
		deleteRecTeamStep2(rid);
		deleteRecTeamStep3(rid);
		deleteRecTeamStep4(rid);
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE RECTEAM " + 
				"    SET RPW       = '0'," + 
				"        RNAME     = '0'" + 
				"    WHERE RID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}	

	// (4-1) 프로젝트 없는 녹음 작업자 전체 수
	public int getOperatorTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM RECTEAM WHERE rJOB='OPERATOR' AND PNUM IS NULL";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	// (4-2) 녹음 작업자 리스트(TOP-N)-- 프로젝트 없는 녹음 작업자
	public ArrayList<RecTeamDto> getOperatorList(int startRow, int endRow) {
		ArrayList<RecTeamDto> recteams = new ArrayList<RecTeamDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM RECTEAM ORDER BY pNUM DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ? AND PNUM IS NULL AND RJOB = 'OPERATOR'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String	rid		 =rs.getString("rid");
				String	rpw      =rs.getString("rpw");     
				String	rname    =rs.getString("rname");   
				String	rjob     =rs.getString("rjob");   
				int		pnum     =rs.getInt("pnum");   
				recteams.add(new RecTeamDto(rid, rpw, rname, rjob, pnum));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return recteams;
	}

	// (4-3) 녹음 작업자 리스트-- 해당 프로젝트 진행중인 녹음 작업자를(PNUM)으로 검색
	public ArrayList<RecTeamDto> getOperatorList(int pnum) {
		ArrayList<RecTeamDto> recteams = new ArrayList<RecTeamDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT RID, RNAME, RJOB, P.PNAME" + 
				"    FROM PROJECT P, RECTEAM R" + 
				"    WHERE P.PNUM = R.PNUM AND P.PNUM=? AND RJOB = 'OPERATOR'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String	rid		 =rs.getString("rid");
				String	rpw      =rs.getString("rpw");     
				String	rname    =rs.getString("rname");   
				String	rjob     =rs.getString("rjob");   
				recteams.add(new RecTeamDto(rid, rpw, rname, rjob, pnum));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return recteams;
	}
	// (5) 작업자 프로젝트 퇴출
	public int opOut(String rid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE RECTEAM SET PNUM = NULL WHERE RID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}	
	
	// (6) 작업자 프로젝트 배치
	public int opRegister(int pnum, String rid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE RECTEAM SET PNUM = ? WHERE RID = ? AND PNUM IS NULL";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setString(1, rid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}	
	//-------------------------일정 관리자-----------------------------
	// (1) 특정 프로젝트에 신청한 회원 수
	public int getRegisteredMemberTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM MEMBER WHERE PNUMREG = ? AND mACTIVATE = 'ON'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totCnt = rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return totCnt;
	}
	// (2) MEMBER 리스트(TOP-N) -- 특정 프로젝트에 신청한 사람중 프로젝트 없는 사람만 녹음횟수 순으로
	public ArrayList<MemberDto> getRegisteredMemberList(int startRow, int endRow, int pnum) {
		ArrayList<MemberDto> members = new ArrayList<MemberDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* " + 
				"        FROM(SELECT PNAME, P.PNUM PNUM,M.PNUM MPNUM,PNUMREG, MID, MNAME," + 
				"                MBIRTH, MGENDER, MPHONE, MORIGIN, MADDRESS, MDRIVE, MPREFER1," + 
				"                MPREFER2, MPREFER3, RCNT, MBANK, MACCOUNT " + 
				"            FROM MEMBER M, PROJECT P " + 
				"                WHERE P.PNUM = M.PNUMREG AND M.PNUM IS NULL AND MACTIVATE = 'ON'" + 
				"                ORDER BY M.PNUM DESC, RCNT DESC) " + 
				"            A)" + 
				"    WHERE RN BETWEEN ? AND ? AND PNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setInt(3, pnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String	pname	 =rs.getString("pname");
				int		mpnum    =rs.getInt("mpnum");
				int		pnumreg  =rs.getInt("pnumreg");    
				String	mid  	 =rs.getString("mid"); 
				String	mname    =rs.getString("mname"); 
				Date	mbirth   =rs.getDate("mbirth");  
				String	mgender  =rs.getString("mgender"); 
				String	mphone   =rs.getString("mphone");  
				String	morigin  =rs.getString("morigin"); 
				String	maddress =rs.getString("maddress");
				String	mdrive   =rs.getString("mdrive");  
				String	mprefer1 =rs.getString("mprefer1");
				String	mprefer2 =rs.getString("mprefer2");
				String	mprefer3 =rs.getString("mprefer3");
				int		rcnt     =rs.getInt("rcnt");
				String	mbank    =rs.getString("mbank");   
				String	maccount =rs.getString("maccount");
				members.add(new MemberDto(mid, mname, pnumreg, mbirth, mgender, mphone, morigin, maddress, mdrive, mprefer1, mprefer2, mprefer3, rcnt, mbank, maccount, pname, mpnum));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(rs    != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return members;
	}
	// (3) 신청한 MEMBER 등록으로 (pNUMREG => pNUM)
	public int memberConfirm(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET pNUM    = pNUMREG , " + 
				"                       pNUMREG = NULL " + 
				"        WHERE mID = mid AND pNUM IS NULL";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
	// (4) 신청자 프로젝트 중 퇴출
	public int memberOut(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET PNUM = NULL WHERE mID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn  != null) conn.close();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
		return result;
	}
}

