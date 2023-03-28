package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;
import com.lec.soundbooker.dao.UploadBoardDao;

public class PModifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		ProjectDao pDao = ProjectDao.getInstance();
		request.setAttribute("modifyProject", pDao.projectContent(pnum));
	}
}
