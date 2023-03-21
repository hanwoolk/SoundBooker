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

public class MemberDao {
	public static final int EXIST = 0;
	public static final int NOTEXIST = 1;
	public static final int FAIL = 0;
	public static final int LOGIN_FAIL = 0;
	public static final int LOGIN_SUCCESS = 1;
	public static final int ACTIVATE = 1;
	public static final int ALREADYACTIVATE = 0;
	private static MemberDao instance = new MemberDao();
	public	static MemberDao getInstance() {
		return instance;
	};
	private MemberDao() {}
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
	// (1-1) 회원id 중복체크
	public int midConfirm(String mid) {
		int result = EXIST;
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		=null;
		String sql = "SELECT * FROM MEMBER WHERE MID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXIST;
			}else {
				result = NOTEXIST;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	// (1-2) 회원 이름 mNAME  중복체크
	public int mnameConfirm(String mname) {
		int result = EXIST;
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		=null;
		String sql = "SELECT * FROM MEMBER WHERE MNAME=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXIST;
			}else {
				result = NOTEXIST;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	// (1-3) 회원 생년월일(mBIRTH) 중복체크
	public int mbirthConfirm(String mbirth) {
		int result = EXIST;
		Connection			conn	= null;
		PreparedStatement	pstmt	= null;
		ResultSet			rs		= null;
		String sql = "SELECT * FROM MEMBER WHERE MBIRTH=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mbirth);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = EXIST;
			}else {
				result = NOTEXIST;
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	// (2) 회원가입
	public int joinMember(MemberDto member) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO MEMBER (mID, mPW, mNAME,mBIRTH, mGENDER, mPHONE, mORIGIN," + 
				"        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, mBANK, mACCOUNT) " + 
				"    VALUES(?, ?, ?, ?, ?, ?, ?," + 
				"        ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMid());
			pstmt.setString(2, member.getMpw());
			pstmt.setString(3, member.getMname());
			pstmt.setDate(4, member.getMbirth());
			pstmt.setString(5, member.getMgender());
			pstmt.setString(6, member.getMphone());
			pstmt.setString(7, member.getMorigin());
			pstmt.setString(8, member.getMaddress());
			pstmt.setString(9, member.getMdrive());
			pstmt.setString(10, member.getMprefer1());
			pstmt.setString(11, member.getMprefer2());
			pstmt.setString(12, member.getMprefer3());
			pstmt.setString(13, member.getMbank());
			pstmt.setString(14, member.getMaccount());
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
	// (3-1) 계정 활성화
	public int activateId(String mid) {
		int result = FAIL;
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "UPDATE MEMBER SET mACTIVATE = 'ON'" + 
				"    WHERE mID =? and mACTIVATE = 'OFF'";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = ACTIVATE;
			}else {
				result = ALREADYACTIVATE;
			}
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
	// (3) 로그인
	public int loginCheck(String mid, String mpw) {
		int result = LOGIN_FAIL;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM MEMBER WHERE mID=? and mPW=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
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
	// (4) mid로 dto가져오기(로그인 성공시 session에 넣기 위함)
	public MemberDto getMember(String mid) {
		MemberDto member = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM MEMBER WHERE mId=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String	mpw      =rs.getString("mpw");     
				String	mname    =rs.getString("mname");   
				int		pnum     =rs.getInt("pnum");    
				int		pnumreg  =rs.getInt("pnumreg"); 
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
				String	mactivate =rs.getString("mactivate");
				member = new MemberDto(mid, mpw, mname, pnum, pnumreg, mbirth, mgender, mphone, morigin, maddress, mdrive, mprefer1, mprefer2, mprefer3, rcnt, mbank, maccount, mactivate);
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
		return member;
	}
	// (5) 회원 정보 수정
	public int modifyMember(MemberDto member) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER " + 
				"    SET MPW       = ?," + 
				"        MNAME     = ?," + 
				"        MPHONE    = ?," + 
				"        MADDRESS  = ?," + 
				"        MDRIVE    = ?," + 
				"        MPREFER1  = ?," + 
				"        MPREFER2  = ?," + 
				"        MPREFER3  = ?," + 
				"        MBANK     = ?," + 
				"        MACCOUNT  = ?" + 
				"    WHERE MID = ?;";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMpw());
			pstmt.setString(2, member.getMname());
			pstmt.setString(3, member.getMphone());
			pstmt.setString(4, member.getMaddress());
			pstmt.setString(5, member.getMdrive());
			pstmt.setString(6, member.getMprefer1());
			pstmt.setString(7, member.getMprefer2());
			pstmt.setString(8, member.getMprefer3());
			pstmt.setString(9, member.getMbank());
			pstmt.setString(10, member.getMaccount());
			pstmt.setString(10, member.getMid());
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
	// (6) 프로젝트 신청
	public int projectRegister(String pnumreg, String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET PNUMREG = ?" + 
				"        WHERE MID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnumreg);
			pstmt.setString(2, mid);
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
	// (7) 신청 취소
	public int projectcancel(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET PNUMREG = NULL" + 
				"        WHERE MID = ?";
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
	// (6)회원 리스트(TOP-N)
	public ArrayList<MemberDto> getMemberList(int startRow, int endRow) {
		ArrayList<MemberDto> members = new ArrayList<MemberDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM MEMBER ORDER BY RCNT DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String	mid		 =rs.getString("mid");
				String	mpw      =rs.getString("mpw");     
				String	mname    =rs.getString("mname");   
				int		pnum     =rs.getInt("pnum");    
				int		pnumreg  =rs.getInt("pnumreg"); 
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
				String	mactivate =rs.getString("mactivate");
				members.add(new MemberDto(mid, mpw, mname, pnum, pnumreg, mbirth, mgender, mphone, morigin, maddress, mdrive, mprefer1, mprefer2, mprefer3, rcnt, mbank, maccount, mactivate));
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
	// (8) 전체 등록된 회원수
	public int getMemberTotCnt() {
		int totCnt = 0;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT COUNT(*) CNT FROM MEMBER";
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
	// (9) 회원탈퇴
	public int deactivateId(String mid) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE MEMBER SET mACTIVATE = 'OFF'" + 
				"    WHERE mID =?";
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
