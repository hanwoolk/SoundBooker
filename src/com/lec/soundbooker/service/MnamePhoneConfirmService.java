package com.lec.soundbooker.service;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.dao.MemberDao;

public class MnamePhoneConfirmService implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String mname = request.getParameter("mname");
		String mphone = request.getParameter("mphone");
		int result = 0;
		MemberDao mDao = MemberDao.getInstance();
		result = mDao.mnamePhoneConfirm(mname, mphone);
		if(result == MemberDao.EXIST) {
			request.setAttribute("mnamePhoneConfirmResult", "<b>중복되는 이름과 생년월일이 있습니다</b>");
		}else {
			request.setAttribute("mnamePhoneConfirmResult", "가입 가능합니다");
		}
	}

}
