<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	footer {
		width : 100%;
		height:100px; 
		background-color: #6A56C7;
		position:relative;
		bottom:-1px;
  }
	footer #footer_conts, footer #footer_conts a {
		color: #EFC53F;
		font-weight: blod;
		font-size:0.9em;
		text-align: center;
		text-decoration: none;
	}
	footer #footer_conts p:first-child {
		font-weight: bold; height: 30px; line-height: 30px;
	}
	p{margin:0 auto;}
</style>
</head>
<body>
	<footer>
		<div id="footer_conts">
			<p>(주)SoundBooker</p> 
			<p>서울특별시 어떤구 어떤로 9 좋은빌딩 1-5F <c:if test="${empty recteam and empty member}">| <b><a href="${conPath }/rtLoginView.do">직원 모드</a></b></c:if></p>
			<p>Copyright© 2022 SB . All rights reserved.</p>
		</div>
	</footer>
</body>
</html>