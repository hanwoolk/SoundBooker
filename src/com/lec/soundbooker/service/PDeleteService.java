package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;

public class PDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int	pnum	= Integer.parseInt(request.getParameter("pnum"));
		ProjectDao pDao = ProjectDao.getInstance();
		pDao.projectDelete(pnum);
	}

}
