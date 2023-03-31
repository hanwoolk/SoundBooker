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
  <style>
		#wrapper {
		  justify-content: center;
		  align-items: center;
		  height:697px;
		  min-height: 100%;
		  padding-bottom:100px ;
		}
		.title{text-align:center;}
		p{margin-top: 30px;}
		table tr th{width:160px; text-align:right; padding-right:30px;}
		table tr td{padding:2px; padding-left:30px;}
		.table_wrapper{
			width:500px;
		  border-radius: 10px;			
			margin: 100px auto 0 auto; 
			border:1px solid gray; 
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
		p {text-align: center;}
		.bttn {
		    all: unset;
		    font-size: 1em;
		    padding-top: 20px;
		    margin: 0 20px 20px;
		}
  </style>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<form action="${conPath }/opModify.do" method="get">
			<input type="hidden" name="dbRpw" value="${OpDto.rpw}">
			<input type="hidden" name="rjob" value="${OpDto.rjob}">
			<input type="hidden" name="pnum" value="${OpDto.pnum}">
			<div id="wrapper">
				<div class="table_wrapper">
				<h3 class="title">정보수정</h3>
					<table class="rt_modify_table">
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
								<input type="submit" value="정보수정" class="bttn">
								<input type="reset" value="다시 쓰기" class="bttn">
								<input type="reset" value="이전" onclick="history.back()" class="bttn">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>