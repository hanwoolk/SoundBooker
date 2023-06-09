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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<style>
	
	img{width:300px; cursor:pointer;}
	.d-flex {list-style:none; padding-right:10px;}
	.d-flex a{text-decoration:none; list-style:none; color:gray; margin: 0 10px; padding-right:10px;}
	ul:first-child{margin: 0 30px;}
	header nav:first-child{background-color:#6A56C7;}
	li{margin-right:10px;}
	.dropdown-menu li{margin: 0 auto;}
</style>
</head>
<body>
<header>
<nav class="navbar navbar-expand-lg bg-light">
	<div class="container-fluid">
		<img src="${conPath }/db/logo.PNG" onclick="location.href='${conPath}/main.do'">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    	<span class="navbar-toggler-icon"></span>
    </button>
 		<c:if test="${empty member and empty recteam}"> <%-- 로그인 전 화면 --%>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
    	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
      	<li class="nav-item">
        	<a class="nav-link active" aria-current="page" href="#">회사 소개</a>
        </li>
        <li class="nav-item dropdown">
        	<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          	 프로젝트
          </a>
          <ul class="dropdown-menu">
          	<li><a class="dropdown-item" href="${conPath }/loginView.do">프로젝트 목록</a></li>
            <li><a class="dropdown-item" href="${conPath }/loginView.do?pnum=${param.pnum}">마이 프로젝트</a></li>
          </ul>
        </li>
        <li class="nav-item">
        	<a class="nav-link active" aria-current="page" href="${conPath }/loginView.do">자유 게시판</a>
        </li>
      </ul>
      <ul class="d-flex">
				<li><a href="${conPath }/joinView.do">회원가입</a></li>
				<li><a href="${conPath }/loginView.do">로그인</a></li>
      </ul>
    </div>
  </c:if>
  <c:if test="${not empty member or not empty recteam}"> <%-- 사용자 모드 로그인 화면--%>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  	<ul class="navbar-nav me-auto mb-2 mb-lg-0">
    	<li class="nav-item">
      	<a class="nav-link active" aria-current="page" href="#">회사 소개</a>
    	</li>
      <li class="nav-item dropdown">
      	<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        	 프로젝트
        </a>
        <ul class="dropdown-menu">
        	<li><a class="dropdown-item" href="${conPath }/projectList.do">프로젝트 목록</a></li>
        <c:if test="${not empty recteam and recteam.rjob != 'SCHEDULER'}">
          <li><a class="dropdown-item" href="${conPath }/rtMyProject.do">마이 프로젝트</a></li>
         </c:if>
        <c:if test="${not empty member and member.pnum != null}">
          <li><a class="dropdown-item" href="${conPath }/memberMyProject.do">마이 프로젝트</a></li>
         </c:if>
        </ul>
      </li>
      <li class="nav-item">
      	<a class="nav-link active" aria-current="page" href="${conPath }/freeBoardList.do">자유 게시판</a>
      </li>
      <c:if test="${not empty recteam}">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page"  href="${conPath }/uploadList.do" >업로드 게시판</a>
				</li>
				<c:if test="${recteam.rjob eq 'PROJECT_MANAGER' }">
		      <li class="nav-item dropdown">
		      	<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		        	 작업자 관리
		        </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${conPath }/opJoinView.do">신규 작업자 등록</a></li>
							<li><a class="dropdown-item" href="${conPath }/opAllView.do">작업자 목록</a></li>
						</ul>
					</li>
				</c:if>
				<c:if test="${recteam.rjob eq 'SCHEDULER' }">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page"  href="${conPath }/memberList.do" >신청자 목록</a>
				</li>
				</c:if>
			</c:if>
   	</ul>
		<ul class="d-flex">
			<c:if test="${not empty member }">
				<li><a href="${conPath }/mMyInfoView.do?">${member.mname}님 </a></li>
				<li><a href="${conPath }/modifyView.do">정보수정 </a></li>
				<li><a href="${conPath }/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${not empty recteam }">
				<li><a href="${conPath }/rtMyInfoView.do">${recteam.rname}님 </a></li>
				<li><a href="${conPath }/rtModifyView.do">정보수정 </a></li>
				<li><a href="${conPath }/logout.do">로그아웃</a></li>
			</c:if>
     </ul>
    </div>
    </c:if>
  </div>
</nav>
</header>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!--     <style>
    #wrapper{
		  height: auto;
		  min-height: 100%;
		  padding-bottom: 100px;
		}
    </style> -->
</body>
</html>