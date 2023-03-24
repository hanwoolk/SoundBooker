package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBCommentModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	frcontent 	= request.getParameter("frcontent");
		int		fnum		= Integer.parseInt(request.getParameter("fnum"));
		int		frnum		= Integer.parseInt(request.getParameter("frnum"));
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		fbDao.freeCommentModify(frcontent, fnum, frnum);
	}

}
