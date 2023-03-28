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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<form action="${conPath }/uploadReply.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="unum" value="${param.unum }">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<input type="hidden" name="ugroup" value="${replyBoard.ugroup }">		<!-- 원글 -->
			<input type="hidden" name="ustep" value="${replyBoard.ustep }">			<!-- 원글 -->
			<input type="hidden" name="uindent" value="${replyBoard.uindent }"> <!-- 원글 -->
			<table>
				<caption>${param.unum }번의 답변글 쓰기</caption>
				<tr>
					<th>작성자</th>
					<td>
						<input type="text" name="rid" required="required" readonly="readonly" value="${recteam.rid }" > 
					</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td>
						<input type="text" name="utitle" required="required" value="[re]" placeholder="${replyBoard.utitle }">
					</td>
				</tr>
				<tr>
					<th>본문</th>
					<td>
						<textarea rows="5" cols="20" name="ucontent"></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><input type="file" name="ufilename"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="답글쓰기" class="btn">
						<input type="reset" value="취소" class="btn">
						<input type="button" value="목록" class="btn"
							onclick="location.href='${conPath}/uploadList.do?pageNum=${param.pageNum }'">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>