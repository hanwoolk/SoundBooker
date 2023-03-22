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

public class ProjectDao {
	public static final int FAIL = 0;
	private static ProjectDao instance = new ProjectDao();
	public	static ProjectDao getInstance() {
		return instance;
	};
	private ProjectDao() {}
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
	// (1-1) 프로젝트 목록(진행중인 최신 등록순)
	public ArrayList<ProjectDto> getProjectList(int startRow, int endRow) {
		ArrayList<ProjectDto> projects = new ArrayList<ProjectDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT WHERE NOT PNUM IN (0) ORDER BY PNUM DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int		pnum		=rs.getInt("pnum");
				String	pname       =rs.getString("pname");     
				Date	pstartdate  =rs.getDate("pstartdate");   
				Date	penddate    =rs.getDate("penddate");    
				int		pmember  	=rs.getInt("pmember"); 
				int		pop   	 	=rs.getInt("pop");  
				String	pcontent 	=rs.getString("pcontent"); 
				Date	prdate   	=rs.getDate("prdate");  
				projects.add(new ProjectDto(pnum, pname, pstartdate, penddate, pmember, pop, pcontent, prdate));
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
		return projects;
	}
	// (1-2) 프로젝트 목록(완료된 최신 등록순)
	public ArrayList<ProjectDto> getEndProjectList(int startRow, int endRow) {
		ArrayList<ProjectDto> projects = new ArrayList<ProjectDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT WHERE PNUM = 0 ORDER BY PRDATE DESC) A)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int		pnum		=rs.getInt("pnum");
				String	pname       =rs.getString("pname");     
				Date	pstartdate  =rs.getDate("pstartdate");   
				Date	penddate    =rs.getDate("penddate");    
				int		pmember  	=rs.getInt("pmember"); 
				int		pop   	 	=rs.getInt("pop");  
				String	pcontent 	=rs.getString("pcontent"); 
				Date	prdate   	=rs.getDate("prdate");  
				projects.add(new ProjectDto(pnum, pname, pstartdate, penddate, pmember, pop, pcontent, prdate));
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
		return projects;
	}	
	// (2-1) 진행 or 진행 예정 프로젝트 갯수
	public int getProjectTotCnt() {
		int totCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM PROJECT WHERE NOT PNUM IN (0)";
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
	// (2-1) 완료된 프로젝트 갯수
	public int getEndProjectTotCnt() {
		int endTotCnt = 0;
		Connection			conn 	= null;
		PreparedStatement	pstmt 	= null;
		ResultSet			rs		= null;
		String sql = "SELECT COUNT(*) FROM PROJECT WHERE PNUM = 0";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			endTotCnt = rs.getInt(1);
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
		return endTotCnt;
	}
	// (3) 프로젝트 검색(진행중인 최신 등록순, 제목으로 검색{비슷한 이름도 나오게})
	public ArrayList<ProjectDto> getProjectSchList(String pname, int startRow, int endRow) {
		ArrayList<ProjectDto> projects = new ArrayList<ProjectDto>();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT *" + 
				"    FROM (SELECT ROWNUM RN, A.* " + 
				"	 	FROM(SELECT * FROM PROJECT WHERE LOWER(pNAME) LIKE '%'||LOWER(?)||'%') A) AND NOT PNUM IN (0)" + 
				"    WHERE RN BETWEEN ? AND ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int		pnum		=rs.getInt("pnum");
				Date	pstartdate  =rs.getDate("pstartdate");   
				Date	penddate    =rs.getDate("penddate");    
				int		pmember  	=rs.getInt("pmember"); 
				int		pop   	 	=rs.getInt("pop");  
				String	pcontent 	=rs.getString("pcontent"); 
				Date	prdate   	=rs.getDate("prdate");  
				projects.add(new ProjectDto(pnum, pname, pstartdate, penddate, pmember, pop, pcontent, prdate));
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
		return projects;
	}	
	// (4) 프로젝트 상세보기
	public ProjectDto projectContent(int pnum) {
		ProjectDto project = new ProjectDto();
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT * FROM PROJECT WHERE PNUM=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String	pname		=rs.getString("pname");
				Date	pstartdate  =rs.getDate("pstartdate");   
				Date	penddate    =rs.getDate("penddate");    
				int		pmember  	=rs.getInt("pmember"); 
				int		pop   	 	=rs.getInt("pop");  
				String	pcontent 	=rs.getString("pcontent"); 
				Date	prdate   	=rs.getDate("prdate");  
				project = new ProjectDto(pnum, pname, pstartdate, penddate, pmember, pop, pcontent, prdate);
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
		return project;
	}	
	// (4-2) 자신이 진행중인 프로젝트 (녹음작업자용)
	public ProjectDto opMyProject(String rid) {
		ProjectDto project = null;
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String sql = "SELECT R.PNUM PNUM, PNAME, PSTARTDATE, PENDDATE, PMEMBER, POP, PCONTENT, PRDATE" + 
				"    FROM PROJECT P, RECTEAM R WHERE R.PNUM = P.PNUM AND rID=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int		pnum      	=rs.getInt("pnum");     
				String	pname    	=rs.getString("pname");   
				Date	pstartdate  =rs.getDate("pstartdate");    
				Date	penddate  	=rs.getDate("penddate"); 
				int		pmember  	=rs.getInt("pmember"); 
				int		pop   		=rs.getInt("pop");  
				String	pcontent  	=rs.getString("pcontent"); 
				Date	prdate 		=rs.getDate("prdate");
				project = new ProjectDto(pnum, pname, pstartdate, penddate, pmember, pop, pcontent, prdate);
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
		return project;
	}
	// (5) 프로젝트 등록
	public int projectRegister(ProjectDto project) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) " + 
				"    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),?,?,?,?)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, project.getPname());
			pstmt.setDate(2, project.getPstartdate());
			pstmt.setDate(3, project.getPenddate());
			pstmt.setString(4, project.getPcontent());
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
	// (6) 프로젝트 수정
	public int modifyProject(int pnum, String pname, Date pstartdate, Date penddate, String pcontent) {
		int result = FAIL;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE PROJECT SET pNAME        = ?," + 
				"                   	 pSTARTDATE   = ?," + 
				"                   	 pENDDATE     = ?," + 
				"                   	 pCONTENT     = ?" + 
				"            WHERE PNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setDate(2, pstartdate);
			pstmt.setDate(3, penddate);
			pstmt.setString(4, pcontent);
			pstmt.setInt(5, pnum);
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
	// (7-1) 프로젝트 완료시(전체 member rcnt +1씩)
	private void projectFinishStep1(int pnum) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE MEMBER SET rCNT = rCNT +1 WHERE PNUM=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
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
	// (7-2) 프로젝트 완료시(직원 PNUM => NULL로)
	private void projectFinishStep2(int pnum) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE RECTEAM SET PNUM = NULL WHERE PNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
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
	// (7-3) 프로젝트 완료시(멤버  PNUM => NULL로)
	private void projectFinishStep3(int pnum) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE MEMBER SET PNUM = NULL WHERE PNUM = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
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
	// (7-4) 프로젝트 완료시(PROJECT PNUM=>0으로)
	private void projectFinish(int pnum) {
		Connection 			conn 	= null;
		PreparedStatement 	pstmt 	= null;
		String sql = "UPDATE PROJECT SET PNUM = 0 WHERE PNUM=?";
		projectFinishStep1(pnum);
		projectFinishStep2(pnum);
		projectFinishStep3(pnum);
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
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
}
