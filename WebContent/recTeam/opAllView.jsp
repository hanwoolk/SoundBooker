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
  <link href="${conPath }/css/style.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
/*    	$(document).ready(function(){--------------------------------------confirm 기능
  		$('.op_withdrawal').click(function(){
  			var rid = $(this).attr(id);
				if(confirm('작업자 정보를 초기화하시겠습니까?')){
					location.href='${conPath}/opWithdrawal.do?rid='+rid;
				} else return; 			
  		});
  	}); */
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${not empty opJoinMSG}">
			<script>alert('${opJoinMSG}');</script>
		</c:if>
		<c:if test="${not empty modifyResult}">
			<script>alert('${modifyResult}');</script>
		</c:if>
		<h3>녹음 작업자 리스트</h3>
		<table>
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
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>