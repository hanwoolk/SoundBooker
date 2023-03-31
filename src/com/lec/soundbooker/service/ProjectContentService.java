package com.lec.soundbooker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lec.soundbooker.dao.MemberDao;
import com.lec.soundbooker.dao.ProjectDao;
import com.lec.soundbooker.dao.RecTeamDao;

public class ProjectContentService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		int tempPnum = 0;
		String	pnumStr	= request.getParameter("pnum");
		if(pnumStr == null) {
			tempPnum = (int) session.getAttribute("pnum");
		}else {
			tempPnum = Integer.parseInt(request.getParameter("pnum"));
		}
		int pnum = tempPnum;
		request.setAttribute("pnum", pnum);
		ProjectDao pDao = ProjectDao.getInstance();
		RecTeamDao rDao = RecTeamDao.getInstance();
		MemberDao mDao	= MemberDao.getInstance();
		request.setAttribute("projectManager", rDao.getPM(pnum));
		request.setAttribute("projectContent", pDao.projectContent(pnum));
		request.setAttribute("projectOp", rDao.getOperatorList(pnum));
		request.setAttribute("projectMember", mDao.getMemberList(pnum));
		request.setAttribute("HowManyOp", rDao.getHowManyOpCnt(pnum));
		request.setAttribute("HowManyMember", mDao.getHowManyMemberCnt(pnum));
		/////////////////////////////PM용 프로젝트 없는 op_list//////////////////////////////////////////////////
		String pageNum 	= request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		final int PAGESIZE = 20, BLOCKSIZE = 10; // 진행중 변경 예정
		int startRow = (currentPage-1)*PAGESIZE + 1;
		int endRow	 = startRow + PAGESIZE - 1;
		request.setAttribute("OpList", rDao.getOperatorList(startRow, endRow)); // list.jsp에 출력될 글목록
		int totCnt = rDao.getOperatorTotCnt(); //글 갯수
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
		//////////////////////////////일정관리자용 프로젝트 신청한 Member_list//////////////////////////////////////////////////
		String mpageNum 	= request.getParameter("pageNum");
		if(mpageNum == null) mpageNum = "1";
		int mcurrentPage = Integer.parseInt(mpageNum);
		final int MPAGESIZE = 20, MBLOCKSIZE = 10; // 진행중 변경 예정
		int pnumreg = pnum;
		int mstartRow = (mcurrentPage-1)*MPAGESIZE + 1;
		int mendRow	 = mstartRow + MPAGESIZE - 1;
		request.setAttribute("regMemberList", mDao.getRegMemberList(pnumreg, mstartRow, mendRow));
		int mtotCnt = mDao.getRegMemberTotCnt(pnumreg); //글 갯수
		int mpageCnt = (int)Math.ceil((double)mtotCnt/MPAGESIZE);
		int mstartPage	= ((mcurrentPage-1)/MBLOCKSIZE)*MBLOCKSIZE + 1;
		int mendPage 	= mstartPage + MBLOCKSIZE -1;
		if(mendPage > mpageCnt) {
			mendPage = mpageCnt;
		}
		// 페이지 관련 항목들
		request.setAttribute("mpageNum", mcurrentPage);
		request.setAttribute("mpageCnt", mpageCnt);
		request.setAttribute("MBLOCKSIZE", MBLOCKSIZE);
		request.setAttribute("mstartPage", mstartPage);
		request.setAttribute("mendPage", mendPage);
		///////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
