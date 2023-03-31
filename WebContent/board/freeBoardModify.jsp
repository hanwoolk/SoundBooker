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
<style>
		#wrapper {
		  justify-content: center;
		  align-items: center;
		  height:697px;
		  min-height: 100%;
		  padding-bottom:100px ;
		}
	table{width: 500px; margin:0 auto 30px auto;}
	table tr th{width:160px; text-align:right; margin-left:30px;}
	table tr td{padding:10px; padding-left:20px;}
	table tr td:nth-last-child(1){padding:10px; text-align:center;}
	h3{text-align:center;padding:30px;}
		.title{text-align:center;}
		p{margin-top: 30px;}
		.table_wrapper{
			width:500px;
			margin: 0 auto; 
			box-shadow:4px 4px #EFC53F;
			padding:30px 10px 10px 10px;}
		}
		h3 {
	    display: block;
	    font-size: 1.17em;
	    margin-block-start: 1em;
	    margin-block-end: 1em;
	    margin-inline-start: 0px;
	    margin-inline-end: 0px;
	    font-weight: bold;
		}
		h1,p {text-align: center;}
		h1 {padding :50px;}
		th{ptext-align:right;}
		.content {
			width:520px;
			margin:100px auto 0 auto;
		  font-family: system-ui, serif;
		  border-radius: 10px;
		  border:1px solid gray;
		  box-shadow: 3px 3px #EFC53F;
		}

</style>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<c:if test="${member eq null  and recteam eq null}">
		<script>
			alert('로그인이 필요합니다')
			location.href="${conPath }/member/login.jsp?fnum=${param.fnum}&method=FBmodify";
		</script>
	</c:if>
		<form action="${conPath }/freeBoardModify.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<input type="hidden" name="fnum" value="${param.fnum }">
			<div class="content">
				<h3>${param.fnum }번 글 수정</h3>
				<table>
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
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>