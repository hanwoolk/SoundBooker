package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.RecTeamDao;

public class OpRegisterService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String rid = request.getParameter("rid");
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		RecTeamDao rDao = RecTeamDao.getInstance();
		rDao.opRegister(pnum, rid);
	}
}
