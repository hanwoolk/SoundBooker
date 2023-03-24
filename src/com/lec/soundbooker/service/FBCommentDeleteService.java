package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBCommentDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	pageNum	=	request.getParameter("pageNum");
		int 	frnum	=	Integer.parseInt(request.getParameter("frnum"));
		int		fnum	=	Integer.parseInt(request.getParameter("fnum"));
		int		result 	= 	0;
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		result = fbDao.freeCommentDelete(fnum, frnum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("freeCommentDelete", result);

	}

}
