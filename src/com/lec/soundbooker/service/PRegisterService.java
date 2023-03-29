package com.lec.soundbooker.service;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.ProjectDao;
import com.lec.soundbooker.dto.ProjectDto;

public class PRegisterService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		Date	pstartdate		=null;
		Date	penddate		=null;
		String	pname			= request.getParameter("pname");
		String	pcontent		= request.getParameter("pcontent");
		String	pstartdateStr	= request.getParameter("pstartdate"); //"2023-04-05";
		if(!pstartdateStr.equals("")) {
			pstartdate = Date.valueOf(pstartdateStr);
		}
		String	penddateStr		= request.getParameter("penddate"); //"2023-04-06";
		if(!penddateStr.equals("")) {
			penddate = Date.valueOf(penddateStr);
		}
		int		pmember			= Integer.parseInt(request.getParameter("pmember"));
		int		pop				= Integer.parseInt(request.getParameter("pop"));
		ProjectDao pDao = ProjectDao.getInstance();
		ProjectDto project = new ProjectDto(pname, pstartdate, penddate, pmember, pop, pcontent);
		result = pDao.projectRegister(project);
		request.setAttribute("registerResult", result);
	}

}
