package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.UploadBoardDao;

public class UBCommentDeleteService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	pageNum	=	request.getParameter("pageNum");
		int 	urnum	=	Integer.parseInt(request.getParameter("urnum"));
		int		unum	=	Integer.parseInt(request.getParameter("unum"));
		int		result 	= 	0;
		UploadBoardDao ubDao = UploadBoardDao.getInstance();
		result = ubDao.uploadCommentDelete(unum, urnum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("uploadCommentDelete", result);

	}

}
