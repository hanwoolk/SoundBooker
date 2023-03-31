<%@page import="java.sql.Date"%>
<%@page import="com.lec.soundbooker.dto.MemberDto"%>
<%@page import="com.lec.soundbooker.dao.MemberDao"%>
<%@page import="com.lec.soundbooker.dao.RecTeamDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		String mid = null, mname=null, mpw=null, mgender=null, mphone=null, morigin=null,
        maddress=null, mbank=null, maccount=null;
		Date mbirth=null;
		MemberDao mDao = MemberDao.getInstance();
		for(int i=11; i<=300; i++){
			mid = "member"+i;
			mpw = "1";
			mname = "참여자"+i;
			mgender="M";
			mphone="010-1111-1111";
			morigin="N";
      maddress="경기도";
      mbank="우리";
      maccount="1002-03-110423";
      MemberDto member = new MemberDto(mid,mpw,mname,mgender,mphone,morigin,maddress,mbank,maccount);
			int result = mDao.DummyjoinMember(member);
			System.out.println(result == 1? i+"번째 성공" : i+"번째 실패");
		}
	response.sendRedirect("../memberList.do");
%>
</body>
</html>



