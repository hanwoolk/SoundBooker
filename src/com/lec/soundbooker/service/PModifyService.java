package com.lec.soundbooker.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.FreeBoardDao;
import com.lec.soundbooker.dao.ProjectDao;

public class PModifyService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		Date	pstartdate		= null;
		Date	penddate		= null;
		int		pnum			= Integer.parseInt(request.getParameter("pnum"));
		String	pname			= request.getParameter("pname");
		String	pstartdateStr	= request.getParameter("pstartdate");
		if(!(pstartdateStr).equals("")) {
			pstartdate = Date.valueOf(pstartdateStr);
		}
		String	penddateStr		= request.getParameter("penddate");
		if(!penddateStr.equals("")) {
			penddate = Date.valueOf(penddateStr);
		}
		int		pmember			= Integer.parseInt(request.getParameter("pmember"));
		int		pop				= Integer.parseInt(request.getParameter("pop"));
		String	pcontent		= request.getParameter("pcontent");
		ProjectDao pDao = ProjectDao.getInstance();
		result = pDao.modifyProject(pnum, pname, pstartdate, penddate, pcontent, pmember, pop);
		request.setAttribute("projectModifyResult", result);

	}

}
