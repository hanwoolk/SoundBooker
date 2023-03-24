package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.UploadBoardDao;

public class UBContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int unum = Integer.parseInt(request.getParameter("unum"));
		UploadBoardDao ubDao = UploadBoardDao.getInstance();
		UploadBoardDao ubcDao = UploadBoardDao.getInstance();
		request.setAttribute("uploadContents", ubDao.uploadContent(unum));
		request.setAttribute("uploadComments", ubcDao.getUploadBoardCommentlist(unum));
	}
}
