package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.RecTeamDao;

public class OpWithdrawalService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String rid = request.getParameter("rid");
		RecTeamDao rDao = RecTeamDao.getInstance();
		System.out.println(rid);
		rDao.opWithdrawal(rid);
	}
}
