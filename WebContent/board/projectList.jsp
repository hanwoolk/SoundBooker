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
  <style>
		table {
		  border-collapse: collapse;
		  width:1000px;
		  margin : 0 auto;
		}
		table td {
		  padding: 10px;
		  border: 1px solid #ddd;
		}
		
		 .projects{ cursor:pointer; margin:10px; box-shadow:1px 1px gray; height:100px;}
		 .projects:hover{background-color:#f7f6df;}
		 
		#ptitle, #pcontent{
			margin:0 auto;
			width:250px;
			overflow: hidden;
    	text-overflow: ellipsis;
      white-space: nowrap;
      display : block; 
		} 
		hr {
	    border: 0;
	    height: 2px;
	    background: gray;
	  }
		table td h3 {
		  font-size: 20px;
		  font-weight: bold;
		  margin-bottom: 10px;
		}
		
		table td hr {
		  border: 0;
		  border-top: 1px solid #ddd;
		  margin: 10px 0;
		}
		
		table td p {
		  font-size: 16px;
		  line-height: 1.5;
		}
		
		table td .date {
		  font-size: 14px;
		  font-style: italic;
		  color: #999;
		}
		table .content{
			cursor:pointer;
		}
		.paging{
  		width:100%;
  		position:absolute;
  		bottom:150px;
  		text-align:center;
  		margin:0 auto;
  	}
   	.posting{
	  	width:800px;
	  	margin:15px auto;
	  	text-align:left;
  	}
  </style>
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <script>
/*  	  $(document).ready(function(){
	  	$('.projects').click(function(){
	  		var pnum =$(this).$('#pnum').text().trim();
	  		if(!isNaN(Number(pnum))){
	  			location.href='${conPath }/projectContent.do?pnum='+pnum+'&pageNum=${pageNum}';
	  		}
	  	});
	  }); */
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="content_form">
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
				alert('${param.pnum}번 글 수정 실패');
				history.back();
			</script>
		</c:if>
		<c:if test="${not empty deleteResult }">
			<script>
				alert('${deleteResult}');
			</script>
		</c:if>
		<c:if test="${replyResult eq SUCCESS }">
			<script>alert('${param.pnum}번 글의 답변글 쓰기 성공')</script>
		</c:if>
		<c:if test="${replyResult eq FAIL }">
			<script>
				alert('${param.fid}번 글의 답변글 쓰기 실패')
				history.go(-1);
			</script>
		</c:if>

		<table>
			<c:if test="${projectList.size() eq 0 }">
				<tr class="content">
					<td colspan="5">해당 페이지에 글이 없습니다</td>
				</tr>
			</c:if>
			<c:if test="${projectList.size() != 0 }">   <%-- 1줄 3개씩 총 12개 프로젝트 리스트업  --%>
				<c:forEach var="dto" items="${projectList }" varStatus="loop">
					<c:if test="${loop.index % 3 == 0 }">
						<tr>
					</c:if>
						<td class="projects" onclick="location.href=${conPath }/projectContent.do?pnum=${dto.pnum }&pageNum=${pageNum}">
							<h3 id="ptitle" title="${dto.pnum }. ${dto.pname }"><span id="pnum">${dto.pnum }</span>. ${dto.pname }</h3>
							<hr>
							<p><span id="pcontent">${dto.pcontent }</span></p>
							<p class = "date">게시일 : <fmt:formatDate value="${dto.prdate }" pattern="yy/MM/dd(E)"/></p>
						</td>
					<c:if test="${(loop.index + 1) % 3 == 0 || loop.last }">
						</tr>
					</c:if>																	<%-- 1줄 3개씩 총 12개 프로젝트 리스트업 --%>
				</c:forEach>
			</c:if>
		</table>
		<div class="paging"> <%-- 게시판 페이징 --%>
			<c:if test="${startPage > BLOCKSIZE}">
				[ <a href="${conPath }/projectList.do?pageNum=${startPage-1}">이전</a> ]
			</c:if>
			<c:forEach var="i" begin="${startPage }" end="${endPage}">
				<c:if test="${i eq pageNum }">
					[ <b>${i }</b> ]
				</c:if>
				<c:if test="${i != pageNum }">
					[ <a href="${conPath}/projectList.do?pageNum=${i }">${i}</a> ]
				</c:if>
			</c:forEach>
			<c:if test="${endPage < pageCnt }">
				[ <a href="${conPath }/projectList.do?pageNum=${endPage+1}">다음</a> ]
			</c:if>
		</div>
	</div> 								<%-- 게시판 페이징 --%>
	<c:if test="${recteam.rjob eq 'PROJECT_MANAGER'}"> <%-- 프로젝트 등록 버튼 --%>
		<div class="posting">
			<button onclick='location.href="${conPath}/projectWriteView.do"'>프로젝트 등록</button>
		</div>
	</c:if>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>