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
		String rid = null;
		RecTeamDao rDao = RecTeamDao.getInstance();
		for(int i=9; i<=100; i++){
			rid = "OP"+i;
			int result = rDao.makeOperatorId(rid);
			System.out.println(result == 1? i+"번째 성공" : i+"번째 실패");
		}
	response.sendRedirect("../opAllView.do");
%>
</body>
</html>