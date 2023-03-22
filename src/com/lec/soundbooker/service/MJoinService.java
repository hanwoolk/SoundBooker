package com.lec.soundbooker.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dto.MemberDto;

public class MJoinService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String mbirthStr = request.getParameter("mbirth");
		Date mbirth = null;
		if(!mbirthStr.equals("")) {
			mbirth = Date.valueOf(mbirthStr);
		}
		String mgender = request.getParameter("mgender");
		String mphone = request.getParameter("mphone");
		String morigin = request.getParameter("morigin");
		String maddress = request.getParameter("maddress");
		String mdrive = request.getParameter("mdrive");
		String mprefer1 = request.getParameter("mprefer1");
		String mprefer2 = request.getParameter("mprefer2");
		String mprefer3 = request.getParameter("mprefer3");
		String mbank = request.getParameter("mbank");
		String maccount = request.getParameter("maccount");
		int pnum = 0;
		int pnumreg = 0;
		int rcnt = 0;
		String mactivate = "on";
		MemberDto member = new MemberDto(mid, mpw, mname, pnum, pnumreg, mbirth, mgender, mphone, morigin, maddress, mdrive, mprefer1, mprefer2, mprefer3, rcnt, mbank, maccount, mactivate);
		MemberDao mDao = MemberDao.getInstance();
		result = mDao.joinMember(member);
		if(result == MemberDao.SUCCESS) {
			HttpSession session = request.getSession(); // 세션은 request로 부터
			session.setAttribute("mid", mid);
			request.setAttribute("joinResult", "회원가입이 완료되었습니다");
		}else {
			request.setAttribute("joinErrorMsg", "정보가 너무 길어서 회원가입 실패");
		}
	}
}
