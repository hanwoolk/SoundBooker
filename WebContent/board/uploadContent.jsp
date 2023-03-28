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
  	*{margin:0; padding:0;}
  	#wrapper{min-height:100%; padding-bottom:100px;
  	}
		.upload_table{
			width:1000px;
			margin:60px auto 0 auto;
			border:1px solid gray;
		}
		.rdate{text-align:right; font-style:italic; padding-right:30px;}
		.upload_table tr td{height:40px;}
		.utitle{text-align:left; font-size:1.3em; font-weight:bold; margin:5px 0px 5px 10px;}
		.category_writer{font-style:italic;}
		.category_content{background-color:gray; text-align:left;}
		.content{height:300px;}
		.upload_content{ margin:0; padding: 15px; text-algin:top; display:inline-block;}
		span{font-weight:bold;}
		.buttons{ text-align:center; margin:10px auto;}
		.button{ width:40px; border:none; margin:0 5px;}
		.comment{width:1000px; margin:0 auto;}
		textarea {width:1000px;}
		form{width:1000px; margin:0 auto;}
  </style>
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
   	$(function(){ //댓글 수정버튼 클릭시 글 내용이 수정 창으로 변겅
  		$('.comment_modify').click(function(){
  			var urcontent = $('.urcontent').text();
				$('.urcontent').replaceWith('<pre><textarea rows="5" cols="20" name="urcontent">'+urcontent+'</textarea></pre>');
				$('.comment_modify').replaceWith('<button>수정</button>');
  		});
  	});
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${modifyResult eq SUCCESS }">
			<script>alert('${param.unum}번 글 수정 성공')</script>
		</c:if>
		<c:if test="${modifyResult eq FAIL }">
			<script>
				alert('${param.unum}번 글 수정 실패')
				history.back();
			</script>
		</c:if>
	<%-------------------------------- 업로드 게시판 상세보기 ---------------------------%>
		<table class="upload_table">
			<tr><td colspan="2"><p class="utitle">${uploadContents.utitle }</p></td></tr>
			<tr><td class="writer"><span> &nbsp; 작성자 : </span>${uploadContents.rid}님</td><td class="rdate">작성일: ${uploadContents.urdate}</tr>
			<tr><th colspan="2" class="category_content">&nbsp;&nbsp;본문</th></tr>
			<tr class="content">
				<td colspan="2" class="upload_content">
					<pre class="upload_content">${uploadContents.ucontent }</pre>
				</td>
			</tr>
			<tr><td colspan="2"><hr></td></tr>
			<tr>
			<c:if test="${recteam.rjob eq 'PROJECT_MANAGER' }">
				<td colspan="2"><span class="ufile"> &nbsp; 첨부파일 : </span><a href="${conPath }/uploadFiles/${uploadContents.ufilename }">${uploadContents.ufilename }</a></td>
			</c:if>
			<c:if test="${recteam.rjob != 'PROJECT_MANAGER' }">
				<td colspan="2"><span class="ufile"> &nbsp; 첨부파일 : </span>${uploadContents.ufilename }</td>
			</c:if>
			</tr>
		</table>
<!-- 			<table>
			<tr> -->
				<div class="buttons">
					<c:if test="${recteam.rjob eq 'PROJECT_MANAGER'}">	
						<button class="button" onclick="location.href='${conPath}/uploadModifyView.do?unum=${param.unum }&pageNum=${param.pageNum }'">수정</button>
						<button class="button" onclick="location.href='${conPath}/uploadDelete.do?unum=${param.unum }&pageNum=${param.pageNum }'">삭제</button>
					</c:if>
					<button class="button" onclick="location.href='${conPath}/uploadReplyView.do?unum=${param.unum }&pageNum=${param.pageNum }'">답변</button>
					<button class="button" onclick="location.href='${conPath}/uploadList.do?pageNum=${param.pageNum }'">목록</button>
				</div>
<!-- 			</tr>
		</table> -->
		<br><hr style="width:1400px; margin:0 auto;"><br><br>
	<%-------------------------------- 댓글 달기  ---------------------------%>
 		<form action="${conPath }/uCommentWrite.do" method="post">
			<input type="hidden" name="pageNum" value="${param.pageNum}">
			<input type="hidden" name="unum" value="${param.unum}">
			<input type="hidden" name="rid" value="${recteam.rid}">
			<fieldset class="comment">
				<legend>댓글 달기</legend>
				<textarea rows="5" cols="20" name="urcontent"></textarea>
			</fieldset>
			<input class="button" type="submit" value="등록">
		</form>
	</div>
	<%----------------------------------- 댓글 보기 ------------------------------%>
	<div class="comment">
		<c:forEach var="dto" items="${uploadComments}">
			<form action="${conPath}/uCommentModify.do" method="post">
				<input type="hidden" name="unum" value=${dto.unum }>
				<input type="hidden" name="urnum" value=${dto.urnum }>
				<input type="hidden" name="pageNum" value=${param.pageNum }>
				<hr>
				${dto.rid } 님 | <fmt:formatDate value="${dto.urrdate }" pattern="yy-MM-dd hh:mm"/><br>
					<pre class="urcontent">${dto.urcontent }</pre>
				<br>
				<c:if test="${not empty dto.rid and dto.rid eq recteam.rid}">
					<span><a class="comment_modify">수정 </a></span>
					<span><a href="${conPath}/uCommentDelete.do?unum=${dto.unum}&urnum=${dto.urnum}">삭제</a></span><br>
				</c:if>
			</form>
		</c:forEach>
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>