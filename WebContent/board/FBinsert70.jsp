<%@page import="com.lec.soundbooker.dao.UploadBoardDao"%>
<%@page import="com.lec.soundbooker.dao.FreeBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
  <link href="${conPath }/css/style.css" rel="stylesheet">
</head>
<body>
	<%
		String utitle = null, ucontent = null, rid = null, uip = null, ufilename=null;
		UploadBoardDao uDao = UploadBoardDao.getInstance();
		for(int i=0; i<=70; i++){
			rid = "OP1";
			utitle = "제목"+i;
			ucontent = "본문"+i;
			uip = "192.168.1."+i;
			int result = uDao.uploadWrite(rid, utitle, ucontent, ufilename, uip);
			System.out.println(result == 1? i+"번째 성공" : i+"번째 실패");
		}
	response.sendRedirect("../freeBoardList.do");
%>
</body>
</html>