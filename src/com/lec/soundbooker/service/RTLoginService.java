package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dao.RecTeamDao;
import com.lec.soundbooker.dto.RecTeamDto;

public class RTLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String method = request.getParameter("method");
		request.setAttribute("method", method);
		String rid = request.getParameter("rid");
		String rpw = request.getParameter("rpw");
		RecTeamDao mDao = RecTeamDao.getInstance();
		int result = mDao.loginCheck(rid, rpw);
		if(result==MemberDao.LOGIN_SUCCESS) { // 로그인 성공
			HttpSession session = request.getSession();
			RecTeamDto recteam = mDao.getRteam(rid);
			session.setAttribute("recteam", recteam);
			request.setAttribute("rtLoginMSG", "직원 계정으로 로그인하셨습니다");
		}else { // 로그인 실패
			request.setAttribute("rtLoginErrorMsg", "아이디와 비밀번호 혹인이 필요합니다. 프로젝트 관리자에게 문의해주세요");
		}
	}
}