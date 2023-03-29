<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		#join_wrapper{
		  height: auto;
		  min-height: 100%;
		  padding-bottom: 100px;
		}
		#join_wrapper .container{
			border: 1px solid gray;
			width : 500px;
			margin: 30px auto 0 auto;
			height:700px;
			padding-top:10px;
		
		}
		h1, h3, p {text-align: center;}
		p{margin-top: 30px;}
		table{ margin: 0 auto; padding:30px;}
		table tr td input[type=text],input[type=password]  {
			width:300px;
			}
		.must_fill{
			font-weight:bold;
			color:red;
		}
		.explain{
			font-style:italic;
			font-size:0.7em;
			text-align:right;
		}
	</style>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  ////////////////////////////////////////////////////////// mnamePhoneConfirmResult 해결해야함
  	$(function(){
  		$('.rpw, .rpwChk').keyup(function(){
  			var rpw = $('.rpw').val();
  			var rpwChk = $('.rpwChk').val();
  			if(rpw == rpwChk){
  				$('.rpwChkResult').text('비밀번호 일치');
  			}else{
  				$('.rpwChkResult').text('비밀번호 불일치');
  			}
 			});//keyup event(비밀번호 일치 확인용)
  		
  		$('form').submit(function(){
  		// "사용 가능한 ID입니다"(#idConfirmResult),"비밀번호 일치"(pwChkResult)가 출력 되었을때만 submit
  			var rpwChkResult = $('.rpwChkResult').text().trim();
  			if(rpwChkResult != '비밀번호 일치'){
  				alert('비밀번호를 확인하세요');
  				$('.rpw').focus();
  				return false;
  			}
			});
  	});
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div class="container">
			<form action="${conPath }/opJoin.do" method="get">
				<h3>신규 작업자 등록</h3>
				<table>
					<tr><th>이름</th>
						<td>
							<input type="text" name="rname" class="mname" required="required">
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="rid" value="${opid }" required="required">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="rpw" class="rpw" required="required" placeholder="0으로 초기화된 상태">
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input type="password" name="rpwChk" class="rpwChk" required="required">
							<div class="rpwChkResult"> &nbsp; &nbsp; &nbsp;</div>
						</td>
					</tr>
					<tr>
						<td>
							<p>
								<input type="submit" value="등록">
								<input type="reset" value="초기화">
								<input type="button" value="로그인" onclick="location='${conPath}/recTeamLoginView.do'">
							</p>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>