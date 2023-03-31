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
		.free_table{
			width:1000px;
			margin:60px auto 0 auto;
			border:1px solid gray;
		}
		.rdate{text-align:right; font-style:italic; padding-right:30px;}
		.free_table tr td{height:40px;}
		.ftitle{text-align:left; font-size:1.3em; font-weight:bold; margin:5px 0px 5px 10px;}
		.category_writer{font-style:italic;}
		.category_content{background-color:gray; text-align:left;}
		.content{height:300px;}
		.free_content{ margin:0; padding: 15px; text-algin:top; display:inline-block;}
		span{font-weight:bold;}
		.buttons{ text-align:center; margin:10px auto;}
		.button{ width:40px; border:none; margin:0 5px;}
		.comment{width:1000px; margin:0 auto;}
		textarea {width:1000px;}
		form{width:1000px; margin:0 auto;}
		a{}
  </style>
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
   	$(function(){//댓글 수정버튼 클릭시 글 내용이 수정 창으로 변겅
  		$('.comment_modify').click(function(){
  			var frcontent = $('.frcontent').text();
				$('.frcontent').replaceWith('<pre><textarea rows="5" cols="20" name="frcontent">'+frcontent+'</textarea></pre>');
				$('.comment_modify').replaceWith('<button style="all: unset; cursor:pointer;">수정</button>');
  		});
  	});
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<div>
			<c:set var="SUCCESS" value="1"/>
			<c:set var="FAIL" value="0"/>
			<c:if test="${modifyResult eq SUCCESS }">
				<script>alert('${param.fnum}번 글 수정 성공')</script>
			</c:if>
			<c:if test="${modifyResult eq FAIL }">
				<script>
					alert('${param.fnum}번 글 수정 실패')
					history.back();
				</script>
			</c:if>
		<%-------------------------------- 자유 게시판 상세보기 ---------------------------%>
			<table class="free_table">
				<tr><td colspan="2"><p class="ftitle">${freeBoardContent.ftitle }</p></td></tr>
				<c:if test="${not empty freeBoardContent.mid and empty freeBoardContent.rid}">
					<tr><td class="writer"><span> &nbsp; 작성자 : </span>${freeBoardContent.mid}님</td><td class="rdate">작성일: ${freeBoardContent.frdate}</tr>
				</c:if>
				<c:if test="${empty freeBoardContent.mid and not empty freeBoardContent.rid}">
					<tr><td class="writer"><span> &nbsp; 작성자 : </span>${freeBoardContent.rid}님</td><td class="rdate">작성일: ${freeBoardContent.frdate}</tr>
				</c:if>
				<tr><th colspan="2" class="category_content">&nbsp;&nbsp;본문</th></tr>
				<tr class="content">
					<td colspan="2" class="free_content">
						<pre class="free_content">${freeBoardContent.fcontent }</pre>
					</td>
				</tr>
			</table>
				<div class="buttons">
					<c:if test="${(not empty freeBoardContent.mid and freeBoardContent.mid eq member.mid) or 
												(not empty freeBoardContent.rid and freeBoardContent.rid eq recteam.rid)}">
						<button class="button" onclick="location.href='${conPath}/freeBoardModifyView.do?fnum=${param.fnum }&pageNum=${param.pageNum }'">수정</button>
						<button class="button" onclick="location.href='${conPath}/freeBoardDelete.do?fnum=${param.fnum }&pageNum=${param.pageNum }'">삭제</button>
					</c:if>
					<button class="button" onclick="location.href='${conPath}/freeBoardList.do?pageNum=${param.pageNum }'">목록</button>
				</div>
			<br><hr style="width:1400px; margin:0 auto;"><br><br>
		<%-------------------------------- 댓글 달기  ---------------------------%>
	 		<form action="${conPath }/commentWrite.do?fnum=${param.fnum }&pageNum=${param.pageNum }" method="post">
				<c:if test="${not empty member.mid}">
	 				<input type="hidden" name="mid" value="${member.mid}">
				</c:if>
				<c:if test="${not empty recteam.rid}">
	 				<input type="hidden" name="rid" value="${recteam.rid}">
				</c:if>
				<fieldset class="comment">
					<legend>댓글 달기</legend>
					<textarea rows="5" cols="20" name="frcontent"></textarea>
				</fieldset>
				<input class="button" type="submit" value="등록">
			</form>
		</div>
		<%----------------------------------- 댓글 보기 ------------------------------%>
		<div class="comment">
				<c:forEach var="dto" items="${freeComments}">
					<form action="${conPath}/freeCommentmodify.do" method="post">
						<input type="hidden" name="fnum" value=${dto.fnum }>
						<input type="hidden" name="frnum" value=${dto.frnum }>
						<input type="hidden" name="pageNum" value=${param.pageNum }>
						<hr>
						${dto.mid }${dto.rid } 님 | <fmt:formatDate value="${dto.frrdate }" pattern="yy-MM-dd hh:mm"/><br>
						<pre class="frcontent">${dto.frcontent }</pre>
						<br>
						<c:if test="${(not empty dto.mid and dto.mid eq member.mid) or (not empty dto.rid and dto.rid eq recteam.rid)}">
							<span><a class="comment_modify" style="color : black; text-decoration:none; cursor:pointer">수정 </a></span>
							<span><a href="${conPath}/freeCommentDelete.do?fnum=${dto.fnum}&frnum=${dto.frnum}" style="color : black; text-decoration:none;">삭제</a></span><br>
						</c:if>
					</form>
				</c:forEach>
			</div>
		</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>