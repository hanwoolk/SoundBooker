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
</head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker1" ).datepicker({
    	dateFormat: 'yy-mm-dd',
    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	showOtherMonths: true,
    	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    	showMonthAfterYear: true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
    	yearSuffix: '년',
      changeYear: true,
      // minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
      minDate: 'y',
	  	yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
    });
    $( "#datepicker2" ).datepicker({
    	dateFormat: 'yy-mm-dd',
    	changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
    	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    	showOtherMonths: true,
    	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
    	showMonthAfterYear: true, // 현재 달이 아닌 달의 날짜도 회색으로 표시
    	yearSuffix: '년',
      changeYear: true,
      // minDate: '-100y',	 // 현재날짜로부터 100년이전까지 년을 표시한다.
	  	yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
    });
  });
  </script>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<c:if test="${recteam eq null}">
			<script>
				alert('로그인이 필요합니다')
				location.href="${conPath }/recTeam/recTeamLogin.jsp?pnum=${param.pnum}&method=projectModifyView";
			</script>
		</c:if>
		<form action="${conPath }/projectModify.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum }">
			<input type="hidden" name="pnum" value="${param.pnum }">
			<div class="content">
				<h3>${param.pnum }번 프로젝트 수정</h3>
				<table>
					<tr>
						<th>제목</th><td><input type="text" name="pname" value="${modifyProject.pname }" required="required"></td>
					</tr>
					<tr>
						<th>본문</th><td><pre><textarea rows="5" name="pcontent">${modifyProject.pcontent }</textarea></pre></td>
					</tr>
					<tr>
						<th>프로젝트 시작일</th>
						<td>
							<input type="text" id="datepicker1" name="pstartdate"  value="${modifyProject.pstartdate }" required="required">
						</td>
					</tr>
					<tr>
						<th>프로젝트 종료 예정일</th>
						<td>
							<input type="text" id="datepicker2" name="penddate" value="${modifyProject.penddate }" required="required">
						</td>
					</tr>
					<tr>
						<th>필요 참여자 수</th>
						<td>
							<input type="number" name="pmember" value="${modifyProject.pmember }" required="required">
						</td>
					</tr>
					<tr>
						<th>필요 작업자 수</th>
						<td>
							<input type="number" name="pop" value="${modifyProject.pop }" required="required">
						</td>
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