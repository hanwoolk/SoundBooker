package com.lec.soundbooker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dto.ProjectDto;

public class ProjectDao {

	
	
	
	
	
	
	
	// (4) 프로젝트 등록
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
	// (5) 프로젝트 수정
	public int modif(MemberDto member) {
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
}
