package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.RecTeamDao;

public class OpJoinViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		RecTeamDao rDao = RecTeamDao.getInstance();
		request.setAttribute("opid", rDao.getOpId());

	}

}
