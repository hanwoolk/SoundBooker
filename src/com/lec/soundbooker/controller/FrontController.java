package com.lec.soundbooker.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.lec.soundbooker.service.FBCommentDeleteService;
import com.lec.soundbooker.service.FBCommentModifyService;
import com.lec.soundbooker.service.FBCommentService;
import com.lec.soundbooker.service.FBContentService;
import com.lec.soundbooker.service.FBDeleteService;
import com.lec.soundbooker.service.FBListService;
import com.lec.soundbooker.service.FBModifyService;
import com.lec.soundbooker.service.FBModifyViewService;
import com.lec.soundbooker.service.FBWriteService;
import com.lec.soundbooker.service.MJoinService;
import com.lec.soundbooker.service.MLoginService;
import com.lec.soundbooker.service.MLogoutService;
import com.lec.soundbooker.service.MModifyService;
import com.lec.soundbooker.service.MWithdrawalService;
import com.lec.soundbooker.service.MidConfirmService;
import com.lec.soundbooker.service.MnamePhoneConfirmService;
import com.lec.soundbooker.service.PModifyService;
import com.lec.soundbooker.service.PRegisterService;
import com.lec.soundbooker.service.ProjectContentService;
import com.lec.soundbooker.service.ProjectListService;
import com.lec.soundbooker.service.RTLoginService;
import com.lec.soundbooker.service.Service;
import com.lec.soundbooker.service.UBCommentDeleteService;
import com.lec.soundbooker.service.UBCommentModifyService;
import com.lec.soundbooker.service.UBCommentService;
import com.lec.soundbooker.service.UBModifyService;
import com.lec.soundbooker.service.UBModifyViewService;
import com.lec.soundbooker.service.UBReplyService;
import com.lec.soundbooker.service.UBReplyViewService;
import com.lec.soundbooker.service.UBContentService;
import com.lec.soundbooker.service.UBDeleteService;
import com.lec.soundbooker.service.UBListService;
import com.lec.soundbooker.service.UBWriteService;
import com.lec.soundbooker.service.PModifyViewService;

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
/////////////////////////////////////////////////////////////////
//////////////////////member 관련 요청/////////////////////////////
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
/////////////////////////////////////////////////////////////////
//////////////////////freeboard 관련 요청//////////////////////////
////////////////////////////////////////////////////////////////			
		}else if(command.equals("/freeBoardList.do")) {
			service = new FBListService();
			service.execute(request, response);
			viewPage = "board/freeBoardList.jsp";
			
		}else if(command.equals("/freeBoardWriteView.do")) {
			viewPage = "board/freeBoardWrite.jsp";
			
		}else if(command.equals("/freeBoardWrite.do")) {
			service = new FBWriteService();
			service.execute(request, response);
			viewPage = "/freeBoardList.do";
			
		}else if(command.equals("/freeBoardContent.do")) {
			service = new FBContentService();
			service.execute(request, response);
			viewPage = "board/freeBoardContent.jsp";
			
		}else if(command.equals("/freeBoardModifyView.do")) {
			service = new FBModifyViewService();
			service.execute(request, response);
			viewPage = "board/freeBoardModify.jsp";
		
		}else if(command.equals("/freeBoardModify.do")) {
			service = new FBModifyService();
			service.execute(request, response);
			viewPage = "/freeBoardList.do";
			
		}else if(command.equals("/freeBoardDelete.do")) {
			service = new FBDeleteService();
			service.execute(request, response);
			viewPage = "/freeBoardList.do";
/////////////////////////////////////////////////////////////////
//////////////////////freeboard_comment 관련 요청//////////////////
////////////////////////////////////////////////////////////////			
		}else if(command.equals("/commentWrite.do")) {
			service = new FBCommentService();
			service.execute(request, response);
			viewPage = "/freeBoardContent.do";
			
		}else if(command.equals("/freeCommentDelete.do")) {
			service = new FBCommentDeleteService();
			service.execute(request, response);
			viewPage = "/freeBoardContent.do";
			
		}else if(command.equals("/freeCommentmodify.do")) {
			service = new FBCommentModifyService();
			service.execute(request, response);
			viewPage = "/freeBoardContent.do";
			
/////////////////////////////////////////////////////////////////
//////////////////////recTeam 관련 요청////////////////////////////
////////////////////////////////////////////////////////////////
		}else if(command.equals("/rtLoginView.do")) {
			viewPage = "recTeam/recTeamLogin.jsp";
		}else if(command.equals("/rtLogin.do")) {
			service = new RTLoginService();
			service.execute(request, response);
			viewPage = "/main.do";
			
/////////////////////////////////////////////////////////////////
//////////////////////uploadboard 관련 요청////////////////////////
////////////////////////////////////////////////////////////////
		}else if(command.equals("/uploadList.do")) {
			service = new UBListService();
			service.execute(request, response);
			viewPage = "board/uploadList.jsp";
		
		}else if(command.equals("/uploadWriteView.do")) {
			viewPage = "board/uploadWrite.jsp";
		
		}else if(command.equals("/uploadWrite.do")) {
			service = new UBWriteService();
			service.execute(request, response);
			viewPage = "/uploadList.do";
		
		}else if(command.equals("/uploadContent.do")) {
			service = new UBContentService();
			service.execute(request, response);
			viewPage = "board/uploadContent.jsp";
		
		}else if(command.equals("/uploadModifyView.do")) {
			service = new UBModifyViewService();
			service.execute(request, response);
			viewPage = "board/uploadModify.jsp";
		
		}else if(command.equals("/uploadModify.do")) {
			service = new UBModifyService();
			service.execute(request, response);
			viewPage = "/uploadList.do";
		
		}else if(command.equals("/uploadReplyView.do")) {
			service = new UBReplyViewService();
			service.execute(request, response);
			viewPage = "board/uploadReply.jsp";
			
		}else if(command.equals("/uploadReply.do")) {
			service = new UBReplyService();
			service.execute(request, response);
			viewPage = "/uploadList.do";
			
		}else if(command.equals("/uploadDelete.do")) {/////
			service = new UBDeleteService();
			service.execute(request, response);
			viewPage = "/uploadList.do";
/////////////////////////////////////////////////////////////////
//////////////////////uploadboard_comment 관련 요청////////////////
////////////////////////////////////////////////////////////////
		}else if(command.equals("/uCommentWrite.do")) {
			service = new UBCommentService();
			service.execute(request, response);
			viewPage = "/uploadContent.do";
		
		}else if(command.equals("/uCommentDelete.do")) {
			service = new UBCommentDeleteService();
			service.execute(request, response);
			viewPage = "/uploadContent.do";
		
		}else if(command.equals("/uCommentModify.do")) {
			service = new UBCommentModifyService();
			service.execute(request, response);
			viewPage = "/uploadContent.do";
			
/////////////////////////////////////////////////////////////////
//////////////////////project 관련 요청////////////////////////////
////////////////////////////////////////////////////////////////			
		}else if(command.equals("/projectList.do")) {
			service = new ProjectListService();
			service.execute(request, response);
			viewPage = "board/projectList.jsp";
			
		}else if(command.equals("/projectContent.do")) {
			service = new ProjectContentService();
			service.execute(request, response);
			viewPage = "board/projectContent.jsp";
			
		}else if(command.equals("/projectRegisterView.do")) {
			viewPage = "board/projectRegisterView.jsp";
			
		}else if(command.equals("/projectRegister.do")) {
			service = new PRegisterService();
			service.execute(request, response);
			viewPage = "/projectList.do";
			
		}else if(command.equals("/projectModifyView.do")) {
			service = new PModifyViewService();
			service.execute(request, response);
			viewPage = "board/projectModifyView.jsp";
			
		}else if(command.equals("/projectModify.do")) {
			service = new PModifyService();
			service.execute(request, response);
			viewPage = "/projectList.do";
		}else if(command.equals("")) {
			viewPage = "";
		}else if(command.equals("")) {
			viewPage = "";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);	
	}
}
