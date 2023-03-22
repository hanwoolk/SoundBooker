package com.lec.soundbooker.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.service.MJoinService;
import com.lec.soundbooker.service.MLoginService;
import com.lec.soundbooker.service.MLogoutService;
import com.lec.soundbooker.service.MModifyService;
import com.lec.soundbooker.service.MWithdrawalService;
import com.lec.soundbooker.service.MidConfirmService;
import com.lec.soundbooker.service.MnamePhoneConfirmService;
import com.lec.soundbooker.service.Service;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actiondo(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		actiondo(request, response);
	}

	private void actiondo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		String command = uri.substring(conPath.length());
		String viewPage = null;
		Service service = null;
		if(command.equals("/main.do")) {
			viewPage = "main/main.jsp";
////////////////////////////////////////////////////////////////
//////////////////////member 관련 요청////////////////////////////
////////////////////////////////////////////////////////////////	
			
		}else if(command.equals("/joinView.do")) {
			viewPage = "member/join.jsp";
		}else if(command.equals("/midConfirm.do")) {
			service = new MidConfirmService();
			service.execute(request, response);
			viewPage = "member/midConfirm.jsp";
		}else if(command.equals("/mnamePhoneConfirm.do")) {
			service = new MnamePhoneConfirmService();
			service.execute(request, response);
			viewPage = "member/mnamePhoneConfirm.jsp";
		}else if(command.equals("/join.do")) {
			service = new MJoinService();
			service.execute(request, response);
			viewPage = "/loginView.do";
		}else if(command.equals("/loginView.do")) {
			viewPage = "member/login.jsp";
		}else if(command.equals("/login.do")) {
			service = new MLoginService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(command.equals("/logout.do")) {//로그아웃 - 세션 날리기
			service = new MLogoutService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(command.equals("/modifyView.do")) { //정보 수정하기 위한 view
			viewPage = "member/modify.jsp";
		}else if(command.equals("/modify.do")) { // db의 정보 수정
			service = new MModifyService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(command.equals("/withdrawal.do")) {
			service = new MWithdrawalService();
			service.execute(request, response);
			viewPage = "main/main.jsp";
		}else if(command.equals("")) {
			viewPage = "";
		}else if(command.equals("")) {
			viewPage = "";
		}else if(command.equals("")) {
			viewPage = "";
		}else if(command.equals("")) {
			viewPage = "";
		}else if(command.equals("")) {
			viewPage = "";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);	
	}
}
