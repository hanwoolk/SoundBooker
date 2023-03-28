<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
  <style>
  	*{margin:0; padding:0;}
  	#wrapper{min-height:100%; padding-bottom:100px;
  	}
		.project_table{
			width:1000px;
			margin:60px auto 0 auto;
			border:1px solid gray;
		}
		.rdate{text-align:right; font-style:italic; padding-right:30px;}
		.project_table tr td{height:40px;}
		.pname{text-align:left; font-size:1.3em; font-weight:bold; margin:5px 0px 5px 10px;}
		.category_writer{font-style:italic;}
		.category_content{background-color:gray; text-align:left;}
		.content{height:300px;}
		.project_content{ margin:0; padding: 15px; text-algin:top; display:inline-block;}
		span{font-weight:bold;}
		.buttons{ text-align:center; margin:10px auto;}
		.button{ width:40px; border:none; margin:0 5px;}
		.comment{width:1000px; margin:0 auto;}
		textarea {width:1000px;}
		form{width:1000px; margin:0 auto;}
  </style>
  <script>
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div>
			<c:set var="SUCCESS" value="1"/>
			<c:set var="FAIL" value="0"/>
			<c:if test="${modifyResult eq SUCCESS }">
				<script>alert('${param.pnum}번 글 수정 성공')</script>
			</c:if>
			<c:if test="${modifyResult eq FAIL }">
				<script>
					alert('${param.pnum}번 글 수정 실패')
					history.back();
				</script>
			</c:if>
		<%-------------------------------- 자유 게시판 상세보기 ---------------------------%>
			<table class="project_table">
				<tr><td colspan="2"><p class="pname">${projectContent.pname }</p></td></tr>
				<%-- <tr><td class="writer"><span> &nbsp; 작성자 : </span>${projectManager.rid}(${projectManager.rname})님</td><td class="rdate">작성일: ${projectContent.prdate}</tr> --%>
				<tr><th colspan="2" class="category_content">&nbsp;&nbsp;상세내용</th></tr>
				<tr class="content">
					<td colspan="2" class="project_content">
						<pre class="project_content">${projectContent.pcontent }</pre>
					</td>
				</tr>
				<tr><th>프로젝트 시작일 : ${projectContent.pstartdate}</th><th>&nbsp;&nbsp;프로젝트 종료 예정일 : ${projectContent.penddate}</th></tr>
				<tr><th>모집 참여자 수: ${projectContent.pmember}명</th><th>&nbsp;&nbsp;투입 작업자 수: ${projectContent.pop}명</th></tr>
			</table>
			<div class="buttons">
				<%-- <c:if test="${not empty projectManager.rid and (projectManager.rid eq recteam.rid) and (recteam.rjob eq 'PROJECT_MANAGER')}"> --%>
					<button class="button" onclick="location.href='${conPath}/projectModifyView.do?pnum=${param.pnum }&pageNum=${param.pageNum }'">수정</button>
					<button class="button" onclick="location.href='${conPath}/projectDelete.do?pnum=${param.pnum }&pageNum=${param.pageNum }'">삭제</button>
				<%-- </c:if> --%>
				<button class="button" onclick="location.href='${conPath}/projectList.do?pageNum=${param.pageNum }'">목록</button>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>