package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dto.MemberDto;

public class MProjectCancelService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result= 0;
		HttpSession session = request.getSession();
		String mid = ((MemberDto)session.getAttribute("member")).getMid();
		MemberDao mDao = MemberDao.getInstance();
		MemberDao mDao2 = MemberDao.getInstance();
		result = mDao.projectcancel(mid);
		session.setAttribute("member", mDao2.getMember(mid));;
		if(result != MemberDao.FAIL) {
			request.setAttribute("cancelMSG", "신청했던 프로젝트가 취소되었습니다");
		}else{
			request.setAttribute("cancelMSG", "프로젝트 취소가되지 않았습니다. 같은 문제가 반복될 시 직원에게 문의 바랍니다.");
		}
	}
}
