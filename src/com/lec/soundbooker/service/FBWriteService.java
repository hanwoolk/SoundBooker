package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBoardWriteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	mid 		= request.getParameter("mid");
		String 	rid 		= request.getParameter("rid");
		String 	ftitle		= request.getParameter("ftitle");
		String 	fcontent	= request.getParameter("fcontent");
		String 	fip			= request.getRemoteAddr();
		int		result 		= 0;
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		result = fbDao.freeBoardWrite(mid, rid, ftitle, fcontent, fip);
		request.setAttribute("fbWriteResult", result);
	}
}
