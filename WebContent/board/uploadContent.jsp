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
  <link href="${conPath }/css/style.css" rel="stylesheet">
  <style>

  </style>
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
   	$(function(){ //댓글 수정버튼 클릭시 글 내용이 수정 창으로 변겅
  		$('#comment_modify').click(function(){
  			var urcontent = $('#urcontent').text();
				$('#urcontent').replaceWith('<pre><textarea rows="5" cols="20" name="urcontent">'+urcontent+'</textarea></pre>');
				$('#comment_modify').replaceWith('<button>수정</button>');
  		});
  	});
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${modifyResult eq SUCCESS }">
			<script>alert('${param.unum}번 글 수정 성공')</script>
		</c:if>
		<c:if test="${modifyResult eq FAIL }">
			<script>
				alert('${param.unum}번 글 수정 실패')
				history.back();
			</script>
		</c:if>
	<%-------------------------------- 업로드 게시판 상세보기 ---------------------------%>
		<table>
			<caption>상세보기</caption>
			<tr><th>작성자</th><td>${uploadContents.rid}님</td></tr>
			<tr><th>제목</th><td>${uploadContents.utitle }</td></tr>
			<tr><th>본문</th><td><pre>${uploadContents.ucontent }</pre></td></tr>
			<tr><th>첨부파일</th>
			<c:if test="${recteam.rjob eq 'PROJECT_MANAGER' }">
				<td><a href="${conPath }/uploadFiles/${uploadContents.ufilename }">${uploadContents.ufilename }</a></td>
			</c:if>
			<c:if test="${recteam.rjob != 'PROJECT_MANAGER' }">
				<td>${uploadContents.ufilename }</td>
			</c:if>
			</tr>
			<tr>
				<td colspan="2">
					<c:if test="${recteam.rjob eq 'PROJECT_MANAGER'}">	
						<button onclick="location.href='${conPath}/uploadModifyView.do?unum=${param.unum }&pageNum=${param.pageNum }'">수정</button>
						<button onclick="location.href='${conPath}/uploadDelete.do?unum=${param.unum }&pageNum=${param.pageNum }'">삭제</button>
					</c:if>
					<button onclick="location.href='${conPath}/uploadReplyView.do?unum=${param.unum }&pageNum=${param.pageNum }'">답변</button>
					<button onclick="location.href='${conPath}/uploadList.do?pageNum=${param.pageNum }'">목록</button>
				</td>
			</tr>
		</table>
		<br><br><br>
	<%-------------------------------- 댓글 달기  ---------------------------%>
 		<form action="${conPath }/uCommentWrite.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum}">
			<input type="hidden" name="unum" value="${param.unum}">
			<input type="hidden" name="rid" value="${recteam.rid}">
			<fieldset>
				<legend>댓글 달기</legend>
				<textarea rows="5" cols="20" name="urcontent"></textarea>
			</fieldset>
			<input type="submit" value="등록">
		</form>
	</div>
	<%----------------------------------- 댓글 보기 ------------------------------%>
			<c:forEach var="dto" items="${uploadComments}">
				<form action="${conPath}/uCommentModify.do" method="post">
					<input type="hidden" name="unum" value=${dto.unum }>
					<input type="hidden" name="urnum" value=${dto.urnum }>
					<input type="hidden" name="pageNum" value=${param.pageNum }>
					<hr>
					${dto.rid } 님 | <fmt:formatDate value="${dto.urrdate }" pattern="yy-MM-dd hh:mm"/><br>
						<pre id="urcontent">${dto.urcontent }</pre>
					<br>
					<c:if test="${not empty dto.rid and dto.rid eq recteam.rid}">
						<span><a id="comment_modify">수정 </a></span>
						<span><a href="${conPath}/uCommentDelete.do?unum=${dto.unum}&urnum=${dto.urnum}">삭제</a></span><br>
					</c:if>
				</form>
			</c:forEach>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>