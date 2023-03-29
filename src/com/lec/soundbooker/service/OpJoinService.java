package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.RecTeamDao;

public class OpJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		String opJoinMSG = "";
		String	rid 	= request.getParameter("rid");
		String	rname	= request.getParameter("rname");
		String	rpw		= request.getParameter("rpw");
		RecTeamDao rDao = RecTeamDao.getInstance();
		result = rDao.join_modifyRecTeam(rpw, rname, rid);
		if(result == RecTeamDao.FAIL) {
			opJoinMSG = "작업자 등록에 실패하였습니다. 다른 아이디로 시도하여주십시오.";
		}else{
			opJoinMSG = "작업자 등록 완료";
		}
		request.setAttribute("opJoinMSG", opJoinMSG);
	}

}
