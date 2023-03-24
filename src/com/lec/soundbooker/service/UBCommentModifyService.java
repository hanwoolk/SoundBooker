package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.UploadBoardDao;

public class UBCommentModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String 	urcontent 	= request.getParameter("urcontent");
		String	unumStr		= request.getParameter("unum");
		int		unum = 0;
		if(unumStr != null) {
			unum = Integer.parseInt(unumStr);
		}
		String	urnumStr	= request.getParameter("urnum");
		int		urnum = 0;
		if(urnumStr != null) {
			urnum = Integer.parseInt(urnumStr);
		}
		UploadBoardDao ubDao = UploadBoardDao.getInstance();
		ubDao.uploadCommentModify(urcontent, unum, urnum);
	}
}
