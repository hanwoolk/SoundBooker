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
<style>
		#wrapper {
		  justify-content: center;
		  align-items: center;
		  height:697px;
		  min-height: 100%;
		  padding-bottom:100px ;
		}
	table{width: 500px; margin:0 auto 30px auto;}
	table tr th{width:130px; text-align:right; margin-left:30px;}
	table tr td{padding:10px; padding-left:60px;}
	h3{text-align:center;padding:30px;}
		.title{text-align:center;}
		p{margin-top: 30px;}
		.table_wrapper{
			width:500px;
			margin: 0 auto; 
			box-shadow:4px 4px #EFC53F;
			padding:30px 10px 10px 10px;}
		}
		h3 {
	    display: block;
	    font-size: 1.17em;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    font-weight: bold;
		}
		h1,p {text-align: center;}
		h1 {padding :50px;}
		th{ptext-align:right;}
		.content {
			width:520px;
			margin:100px auto 0 auto;
		  font-family: system-ui, serif;
		  border-radius: 10px;
		  border:1px solid gray;
		  box-shadow: 3px 3px #EFC53F;
		}
	
</style>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div class="content">
		<h3>직원 정보</h3>
			<table>
				<tr>
					<th>아이디</th><td>: ${recteam.rid }</td>
				</tr>
				<tr>
					<th>비밀번호</th><td>: ${recteam.rpw }</td>
				</tr>
				<tr>
					<th>이름</th><td>: ${recteam.rname }</td>
				</tr>
				<tr>
					<th>직책</th><td>: ${recteam.rjob == 'PROJECT_MANAGER'? '프로젝트 매니저':recteam.rjob == 'OPERATOR'? '녹음 작업자':'일정 관리자'}</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>