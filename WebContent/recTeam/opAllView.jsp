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
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
  </script>
 	<style>
		#wrapper {
		    justify-content: center;
		    align-items: center;
		    height: 597px;
		    margin: 100px auto 100px auto;
		}
  	.h3{padding-top:30px; padding-bottom:30px; text-align:center;}
  	.board_list{
  		border-spacing: 30px;
  		width:1000px;
  		margin: 0 auto;
  		text-align:center;
  		argin: 20px auto;
  		border: 1px solid gray;
  		box-shadow: 1px 1px gray;
  	}
  	
  	table tr {width:100%; cursor:pointer; background-color:white;/* #f7f3ba */;}
  	table tr:hover{background-color:#dedaa4;}
  	table tr:first-child { background-color:#b5b391;}
  	table tr .num{width:15%;}
  	table tr .id{width:15%;}
  	table tr .title{width:30%; text-align:left;}
  	table tr .ip{width:15%;}
  	table tr .rdate{width:15%;}
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
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div class="table_wrapper">
			<c:set var="SUCCESS" value="1"/>
			<c:set var="FAIL" value="0"/>
			<c:if test="${not empty opJoinMSG}">
				<script>alert('${opJoinMSG}');</script>
			</c:if>
			<c:if test="${not empty modifyResult}">
				<script>alert('${modifyResult}');</script>
			</c:if>
			<div class="title"><h3>녹음 작업자 리스트</h3></div>
			<table class="board_list">
				<tr>
					<th>ID</th><th>비밀번호</th><th>이름</th><th>진행중 프로젝트</th><th>수정</th><th>초기화</th>
				</tr>
				<c:forEach var="dto" items="${OpList }">
					<tr>
						<td class="rid">${dto.rid }</td>
						<td>${dto.rpw }</td>
						<td>${dto.rname }</td>
						<td class="pnum">${dto.pnum }</td>
						<td><button onclick="location.href='${conPath}/opModifyView.do?rid=${dto.rid }'">수정</button></td>
						<td><button class="op_withdrawal" onclick="location.href='${conPath}/opWithdrawal.do?rid=${dto.rid }'">초기화</button></td>
					</tr>
				</c:forEach>
			</table>
			<div class="paging">
				<c:if test="${startPage > BLOCKSIZE}">
					[ <a href="${conPath }/opAllView.do?pageNum=${startPage-1}">이전</a> ]
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage}">
					<c:if test="${i eq pageNum }">
						[ <b>${i }</b> ]
					</c:if>
					<c:if test="${i != pageNum }">
						[ <a href="${conPath}/opAllView.do?pageNum=${i }">${i}</a> ]
					</c:if>
				</c:forEach>
				<c:if test="${endPage < pageCnt }">
					[ <a href="${conPath }/opAllView.do?pageNum=${endPage+1}">다음</a> ]
				</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>