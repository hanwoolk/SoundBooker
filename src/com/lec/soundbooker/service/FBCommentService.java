package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;
import com.lec.soundbooker.dto.MemberDto;
import com.lec.soundbooker.dto.RecTeamDto;

public class FBCommentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	mid 		= request.getParameter("mid");
		String 	rid 		= request.getParameter("rid");
		String 	frcontent 	= request.getParameter("frcontent");
		String 	frip 		= request.getRemoteAddr();
		int 	fnum 		= Integer.parseInt(request.getParameter("fnum"));
		int 	result		= 0;
		FreeBoardDao bfDao = FreeBoardDao.getInstance();
		result = bfDao.freeCommentWrite(mid, rid, frcontent, frip, fnum);
		request.setAttribute("freeCommentResult",result);
	}

}
