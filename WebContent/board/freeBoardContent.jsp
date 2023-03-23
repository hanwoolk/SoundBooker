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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${modifyResult eq SUCCESS }">
			<script>alert('${param.fnum}번 글 수정 성공')</script>
		</c:if>
		<c:if test="${modifyResult eq FAIL }">
			<script>
				alert('${param.fnum}번 글 수정 실패')
				history.back();
			</script>
		</c:if>
	<%-------------------------------- 자유 게시판 상세보기 ---------------------------%>
		<table>
			<caption>상세보기</caption>
			<c:if test="${not empty freeBoardContent.mid and empty freeBoardContent.rid}">
				<tr><th>작성자</th><td>${freeBoardContent.mid}님</td></tr>
			</c:if>
			<c:if test="${empty freeBoardContent.mid and not empty freeBoardContent.rid}">
				<tr><th>작성자</th><td>${freeBoardContent.rid}님</td></tr>
			</c:if>
			<tr><th>제목</th><td>${freeBoardContent.ftitle }</td></tr>
			<tr><th>본문</th><td><pre>${freeBoardContent.fcontent }</pre></td></tr>
			<tr>
				<td colspan="2">
					<c:if test="${(not empty freeBoardContent.mid and freeBoardContent.mid eq member.mid) or 
												(not empty freeBoardContent.rid and freeBoardContent.rid eq recteam.rid)}">
						<button onclick="location.href='${conPath}/freeBoardModifyView.do?fnum=${param.fnum }&pageNum=${param.pageNum }'">수정</button>
						<button onclick="location.href='${conPath}/freeBoardDelete.do?fnum=${param.fnum }&pageNum=${param.pageNum }'">삭제</button>
					</c:if>
					<button onclick="location.href='${conPath}/freeBoardList.do?pageNum=${param.pageNum }'">목록</button>
				</td>
			</tr>
		</table>
		<br><br><br>
	<%-------------------------------- 댓글 달기  ---------------------------%>
 		<form action="${conPath }/commentWrite.do?fnum=${param.fnum }&pageNum=${param.pageNum }" method="post">
			<c:if test="${not empty member.mid}">
 				<input type="hidden" name="mid" value="${member.mid}">
			</c:if>
			<c:if test="${not empty recteam.rid}">
 				<input type="hidden" name="rid" value="${recteam.rid}">
			</c:if>
			<fieldset>
				<legend>댓글 달기</legend>
				<textarea rows="5" cols="20" name="frcontent"></textarea>
			</fieldset>
			<input type="submit" value="등록">
		</form>
	</div>
	<%----------------------------------- 댓글 보기 ------------------------------%>
	<c:if test="${not empty freeComments}">
		<div id="comment">
			<c:forEach var="dto" items="${freeComments}">
				<hr>
					${dto.mid }${dto.rid } 님 | <fmt:formatDate value="${dto.frrdate }" pattern="yy-MM-dd hh:mm"/>
				<br>
					<pre>${dto.frcontent }</pre>
					<br>
					<c:if test="${(not empty dto.mid and dto.mid eq member.mid) or (not empty dto.rid and dto.rid eq recteam.rid)}">
						<span><a href="${conPath}/freeCommentmodify.do?fnum=${dto.fnum}&frnum=${dto.frnum}">수정</a></span>
						<span><a href="${conPath}/freeCommentDelete.do?fnum=${dto.fnum}&frnum=${dto.frnum}">삭제</a></span><br>
					</c:if>
			</c:forEach>
		</div>
	</c:if>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>