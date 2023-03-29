package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.RecTeamDao;

public class OpModifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String rid = request.getParameter("rid");
		RecTeamDao rDao = RecTeamDao.getInstance();
		request.setAttribute("OpDto",rDao.getRteam(rid) );
	}

}
