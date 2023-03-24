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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<c:if test="${member eq null  and recteam eq null}">
		<script>
			alert('로그인이 필요합니다')
			location.href="${conPath }/member/login.jsp?fnum=${param.fnum}&method=modify";
		</script>
	</c:if>
		<form action="${conPath }/freeBoardModify.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<input type="hidden" name="fnum" value="${param.fnum }">
			<table>
				<caption>${param.fnum }번 글 수정</caption>
				<c:if test="${not empty modifyBoard.mid}">
					<tr>
						<th>작성자</th><td><input type="text" name="mid" value="${modifyBoard.mid }" required="required" autofocus="autofocus" readonly="readonly"></td>
					</tr>
				</c:if>
				<c:if test="${not empty modifyBoard.rid}">
					<tr>
						<th>작성자</th><td><input type="text" name="rid" value="${modifyBoard.rid }" required="required" autofocus="autofocus" readonly="readonly"></td>
					</tr>
				</c:if>
				<tr>
					<th>제목</th><td><input type="text" name="ftitle" value="${modifyBoard.ftitle }" required="required"></td>
				</tr>
				<tr>
					<th>본문</th><td><pre><textarea rows="5" name="fcontent">${modifyBoard.fcontent }</textarea></pre></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="저장" class="btn">
						<input type="reset" value="취소" class="btn" onclick="history.back()">
						<input type="button" value="목록" class="btn" onclick="location.href='${conPath }/freeBoardList.do?pageNum=${param.pageNum}'">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>