package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;

public class FBoardModifyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int fnum = Integer.parseInt(request.getParameter("fnum"));
		FreeBoardDao bDao = FreeBoardDao.getInstance();
		request.setAttribute("modifyBoard", bDao.freeBoardContent(fnum));
	}
}
