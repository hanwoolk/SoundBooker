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
  		$('input[name="mid"]').keyup(function(){
  			var mid = $(this).val();
  			if(mid.length<2){
  				$('#midConfirmResult').text('아이디는 2글자 이상');
  			}else{
  				$.ajax({
  					url : '${conPath}/midConfirm.do',
  					type : 'get',
  					data : 'mid='+mid,
  					dataType : 'html',
  					success : function(data){
  						$('#midConfirmResult').html(data);
  					},
  				}); // ajax 함수
  			} //if
  		});// keyup event
  		
	 		$('input[name="mphone"]').keyup(function(){
	 			var mphone = $(this).val();
	 			//if(mphone.length<11){
				//		$('#mnamePhoneConfirmResult').text("");
				//	}else{
		 				var mname = $('input[name="mname"]').val();
		 				$.ajax({
		 					url : '${conPath}/mnamePhoneConfirm.do',
		 					type : 'get',
		 					data : 'mphone='+mphone+'&mname='+mname,
		 					dataType : 'html',
		 					success : function(data){
		 						$('#mnamePhoneConfirmResult').html(data);
		 					},
		 				}); // ajax 함수
					//}
	  		});// keyup event
  		
  		$('#mpw, #mpwChk').keyup(function(){
  			var mpw = $('#mpw').val();
  			var mpwChk = $('#mpwChk').val();
  			if(mpw == mpwChk){
  				$('#mpwChkResult').text('비밀번호 일치');
  			}else{
  				$('#mpwChkResult').text('비밀번호 불일치');
  			}
 			});//keyup event(비밀번호 일치 확인용)
  		
  		$('form').submit(function(){
  		// "사용 가능한 ID입니다"(#idConfirmResult),"비밀번호 일치"(pwChkResult)가 출력 되었을때만 submit
				var midConfirmResult = $('#midConfirmResult').text().trim();
  			var mpwChkResult = $('#mpwChkResult').text().trim();
  			var mnamePhoneConfirmResult = $('#mnamePhoneConfirmResult').text().trim();
  			if(midConfirmResult != '사용 가능한 ID입니다'){
  				alert('사용 가능한 ID가 아닙니다');
  				return false; //submit 제한
  			}else if(mpwChkResult != '비밀번호 일치'){
  				alert('비밀번호를 확인하세요');
  				$('#mpw').focus();
  				return false;
  			}else if(mnamePhoneConfirmResult != "가입 가능합니다"){
  				alert('이미 가입되어 있는지 확인해주세요');
  				$('#mname').focus();
  				return false;
  			}
			});
  	});
  </script>
<%-------------------------------------------datepicker----------------------------------------------------%>

  <script>
  $( function() {
    $( "#datepicker" ).datepicker({
    	dateFormat: 'yy-mm-dd',
    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	showOtherMonths: true,
    	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    	showMonthAfterYear: true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
    	yearSuffix: '년',
      changeYear: true,
      // minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
      minDate: new Date(1950, 1 - 1, 1),
      maxDate: 'y', // 현재 날짜 이전만 표시
	  	yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
    });
  });
  
<%-------------------------------------------datepicker----------------------------------------------------%>
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div class="container">
			<form action="${conPath }/join.do" method="post" id="content_form">
				<h3>회원가입</h3>
				<table>
					<tr>
						<th>아이디<span class="must_fill">*</span></th>
						<td>
							<input type="text" name="mid" id="mid" class="mid" required="required" autofocus="autofocus">
							<div id = "midConfirmResult"> &nbsp; &nbsp; &nbsp;</div>
						</td>
					</tr>
					<tr>
						<th>비밀번호<span class="must_fill">*</span></th>
						<td>
							<input type="password" name="mpw" id="mpw" class="mpw" required="required">
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인<span class="must_fill">*</span></th>
						<td>
							<input type="password" name="mpwChk" id="mpwChk" class="mpwChk" required="required">
							<div id="mpwChkResult"> &nbsp; &nbsp; &nbsp;</div>
						</td>
					</tr>
					<tr><th>이름<span class="must_fill">*</span></th>
						<td>
							<input type="text" name="mname" class="mname" id="mname" required="required">
							<div id="mnamePhoneConfirmResult"> &nbsp; &nbsp; &nbsp;</div>
						</td>
					</tr>
					<tr><th>생년월일<span class="must_fill">*</span></th>
						<td>
							<input type="text" name="mbirth" id="datepicker" class="mbirth" required="required">
						</td>
					</tr>
					<tr><th>성별<span class="must_fill">*</span></th>
						<td>
							<input type="radio" name="mgender" value="m" required="required">남성
							<input type="radio" name="mgender" value="f">여성
						<td>
					</td>
					<tr><th>전화번호<span class="must_fill">*</span></th>
						<td>
							<input type="text" name="mphone" required="required">
							<div id="mnamePhoneConfirmResult"> &nbsp; &nbsp; &nbsp;</div>
						</td>
					</tr>
					<tr><th>국적<span class="must_fill">*</span></th>
						<td>
							<input type="radio" name="morigin" value="n" checked="checked" required="required">내국인
							<input type="radio" name="morigin" value="i">외국인
						<td>
					<tr><th>주소</th><td><input type="text" name="maddress" ></td></tr>
					<tr><th>운전 가능 여부</th>
						<td>
							<input type="radio" name="mdrive" value="n" checked="checked">불가능
							<input type="radio" name="mdrive" value="y">가능
						<td>
					<tr><th>선호 녹음 시간1 &nbsp;&nbsp;</th><td><input type="text" name="mprefer1"></td></tr>
					<tr><th>선호 녹음 시간2</th><td><input type="text" name="mprefer2"></td></tr>
					<tr><th>선호 녹음 시간3</th><td><input type="text" name="mprefer3"></td></tr>
					<tr>
						<th>은행<span class="must_fill">*</span></th>
					<td>
						<select name="mbank" required="required">
					   <option value="">은행명을 선택하세요</option>
					   <option value="경남은행">경남은행</option>
					   <option value="광주은행">광주은행</option>
					   <option value="국민은행">국민은행</option>
					   <option value="기업은행">기업은행</option>
					   <option value="농협중앙회">농협중앙회</option>
					   <option value="농협회원조합">농협회원조합</option>
					   <option value="대구은행">대구은행</option>
					   <option value="도이치은행">도이치은행</option>
					   <option value="부산은행">부산은행</option>
					   <option value="산업은행">산업은행</option>
					   <option value="상호저축">상호저축은행</option>
					   <option value="새마을금고">새마을금고</option>
					   <option value="수협중앙회">수협중앙회</option>
					   <option value="신한금융투자">신한금융투자</option>
					   <option value="신한은행">신한은행</option>
					   <option value="신협중앙회">신협중앙회</option>
					   <option value="외환은행">외환은행</option>
					   <option value="우리은행">우리은행</option>
					   <option value="우체국">우체국</option>
					   <option value="전북은행">전북은행</option>
					   <option value="제주은행">제주은행</option>
					   <option value="카카오뱅크">카카오뱅크</option>
					   <option value="케이뱅크">케이뱅크</option>
					   <option value="하나은행">하나은행</option>
					   <option value="한국씨티은행">한국씨티은행</option>
					   <option value="HSBC은행">HSBC은행</option>
					   <option value="SC제일은행">SC제일은행</option>
						</select>
					</td>
				</tr>
				<tr><th>계좌번호<span class="must_fill">*</span></th><td><input type="text" name="maccount" placeholder="-없이 입력" required="required"></td></tr>
					<tr>
						<td colspan="2">
						<p class="explain">필수 입력사항<span class="must_fill">*</span></p>
							<p>
								<input type="submit" value="회원가입" class="btn">
								<input type="button" value="로그인" onclick="location='${conPath}/loginView.do'" class="btn">
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