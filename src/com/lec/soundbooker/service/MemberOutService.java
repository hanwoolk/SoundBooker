package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.MemberDao;

public class MemberOutService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		String mid = request.getParameter("mid");
		MemberDao mDao = MemberDao.getInstance();
		mDao.memberOut(mid);

	}

}
