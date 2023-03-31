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
		String mid = null, ftitle = null, fcontent = null, rid = null, fip = null;
		FreeBoardDao bDao = FreeBoardDao.getInstance();
		for(int i=0; i<=70; i++){
			mid = "aaa";
			ftitle = "제목"+i;
			fcontent = "본문"+i;
			fip = "192.168.1."+i;
			int result = bDao.freeBoardWrite(mid, rid, ftitle, fcontent, fip);
			System.out.println(result == 1? i+"번째 성공" : i+"번째 실패");
		}
	response.sendRedirect("../freeBoardList.do");
%>
</body>
</html>