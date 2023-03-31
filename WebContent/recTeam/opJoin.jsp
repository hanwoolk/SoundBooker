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
		table tr td:nth-last-child(1){text-align:center; padding:0;}
		table{margin:0 auto;}
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
		<div class="table_wrapper">
			<form action="${conPath }/opJoin.do" method="get">
				<div class="title"><h3>신규 작업자 등록</h3></div>
				<table class="board_list">
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
						<td colspan="2">
								<input type="submit" value="등록" class="bttn">
								<input type="reset" value="다시 쓰기" class="bttn">
								<input type="button" value="로그인" onclick="location='${conPath}/recTeamLoginView.do'" class="bttn">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>