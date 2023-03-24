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
	  $(document).ready(function(){
	  	$('tr').click(function(){
	  		var unum =$(this).children().eq(0).text().trim();
	  		if(!isNaN(Number(unum))){
	  			location.href='${conPath }/uploadContent.do?unum='+unum+'&pageNum=${pageNum}';
	  		}
	  	});
	  });
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${not empty writeErrorMsg}">
			<script>alert('${uploadErrorMsg}');</script>
		</c:if>
		<c:if test="${modifyResult eq FAIL }">
			<script>
				alert('${param.unum}번 글 수정 실패');
				history.back();
			</script>
		</c:if>
		<c:if test="${not empty deleteResult }">
			<script>
				alert('${deleteResult}');
			</script>
		</c:if>
		<c:if test="${replyResult eq FAIL }">
			<script>
				alert('${param.unum}번 글의 답변글 쓰기 실패')
				history.go(-1);
			</script>
		</c:if>
		
		<table>
			<caption>게시판</caption>
			<tr><td><a href="${conPath}/uploadWriteView.do">글쓰기</a></td></tr>
		</table>
		<table>
			<tr>
				<th>글번호</th><th>작성자ID</th><th>글제목</th>
				<th>IP</th><th>작성일</th>
			</tr>
			<c:if test="${uploadList.size() eq 0 }">
				<tr>
					<td colspan="5">해당 페이지의 글이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${uploadList.size() != 0 }">
				<c:forEach var="dto" items="${uploadList }">
					<tr>
						<td>${dto.unum }</td>
						<td>${dto.rid }</td>
						<td class="left">
							<c:forEach var="i" begin="1" end="${dto.uindent }">
								<c:if test="${i != dto.uindent}">
									&nbsp; &nbsp;
								</c:if>
								<c:if test="${i eq dto.uindent }">
									└
								</c:if>
							</c:forEach> <!-- 답글 들여쓰기 처리 -->
							${dto.utitle} [${dto.ubCommentCnt}]
						</td>
						<td>${dto.uip }</td>
						<td>
							<fmt:formatDate value="${dto.urdate }" pattern="yy/MM/dd(E)"/>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE}">
				[ <a href="${conPath }/uploadList.do?pageNum=${startPage-1}">이전</a> ]
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage}">
				<c:if test="${i eq pageNum }">
					[ <b>${i }</b> ]
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath}/uploadList.do?pageNum=${i }">${i}</a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				[ <a href="${conPath }/uploadList.do?pageNum=${endPage+1}">다음</a> ]
			</c:if>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>