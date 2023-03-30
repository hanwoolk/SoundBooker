package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dto.MemberDto;

public class MProjectRegisetService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		HttpSession session = request.getSession();
		int	pnumreg = Integer.parseInt(request.getParameter("pnum"));
		String mid = ((MemberDto)session.getAttribute("member")).getMid();
		MemberDao mDao = MemberDao.getInstance();
		MemberDao mDao2 = MemberDao.getInstance();
		result = mDao.projectRegister(pnumreg, mid);
		session.setAttribute("member", mDao2.getMember(mid));;
		if(result != MemberDao.FAIL) {
			request.setAttribute("registerResultMSG", "신청 완료되었습니다");
		}else {
			request.setAttribute("registerResultMSG", "신청 실패하였습니다");
		}
	}

}
