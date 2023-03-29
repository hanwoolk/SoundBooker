package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;

public class PFinishService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		int	pnum	= Integer.parseInt(request.getParameter("pnum"));
		ProjectDao pDao = ProjectDao.getInstance();
		result = pDao.projectFinish(pnum);
		request.setAttribute("projectFinishResult", result);
	}

}
