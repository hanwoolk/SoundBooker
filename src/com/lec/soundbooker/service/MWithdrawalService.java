package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dto.MemberDto;

public class MWithdrawalService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mid = null;
		MemberDto sessionMember = (MemberDto) session.getAttribute("member");
		if(sessionMember!=null) {
			mid = sessionMember.getMid();
		}
		MemberDao mDao = MemberDao.getInstance();
		int result = mDao.deactivateId(mid); // 회원탈퇴
		session.invalidate(); // 세션 삭제
		if(result == MemberDao.SUCCESS) {
			request.setAttribute("withdrawalResult", "계정이 비활성화 되고 작성한 글들의 ID가 지워졌습니다.");
		}else {
			request.setAttribute("withdrawalResult", "로그인이 되어 있지 않습니다.");
		}
	}
}
