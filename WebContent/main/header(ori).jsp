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
	*{padding:0; margin: 0; border:1px solid red;}
	header { 
		font-size: 10pt;
	}
	header a {text-decoration: none; font-weight: bold;}
	header li { list-style: none;}
	header .gnb{width: 100%;	background-color: #6A56C7;}
	header .gnb ul {
		overflow: hidden;
		width:700px;
		height: 30px;
		line-height: 30px;
		margin: 0 auto;
	}
	header .gnb ul li {	float: right;	margin-right: 30px;}
	header .gnb a { 
		color : #EFC53F;
		font-size: 0.9em;
		display: block;
		padding-left:15px;
		padding-right:15px;
	}
	header .logo{
		width:100%; text-align:center;
		margin: 20px auto; font-size:2em;
		cursor: pointer;
	}
	header .lnb {
	  width: 100%; height: 40px;
	  border-top: 1px solid #003300;
		border-bottom: 1px solid #003300;
		position:relative; /*서브메뉴가 main영역 위로 */
	}
	header .lnb ul{
		overflow: hidden;
		width:750px;
		margin-left: 10px;;
		cursor : pointer;
	}
	header .lnb ul>li {
		margin: 5px;
		float:left;
		padding:5px 40px;
		line-height: 25px;
	}
	header .lnb li a {color: #003300; width: 300px; text-align:left; font-weight:bold;}
	
	header .lnb li {color: #003300; margin-left:20px;}
	header .lnb li:hover {background: gray; }
	header .lnb ul li .subMenu {display:none; margin-right:30px;}
	header .lnb ul li:hover .subMenu {display: block; margin: 10px 0 0 0;}
	header .lnb ol {text-align:left; padding-inline-start:0;}
	header .lnb ol li {font-size:0.9em;}
	header .lnb ol li:hover {background: skyblue; transition: ease 1s;}
</style>
</head>
<body>
<header>
	<c:if test="${empty member and empty recteam}"> <%-- 로그인 전 화면 --%>
		<div class="gnb">
			<ul>
				<li><a href="${conPath }/joinView.do">회원가입</a></li>
				<li><a href="${conPath }/loginView.do">로그인</a></li>
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/main.do'">
			<img src="${conPath }/db/logo.PNG">
		</div>
		<div class="lnb">
			<ul>
				<li>
					<img src="${conPath }/db/logo.PNG" width="130px">
				</li>
				<li>
					회사 소개
				</li>
				<li>프로젝트
					<ol class="subMenu">
						<li><a href="${conPath }/loginView.do">프로젝트 목록</a></li>
						<li><a href="${conPath }/loginView.do">마이 프로젝트</a></li>
					</ol>
				</li>
				<li>
					<a href="${conPath }/loginView.do" >자유 게시판</a>
				</li>
			</ul>
		</div>
	</c:if>
	<c:if test="${not empty member or not empty recteam}"> <%-- 사용자 모드 로그인 화면--%>
		<div class="gnb">
			<ul>
				<c:if test="${not empty member }">
					<li><a href="${conPath }/logout.do">로그아웃</a></li>
					<li><a href="${conPath }/modifyView.do">정보수정</a></li>
					<li><a href="${conPath }/내정보 상세보기.do">${member.mname}님 &nbsp; ▶</a></li>	
				</c:if>
				<c:if test="${not empty recteam }">
					<li><a href="${conPath }/logout.do">로그아웃</a></li>
					<li><a href="${conPath }/rtmodifyView.do">정보수정</a></li>
					<li><a href="${conPath }/내정보 상세보기.do">${recteam.rname}님 &nbsp; ▶</a></li>	
				</c:if>
			</ul>
		</div>
		<div class="logo" onclick="location.href='${conPath}/main.do'">
			<img src="${conPath }/db/logo.PNG">
		</div>
		<div class="lnb">
			<ul>
				<li>
					회사 소개
				</li>
				<li>프로젝트<ol class="subMenu">
							<li><a href="${conPath }/projectList.do">프로젝트 목록</a></li>
							<li><a href="${conPath }/loginView.do">마이 프로젝트</a></li>
						</ol>
				</li>
				<li>
					<a href="${conPath }/freeBoardList.do" >자유 게시판</a>
				</li>
				<c:if test="${not empty recteam}">
					<li>
						<a href="${conPath }/uploadList.do" >업로드 게시판</a>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
</header>
</body>
</html>