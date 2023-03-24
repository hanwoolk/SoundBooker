package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBoardModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		int		fnum		=	Integer.parseInt(request.getParameter("fnum"));
		String	ftitle		=	request.getParameter("ftutle");
		String	fcontent	=	request.getParameter("fcontent");
		String	fip			=	request.getRemoteAddr();
		fbDao.modify(fnum, ftitle, fcontent, fip);

	}

}
