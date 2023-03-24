package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.UploadBoardDao;

public class UBCommentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	rid 		= request.getParameter("rid");
		String 	urcontent 	= request.getParameter("urcontent");
		String 	urip 		= request.getRemoteAddr();
		int 	unum 		= Integer.parseInt(request.getParameter("unum"));
		int 	result		= 0;
		UploadBoardDao bfDao = UploadBoardDao.getInstance();
		result = bfDao.uploadComment(rid, urcontent, urip, unum);
		request.setAttribute("freeCommentResult",result);
	}

}
