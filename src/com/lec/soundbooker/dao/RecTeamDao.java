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
	// (3) rid로 자신의 프로젝트 불러오기(pnum만)
	public int getMyProject(String rid) {
		int rtPnum = FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT PNUM FROM RECTEAM WHERE rId=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rtPnum = rs.getInt(1);
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
		return rtPnum;
	}	
	//-------------------------프로젝트 관리자--------------------------
	// (0) 작업자 등록용 빈 ID만들기
	public int makeOperatorId(String rid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) " + 
				"    VALUES(?,'0','0','OPERATOR')";
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
	
	
	// (1) 퇴사 직원의 빈 ID 출력
	public String getOpId() {
		String OpId = null;
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		=null;
		String sql = "SELECT rID FROM RECTEAM WHERE rNAME='0' AND rJOB='OPERATOR' ORDER BY  TO_NUMBER(SUBSTR(rID,3))";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			OpId = rs.getString(1);
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
		return OpId;
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
			pstmt.executeUpdate();
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
			pstmt.executeUpdate();
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
			pstmt.executeUpdate();
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
			pstmt.executeUpdate();
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
		System.out.println(1);
		deleteRecTeamStep1(rid);
		System.out.println(2);
		deleteRecTeamStep2(rid);
		System.out.println(3);
		deleteRecTeamStep3(rid);
		System.out.println(4);
		deleteRecTeamStep4(rid);
		System.out.println(5);
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE RECTEAM " + 
				"    SET RPW       = '0'," + 
				"        RNAME     = '0'" + 
				"    WHERE RID = ?";
		try {
			conn = getConnection();
			System.out.println(6);
			pstmt = conn.prepareStatement(sql);
			System.out.println(7);
			pstmt.setString(1, rid);
			System.out.println(8);
			result = pstmt.executeUpdate();
			System.out.println(9);
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
	// (4) 프로젝트 번호로 담당 PM 상세보기
	public RecTeamDto getPM(int pnum) {
		RecTeamDto projectManager = new RecTeamDto();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM RECTEAM WHERE PNUM=? AND RJOB='PROJECT_MANAGER'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String	rid			=rs.getString("rid");
				String	rpw  		=rs.getString("rpw");   
				String	rname    	=rs.getString("rname");    
				String	rjob  		=rs.getString("rjob"); 
				projectManager = new RecTeamDto(rid, rpw, rname, rjob, pnum);
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
		return projectManager;
	}	
	// (4-1) 프로젝트 있는 녹음 작업자 전체 수
	public int getOperatorTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM RECTEAM WHERE rJOB='OPERATOR' AND NOT RNAME IN ('0')";
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
	// (4-2) 프로젝트 없는 녹음 작업자 전체 수
	public int getAvailOperatorTotCnt() {
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
	// (4-3) 녹음 작업자 리스트(TOP-N)-- 프로젝트 없는 녹음 작업자
	public ArrayList<RecTeamDto> getOperatorList(int startRow, int endRow) {
		ArrayList<RecTeamDto> recteams = new ArrayList<RecTeamDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * " + 
				"    FROM (SELECT ROWNUM RN, A.* FROM" + 
				"        (SELECT * " + 
				"            FROM RECTEAM WHERE PNUM IS NULL AND RJOB = 'OPERATOR' " + 
				"                            AND RNAME NOT IN ('0')ORDER BY RID DESC) A) " + 
				"    WHERE RN BETWEEN ? AND ?";
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

	// (4-4-1) 녹음 작업자 리스트-- 해당 프로젝트 진행중인 녹음 작업자를(PNUM)으로 검색
	public ArrayList<RecTeamDto> getOperatorList(int pnum) {
		ArrayList<RecTeamDto> recteams = new ArrayList<RecTeamDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT RID, RNAME, RJOB" + 
				"    FROM PROJECT P, RECTEAM R" + 
				"    WHERE P.PNUM = R.PNUM AND P.PNUM=? AND RJOB = 'OPERATOR'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String	rid		 =rs.getString("rid");
				String	rname    =rs.getString("rname");   
				String	rjob     =rs.getString("rjob");   
				recteams.add(new RecTeamDto(rid, rname, rjob));
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
	// (4-4-2) 녹음 작업자의 수-- 해당 프로젝트 진행중인 녹음 작업자를(PNUM)으로 검색
	public int getHowManyOpCnt(int pnum) {
		int cnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) FROM RECTEAM WHERE PNUM=? AND RJOB = 'OPERATOR'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			rs.next();
			cnt= rs.getInt(1);
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
		return cnt;
	}
	// (4-5) 전체 녹음 작업자 리스트(TOP-N)-- 빈 ID 제외
	public ArrayList<RecTeamDto> getAllOperatorList(int startRow, int endRow) {
		ArrayList<RecTeamDto> recteams = new ArrayList<RecTeamDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * " + 
				"    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * " + 
				"        FROM RECTEAM WHERE RJOB = 'OPERATOR' AND RNAME NOT IN ('0') ORDER BY RID DESC) A) " + 
				"    WHERE RN BETWEEN ? AND ?";
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
	// (4-6) 전체 녹음자 숫자 (빈ID제외)
	public int getAllOperatorTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM RECTEAM WHERE rJOB='OPERATOR' AND NOT rNAME IN('0')";
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
			pstmt.setString(2, rid);
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
		String sql = "SELECT * " + 
				"  FROM (SELECT ROWNUM RN, A.*  " + 
				"      FROM(SELECT PNAME, P.PNUM PNUM,M.PNUM MPNUM,PNUMREG, MID, MNAME, " + 
				"              MBIRTH, MGENDER, MPHONE, MORIGIN, MADDRESS, MDRIVE, MPREFER1, " + 
				"              MPREFER2, MPREFER3, RCNT, MBANK, MACCOUNT  " + 
				"          FROM MEMBER M, PROJECT P  " + 
				"              WHERE P.PNUM = M.PNUMREG AND M.PNUM IS NULL AND P.PNUM = ? AND MACTIVATE = 'ON' " + 
				"              ORDER BY M.PNUM DESC, RCNT DESC)  " + 
				"          A) " + 
				"  WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
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
}

