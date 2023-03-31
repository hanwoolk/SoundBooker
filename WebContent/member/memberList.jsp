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
</head>
<style>
		#wrapper {
		    justify-content: center;
		    align-items: center;
		    height: 597px;
		    margin: 100px auto 100px auto;
		}
  	.title{padding-top:30px; padding-bottom:30px; text-align:center;}
  	.board_list{
  		border-spacing: 30px;
  		width:1400px;
  		margin: 0 auto;
  		text-align:center;
  		argin: 20px auto;
  		border: 1px solid gray;
  		box-shadow: 1px 1px gray;
  	}
  	board_list tr td{boder-right:1px solid gray;}
  	table tr {width:100%; cursor:pointer; background-color:white;/* #f7f3ba */;}
  	table tr:hover{background-color:#dedaa4;}
  	table tr:first-child { background-color:#b5b391;}
  	.paging {
  		width:100%;
  		position:absolute;
  		bottom:150px;
  		text-align:center;
  	}
  	.title{text-align:center;}
  	.posting{
	  	width:100%;
	  	margin:0 auto;
	  	text-align:center;
	  	position:absolute;
	  	bottom:250px;
  	}
</style>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<h3 class="title">신청자 목록</h3>
		<table class="board_list">
			<tr>
				<th >ID</th><th>이름</th><th>참여중 프로젝트ID</th><th>신청중 프로젝트ID</th><th>생년월일</th><th>성별</th><th>휴대폰번호</th><th>출신지</th>
				<th>거주지</th><th>운전 가능여부</th><th>선호시간1</th><th>선호시간2</th><th>선호시간3</th><th>녹음 횟수</th><th>계좌 정보</th>
			</tr>
			<c:forEach var="dto" items="${mList }">
				<tr>
					<td>${dto.mid }</td>
					<td>${dto.mname}</td>
					<td>${dto.pnum }</td>
					<td>${dto.pnumreg }</td>
					<td>${dto.mbirth }</td>
					<td>${dto.mgender eq 'M'? '남':'여'}</td>
					<td>${dto.mphone }</td>
					<td>${dto.morigin eq 'N'? '내국인':'외국인'}</td>
					<td>${dto.maddress eq null? '-':mdto.maddress}</td>
					<td>${dto.mdrive  eq 'N'? '불가(확인필요)':'가능'}</td>
					<td>${dto.mprefer1 eq null? '-':mdto.mprefer1}</td>
					<td>${dto.mprefer2 eq null? '-':mdto.mprefer2}</td>
					<td>${dto.mprefer3 eq null? '-':mdto.mprefer3}</td>
					<td>${dto.rcnt }회</td>
					<td>${dto.mbank } : ${dto.maccount }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
			<div class="paging">
				<c:if test="${startPage > BLOCKSIZE}">
					[ <a href="${conPath }/memberList.do?pageNum=${startPage-1}">이전</a> ]
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage}">
					<c:if test="${i eq pageNum }">
						[ <b>${i }</b> ]
					</c:if>
					<c:if test="${i != pageNum }">
						[ <a href="${conPath}/memberList.do?pageNum=${i }">${i}</a> ]
					</c:if>
				</c:forEach>
				<c:if test="${endPage < pageCnt }">
					[ <a href="${conPath }/memberList.do?pageNum=${endPage+1}">다음</a> ]
				</c:if>
			</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>