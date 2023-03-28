package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;

public class ProjectListService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		// list.do나 list.do?pageNum=2
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 15, BLOCKSIZE = 5;
		int startRow = (currentPage-1)*PAGESIZE + 1;
		int endRow	 = startRow + PAGESIZE - 1;
		ProjectDao pDao = ProjectDao.getInstance();
		request.setAttribute("projectList", pDao.getProjectList(startRow, endRow)); // list.jsp에 출력될 글목록
		int totCnt = pDao.getProjectTotCnt(); //글 갯수
		int pageCnt = (int)Math.ceil((double)totCnt/PAGESIZE);
		int startPage	= ((currentPage-1)/BLOCKSIZE)*BLOCKSIZE + 1;
		int endPage 	= startPage + BLOCKSIZE -1;
		if(endPage > pageCnt) {
			endPage = pageCnt;
		}
		// 페이지 관련 항목들
		request.setAttribute("pageNum", currentPage);
		request.setAttribute("pageCnt", pageCnt);
		request.setAttribute("BLOCKSIZE", BLOCKSIZE);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);

	}

}
