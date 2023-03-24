package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBoardContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int fnum = Integer.parseInt(request.getParameter("fnum"));
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		FreeBoardDao fbComments = FreeBoardDao.getInstance();
		request.setAttribute("freeBoardContent", fbDao.freeBoardContent(fnum));
		request.setAttribute("freeComments", fbComments.getFreeCommentlist(fnum));
	}
}
