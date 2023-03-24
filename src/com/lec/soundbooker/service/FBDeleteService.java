package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int	fnum = Integer.parseInt(request.getParameter("fnum"));
		FreeBoardDao fbDao = FreeBoardDao.getInstance();
		int result = 0 ;
		result = fbDao.delete(fnum);
		request.setAttribute("freeBoardDeleteResult", result);
	}
}
