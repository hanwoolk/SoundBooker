package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dao.RecTeamDao;

public class OpOutService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		String rid = request.getParameter("rid");
		RecTeamDao rDao = RecTeamDao.getInstance();
		rDao.opOut(rid);
	}

}
