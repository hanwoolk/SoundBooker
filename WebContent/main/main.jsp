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
	#wrapper {
		height: auto;
	  min-height: 100%;
	  padding-bottom: 100px;
	}
  
</style>
</head>
<body>
	<c:if test="${param.method eq 'write'}">
		<script>
			location.href = '${conPath}/boardWriteView.do';
		</script>
	</c:if>
	<c:if test="${param.method eq 'modify'}">
		<script>
			location.href = '${conPath}/modifyView.do.do?mid=${param.mid}';
		</script>
	</c:if>
	<c:if test="${not empty activateId}">
		<script>
			alert('${activateId}');
		</script>
	</c:if>
	<c:if test="${not empty loginErrorMsg }">
		<script>
			alert('${loginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty rtLoginErrorMsg }">
		<script>
			alert('${rtLoginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty withdrawalResult }">
		<script>
			alert('${withdrawalResult}');
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
			main
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>