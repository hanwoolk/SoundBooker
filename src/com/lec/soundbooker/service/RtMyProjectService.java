package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.RecTeamDao;
import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dto.RecTeamDto;

public class RtMyProjectService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		RecTeamDto recteam = (RecTeamDto)session.getAttribute("recteam");
		String rid = recteam.getRid();
		RecTeamDao rDao = RecTeamDao.getInstance();
		int pnum = rDao.getMyProject(rid);
		session.setAttribute("pnum",pnum);
		
	}

}
