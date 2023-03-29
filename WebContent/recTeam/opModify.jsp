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
  <script>
  </script>
</head>
<body>
	<form action="${conPath }/opModify.do" method="get">
		<input type="hidden" name="dbRpw" value="${OpDto.rpw}">
		<input type="hidden" name="rjob" value="${OpDto.rjob}">
		<input type="hidden" name="pnum" value="${OpDto.pnum}">
		<div id="wrapper">
			<table>
				<caption>정보수정</caption>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="rid" value="${OpDto.rid }" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="oldRpw" required="required" ></td>
				</tr>
				<tr>
					<th>바꿀 비밀번호</th>
					<td>
						<input type="password" name="rpw" >
						<div class="rpwChkResult"> &nbsp; &nbsp; &nbsp;</div>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="rname" required="required" value="${OpDto.rname }"></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center">
						<input type="submit" value="정보수정" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="reset" value="이전" onclick="history.back()" class="btn">
					</td>
				</tr>
			</table>
		</div>
	</form>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>