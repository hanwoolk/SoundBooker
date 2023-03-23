package com.lec.soundbooker.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dao.MemberDao;

public class MModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result=0;
		MemberDao mDao 		= MemberDao.getInstance();
		String 	mid			= request.getParameter("mid");
		String 	dbMpw 		= request.getParameter("dbMpw");
		String 	oldMpw		= request.getParameter("oldMpw");
		if(!oldMpw.equals(dbMpw)) {
			request.setAttribute("modifyErrorMsg", "현재 비밀번호를 확인하세요");
			return;
		}
		String 	mpw			= request.getParameter("mpw");
		if(mpw.equals("")) {// 새 비밀번호를 입력하지 않을 경우, 현비밀번호로
			mpw=dbMpw;
		}
		String 	mname 		= request.getParameter("mname");
		int 	pnum 		= Integer.parseInt(request.getParameter("pnum"));
		int 	pnumreg 	= Integer.parseInt(request.getParameter("pnumreg"));
		String 	mbirthStr	= request.getParameter("mbirth");
		Date 	mbirth 		= null;
		if(!mbirthStr.equals("")) {
			mbirth = Date.valueOf(mbirthStr);
		}
		String 	mgender 	= request.getParameter("mgender");
		String 	mphone 		= request.getParameter("mphone");
		String 	morigin 	= request.getParameter("morigin");
		String 	maddress 	= request.getParameter("maddress");
		String 	mdrive 		= request.getParameter("mdrive");
		String 	mprefer1 	= request.getParameter("mprefer1");
		String 	mprefer2 	= request.getParameter("mprefer2");
		String 	mprefer3 	= request.getParameter("mprefer3");
		int		rcnt		= Integer.parseInt(request.getParameter("rcnt"));
		String 	mbank 		= request.getParameter("mbank");
		String 	maccount 	= request.getParameter("maccount");
		String 	mactivate	= request.getParameter("mactivate");
		//회원정보 수정
		MemberDto member	= new MemberDto(mid, mpw, mname, pnum, pnumreg, mbirth, mgender, mphone, morigin, maddress,
											mdrive, mprefer1, mprefer2, mprefer3, rcnt, mbank, maccount, mactivate);
		result 				= mDao.modifyMember(member);
		if(result == MemberDao.SUCCESS) { //수정 성공시 세션도 수정
			HttpSession session = request.getSession();
			session.setAttribute("member", member);
			request.setAttribute("modifyResult", "회원정보 수정 성공");
		}else { // 수정 실패시
			request.setAttribute("modifyErrorMsg", "회원정보 수정 실패");
		}
	}
}
