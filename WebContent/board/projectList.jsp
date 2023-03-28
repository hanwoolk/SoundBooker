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
  <style>
  	.project_Table {
		  border-spacing:10px;
		  width:1000px;
		  margin : 30px auto 0 auto;
		  border-collapse: separate;
	  }
		table td {
		  padding: 10px;
		  border: 1px solid #ddd;
		  border-radius:5px;
		  cursor:pointer;
		}
		h3 {text-align:center; padding-top:30px; margin:0;}
	 	.projects{ cursor:pointer; margin:10px; box-shadow:1px 1px gray; height:100px;}
	 	.projects:hover{background-color:#f7f6df;}
		.ptitle, .pcontent{
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
		  text-align:left;
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
	  	width:1000px;
	  	margin:15px auto;
	  	text-align:center;
  	}
  </style>
  <script>
 	  $(document).ready(function(){
			$('td.project_content').click(function(){
				var pnum =$(this).children().children().eq(0).text().trim();
				if(!isNaN(Number(pnum))){
					location.href='${conPath }/projectContent.do?pnum='+pnum+'&pageNum=${pageNum}';
				}
			});
		});
  </script>
</head>
<body>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<c:set var="SUCCESS" value="1"/>
		<c:set var="FAIL" value="0"/>
		<c:if test="${registerResult eq SUCCESS }">
			<script>alert('프로젝트 등록 성공');</script>
		</c:if>
		<c:if test="${registerResult eq FAIL}">
			<script>
				alert('프로젝트 등록 오류, 내용 확인부탁드립니다');
				history.back();
			</script>
		</c:if>
		<c:if test="${projectModifyResult eq SUCCESS }">
			<script>alert('수정 성공');</script>
		</c:if>
		<c:if test="${projectModifyResult eq FAIL }">
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
		<h3>모집중 프로젝트</h3>
		<table class="project_Table">
			<c:if test="${projectList.size() eq 0 }">
				<tr class="content">
					<td colspan="5">해당 페이지에 글이 없습니다</td>
				</tr>
			</c:if>
			<%---------------------- 1줄 5개씩 총 15개 프로젝트 리스트업  ---------------%>
			<c:if test="${projectList.size() != 0 }">   
				<c:forEach var="dto" items="${projectList }" varStatus="loop">
					<c:if test="${loop.index % 5 == 0 }">
						<tr >
					</c:if>
						<td class="project_content">
							<h3 class="ptitle" title="${dto.pnum }. ${dto.pname }"><span class="pnum${dto.pnum }">${dto.pnum }</span>. ${dto.pname }</h3>
							<hr>
							<p><span class="pcontent">${dto.pcontent }</span></p>
							<p class = "date">게시일 : <fmt:formatDate value="${dto.prdate }" pattern="yy/MM/dd(E)"/></p>
						</td>
					<c:if test="${(loop.index + 1) % 5 == 0 || loop.last }">
						</tr>
					</c:if>																	
				</c:forEach>
			</c:if>
		</table>
		<%--------------------------- 게시판 페이징 ------------------------------%>
		<div class="paging"> 
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
	</div>
	<%------------------------------ 프로젝트 등록 버튼 ---------------------------%>								
	<c:if test="${recteam.rjob eq 'PROJECT_MANAGER'}">
		<div class="posting">
			<button onclick='location.href="${conPath}/projectRegisterView.do"'>프로젝트 등록</button>
		</div>
	</c:if>
	<%------------------------------------------------------------------------%>								
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>