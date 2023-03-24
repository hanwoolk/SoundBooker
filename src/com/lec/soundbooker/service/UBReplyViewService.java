package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.UploadBoardDao;

public class UBReplyViewService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int unum = Integer.parseInt(request.getParameter("unum"));
		UploadBoardDao ubDao = UploadBoardDao.getInstance();
		request.setAttribute("replyBoard", ubDao.uploadContent(unum)); // 원글dto
	}

}