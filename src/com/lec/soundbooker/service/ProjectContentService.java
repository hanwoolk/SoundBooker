package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;
import com.lec.soundbooker.dao.RecTeamDao;

public class ProjectContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int	pnum	= Integer.parseInt(request.getParameter("pnum"));
		ProjectDao pDao = ProjectDao.getInstance();
		RecTeamDao rtDao = RecTeamDao.getInstance();
		request.setAttribute("projectManager", rtDao.getPM(pnum));
		request.setAttribute("projectContent", pDao.projectContent(pnum));
	}
}
