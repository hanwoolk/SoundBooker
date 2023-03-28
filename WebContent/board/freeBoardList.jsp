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
	  $(document).ready(function(){
	  	$('tr').click(function(){
	  		var fnum =$(this).children().eq(0).text().trim();
	  		if(!isNaN(Number(fnum))){
	  			location.href='${conPath }/freeBoardContent.do?fnum='+fnum+'&pageNum=${pageNum}';
	  		}
	  	});
	  });
  </script>
  <style>
  	#wrapper{
  		width:1000px;
  		margin:0 auto;
  		text-align:center;
  	}
  	h3{padding-top:30px; padding-bottom:30px;}
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
  	
  	.posting{
  	width:800px;
  	margin:0 auto;
  	text-align:center;
  	}
  </style>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${writeResult eq SUCCESS }">
			<script>alert('글쓰기 성공');</script>
		</c:if>
		<c:if test="${not empty writeErrorMsg}">
			<script>alert('${writeErrorMsg}');</script>
		</c:if>
		<c:if test="${modifyResult eq SUCCESS }">
			<script>alert('수정 성공');</script>
		</c:if>
		<c:if test="${modifyResult eq FAIL }">
			<script>
				alert('${param.fnum}번 글 수정 실패');
				history.back();
			</script>
		</c:if>
		<c:if test="${not empty deleteResult }">
			<script>
				alert('${deleteResult}');
			</script>
		</c:if>
		<c:if test="${replyResult eq SUCCESS }">
			<script>alert('${param.fnum}번 글의 답변글 쓰기 성공')</script>
		</c:if>
		<c:if test="${replyResult eq FAIL }">
			<script>
				alert('${param.fnum}번 글의 답변글 쓰기 실패')
				history.go(-1);
			</script>
		</c:if>
		<h3>자유 게시판</h3>
		<table class="board_list">
			<tr>
				<th>글번호</th><th>작성자ID</th><th>글제목</th>
				<th>IP</th><th>작성일</th>
			</tr>
			<c:if test="${fbList.size() eq 0 }">
				<tr>
					<td colspan="5">해당 페이지에 글이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${fbList.size() != 0 }">
				<c:forEach var="dto" items="${fbList }">
					<tr>
						<td class="num">${dto.fnum }</td>
						<c:if test="${not empty dto.mid }">
							<td class="id" >${dto.mid }</td>
						</c:if>
						<c:if test="${not empty dto.rid }">
							<td class="id" >${dto.rid }</td>
						</c:if>
						<td class="title" >
							${dto.ftitle} [${dto.fbCommentCnt}]
						</td>
						<td class="ip" >${dto.fip }</td>
						<td class="rdate" >
							<fmt:formatDate value="${dto.frdate }" pattern="yy/MM/dd(E)"/>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
		<div class="paging">
			<c:if test="${startPage > BLOCKSIZE}">
				[ <a href="${conPath }/freeBoardList.do?pageNum=${startPage-1}">이전</a> ]
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage}">
				<c:if test="${i eq pageNum }">
					[ <b>${i }</b> ]
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath}/freeBoardList.do?pageNum=${i }">${i}</a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				[ <a href="${conPath }/freeBoardList.do?pageNum=${endPage+1}">다음</a> ]
			</c:if>
		</div>
	<br>
	<div class="posting">
		<button  onclick='location.href="${conPath}/freeBoardWriteView.do"'>글쓰기</button>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>