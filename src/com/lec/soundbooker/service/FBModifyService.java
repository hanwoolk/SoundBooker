package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int		fnum		=	Integer.parseInt(request.getParameter("fnum"));
		String	ftitle		=	request.getParameter("ftitle");
		String	fcontent	=	request.getParameter("fcontent");
		String	fip			=	request.getRemoteAddr();
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		fbDao.modify(fnum, ftitle, fcontent, fip);
	}
}
