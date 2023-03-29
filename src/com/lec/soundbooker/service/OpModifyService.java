package com.lec.soundbooker.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dao.RecTeamDao;
import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dto.RecTeamDto;

public class OpModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result=0;
		RecTeamDao rDao		= RecTeamDao.getInstance();
		String 	rid			= request.getParameter("rid");
		String 	dbRpw 		= request.getParameter("dbRpw");
		String 	oldRpw		= request.getParameter("oldRpw");
		String 	rjob		= request.getParameter("rjob");
		int 	pnum		= Integer.parseInt(request.getParameter("pnum"));
		if(!oldRpw.equals(dbRpw)) {
			request.setAttribute("RmodifyErrorMsg", "현재 비밀번호를 확인하세요");
			return;
		}
		String 	rpw			= request.getParameter("rpw");
		if(rpw.equals("")) {// 새 비밀번호를 입력하지 않을 경우, 현비밀번호로
			rpw=dbRpw;
		}
		String 	rname 		= request.getParameter("rname");
		
		//회원정보 수정
		result 				= rDao.join_modifyRecTeam(rpw, rname, rid);
		if(result == MemberDao.SUCCESS) { //수정 성공시 세션도 수정
			request.setAttribute("modifyResult", "회원정보 수정 완료");
		}else { // 수정 실패시
			request.setAttribute("modifyResult", "회원정보 수정 실패, 비밀번호 확인 부탁드립니다");
		}
	}
}
