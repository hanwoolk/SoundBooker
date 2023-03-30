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
	<style>
		h1,p {text-align: center;}
		h1 {padding :50px;}
		th{padding-right:30px;		}
		#wrapper {
	    justify-content: center;
	    align-items: center;
	    height: 714px;
	    margin: 100px auto 100px auto;
		}
		.content {
			width:520px;
			margin:0 auto;
		  font-family: system-ui, serif;
		  font-size: 2rem;
		  padding: 40px;
		  border-radius: 10px;
		  border:1px solid gray;
		  background-color: #6A56C7;
		  color: #EFC53F;
		}
		.bttn{
			all: unset;
		  background-color:#6A56C7;
		  color: #EFC53F;
		  font-size:1em;
		  font-weight:1.1em;
		  padding-top:20px;
		  margin:0 30px 0 30px;
		}
	</style>
</head>
<body>
	<c:if test="${not empty  joinResult}">
		<script>
			alert('${joinResult}');
		</script>
	</c:if>
	<c:if test="${not empty  joinErrorMsg}">
		<script>
			alert('${joinErrorMsg}');
			history.back();
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<form action="${conPath }/login.do" method="post" id="content_form">
		<input type="hidden" name="method" value="${param.method }">
		<input type="hidden" name="fnum" value="${param.fnum }">
		<div id="wrapper">
			<h1>사용자 로그인</h1>
			<div class="content">
			<table>
				<tr>
					<th>ID</th><td><input type="text" name="mid" value="${mid}" required="required"></td>
				</tr>
				<tr>
					<th>PW</th><td><input type="password" name="mpw" required="required"></td>
				</tr>
				<tr>
					<td colspan="2">
						<p>
							<input type="submit" value="로그인" class="bttn">
							<input type="button" value="회원가입" onclick="location='${conPath}/joinView.do'" class="bttn">
						</p>
					</td>
				</tr>
			</table>
			</div>
		</div>
	</form>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>