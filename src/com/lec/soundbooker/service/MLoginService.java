package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dto.MemberDto;

public class MLoginService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String method = request.getParameter("method");
		request.setAttribute("method", method);
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.loginCheck(mid, mpw);
		if(result==MemberDao.LOGIN_SUCCESS) { // 로그인 성공
			HttpSession session = request.getSession();
			MemberDto member = mDao.getMember(mid);
			result = mDao.activateId(mid);
			session.setAttribute("member", member);
			if(result == MemberDao.ACTIVATE) {
				request.setAttribute("activateId", "계정이 활성화되었습니다");
			}
		}else { // 로그인 실패
			request.setAttribute("loginErrorMsg", "아이디와 비밀번호를 확인하세요");
		}
	}
}