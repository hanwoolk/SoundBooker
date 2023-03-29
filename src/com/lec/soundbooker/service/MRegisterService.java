package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.MemberDao;

public class MRegisterService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int pnum = Integer.parseInt(request.getParameter("pnum"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String mid = request.getParameter("mid");
		MemberDao mDao = MemberDao.getInstance();
		mDao.memberConfirm(mid);
	}
}
