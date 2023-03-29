<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.6.4.js"></Script>
  <style>
  	*{margin:0; padding:0;}
  	#wrapper{min-height:100%; padding-bottom:100px;
  	}
		.project_table{
			width:1000px;
			margin:60px auto 0 auto;
			border:1px solid gray;
		}
		.project_table tr td{height:40px;}
		.project_table .rdate{text-align:right; font-style:italic; padding-right:30px;}
		.project_table .pname{text-align:left; font-size:1.3em; font-weight:bold; margin:5px 0px 5px 10px;}
		.project_table .pstatus{font-style:italic;}
		.project_table .pstatus span{font-weight:bold;}
		.project_table .content{height:300px;}
		.project_table .content .project_content{ margin:0; padding: 15px; text-algin:top; display:inline-block;}
		.worker_title{text-align:center;}
		.worker_table{
			width:1600px;
			margin:0px auto;
			border:1px solid gray;
		}
		.buttons{ text-align:center; margin:10px auto;}
		.buttons .button{ width:40px; border:none; margin:0 5px;}
		/* form{width:1000px; margin:0 auto;} */
		.category {background-color:lightgray; text-align:center;}
		.category tr td ,.category tr th{border:1px solid gray; text-align:center;}
		.category_content{background-color:gray; text-align:left;}
  	.paging {
  		width:100%;
  		position:absolute;
  		bottom:150px;
  		text-align:center;
  	}
  </style>
  <script>
  	$(document).ready(function(){
  		$('#project_delete').click(function(){
				if(confirm('프로젝트를 삭제하시겠습니까?')){
					location.href='${conPath}/projectDelete.do?pnum=${param.pnum }&pageNum=${param.pageNum }'
				} else return; 			
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
				<script>alert('${param.pnum}번 글 수정 성공')</script>
			</c:if>
			<c:if test="${modifyResult eq FAIL }">
				<script>
					alert('${param.pnum}번 글 수정 실패')
					history.back();
				</script>
			</c:if>
		<%-------------------------------- 프로젝트 게시판 상세보기 ---------------------------%>
			<table class="project_table">
				<tr><td colspan="2"><p class="pname">${projectContent.pname }</p></td></tr>
				<tr><td class="pstatus"><span> &nbsp; 진행상태 : </span>${projectContent.pstatus}</td><td class="rdate">작성일: ${projectContent.prdate}</tr>
				<tr><th colspan="2" class="category_content">&nbsp;&nbsp;상세내용</th></tr>
				<tr class="content">
					<td colspan="2" class="project_content">
						<pre class="project_content">${projectContent.pcontent }</pre>
					</td>
				</tr>
				<tr><th>프로젝트 시작일 : ${projectContent.pstartdate}</th><th>&nbsp;&nbsp;프로젝트 종료 예정일 : ${projectContent.penddate}</th></tr>
				<tr><th>모집 참여자 수: ${projectContent.pmember}명</th><th>&nbsp;&nbsp;투입 작업자 수: ${projectContent.pop}명</th></tr>
			</table>
			<div class="buttons">
				<c:if test="${not empty recteam.rid and recteam.rjob eq 'PROJECT_MANAGER'}">
					<button class="button" onclick="location.href='${conPath}/projectModifyView.do?pnum=${param.pnum }&pageNum=${param.pageNum }'">수정</button>
					<button class="button" id="project_delete">삭제</button>
					<button class="button" onclick="location.href='${conPath}/projectFinish.do?pnum=${param.pnum }&pageNum=${param.pageNum }'">완료</button>
				</c:if>
				<button class="button" onclick="location.href='${conPath}/projectList.do?pageNum=${param.pageNum }'">목록</button>
			</div>
		</div>
	</div>
	<div class="hr"><hr></div>
	<br>
	<%-----------------------------------------------투입된 작업자 리스트----------------------------------------------------------%>
	<c:if test="${not empty projectOp or not empty projectMember}">
		<div class="opList">
			<h3 class="worker_title">투입 인원</h3>
			<table class="worker_table">
				<tr class="category">
					<th >ID</th><th >이름</th><th >직책</th><th>생년월일</th><th>성별</th><th>휴대폰번호</th><th>출신지</th><th>거주지</th>
					<th>운전 가능여부</th><th>선호시간1</th><th>선호시간2</th><th>선호시간3</th><th>녹음 횟수</th><th>제외 버튼</th>
				</tr>
				<c:forEach var="rdto" items="${projectOp }">
					<form action="${conPath }/opOut.do" method="get">
						<tr>
							<td>${rdto.rid }</td>
							<td>${fn:substring(rdto.rname,0,1)}**</td>
							<td>${rdto.rjob eq 'OPERATOR'? '작업자':'rdto.rjob'}</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<td>-</td>
							<c:if test="${recteam.rjob eq 'PROJECT_MANAGER' }">
								<td ><button class="out_button">제외</button></td>
							<td><input type="hidden" name="rid" value="${rdto.rid }"></td>
							<td><input type="hidden" name="pageNum" value="${param.pageNum }"></td>
							<td><input type="hidden" name="pnum" value="${param.pnum }"></td>
							</c:if>
						</tr>
					</form>
				</c:forEach>
				<c:forEach var="mdto" items="${projectMember }">
					<form action="${conPath }/memberOut.do" method="get">
						<tr>
							<td>${mdto.mid }</td>
							<td>${fn:substring(mdto.mname,0,1)}**</td>
							<td>신청자</td>
							<td>${mdto.mbirth }</td>
							<td>${mdto.mgender }</td>
							<td>${mdto.mphone }</td>
							<td>${mdto.morigin eq 'N'? '내국인':'외국인'}</td>
							<td>${mdto.maddress eq null? '-':mdto.maddress}</td>
							<td>${mdto.mdrive  eq 'N'? '불가(확인필요)':'가능'}</td>
							<td>${mdto.mprefer1 eq null? '-':mdto.mprefer1}</td>
							<td>${mdto.mprefer2 eq null? '-':mdto.mprefer2}</td>
							<td>${mdto.mprefer3 eq null? '-':mdto.mprefer3}</td>
							<td>${mdto.rcnt }회</td>
							<c:if test="${recteam.rjob eq 'SCHEDULER' }">
								<td ><button class="out_button">제외</button></td>
							<td><input type="hidden" name="mid" value="${mdto.mid }"></td>
							<td><input type="hidden" name="pageNum" value="${param.pageNum }"></td>
							<td><input type="hidden" name="pnum" value="${param.pnum }"></td>
							</c:if>
						</tr>
					</form>
				</c:forEach>
			</table>
		</div>
		<br><br>
		<div class="hr"><hr></div>
		<br><br>
	</c:if>
	<%---------------------------------------작업자 리스트 (매니저만 보임)-------------------------------------------%>
		<c:if test="${recteam.rjob eq 'PROJECT_MANAGER' and not empty OpList}">
			<div class="opList">
				<form action="${conPath }/opRegister.do" method="get">
					<table class="worker_table">
						<tr class="category">
							<th>ID</th><th>이름</th><th>진행중 프로젝트</th><th>등록버튼</th>
						</tr>
						<c:forEach var="rdto" items="${OpList }">
							<tr>
								<td>${rdto.rid }</td>
								<td>${rdto.rname }</td>
								<td>${rdto.pnum eq 0? "없음":rdto.pnum}</td>
								<td><input type="submit" value="등록"></td>
								<td><input type="hidden" name="rid" value="${rdto.rid }"></td>								
								<td><input type="hidden" name="pnum" value="${param.pnum }"></td>								
								<td><input type="hidden" name="pageNum" value="${param.pageNum }"></td>								
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
				</form>
			</div>
		</c:if>
		<%-------------------------------------신청자 리스트(일정 관리자만 보임)--------------------------------------- --%>
		<c:if test="${recteam.rjob eq 'SCHEDULER' and not empty regMemberList}">
			<div class="MemberList">
				<form action="${conPath }/memberRegister.do" method="get">
					<table class="worker_table">
						<tr class="category">
							<th>ID</th><th>이름</th><th>생년월일</th><th>성별</th><th>휴대폰번호</th><th>출신지</th><th>거주지</th>
							<th>운전 가능여부</th><th>선호시간1</th><th>선호시간2</th><th>선호시간3</th><th>녹음 횟수</th><th>등록버튼</th>
						</tr>
						<c:forEach var="mdto" items="${regMemberList }">
							<tr>
								<td>${mdto.mid }</td>
								<td>${mdto.mname }</td>
								<td>${mdto.mbirth }</td>
								<td>${mdto.mgender }</td>
								<td>${mdto.mphone }</td>
								<td>${mdto.morigin eq 'N'? '내국인':'외국인'}</td>
								<td>${mdto.maddress eq null? '-':mdto.maddress}</td>
								<td>${mdto.mdrive  eq 'N'? '불가(확인필요)':'가능'}</td>
								<td>${mdto.mprefer1 eq null? '-':mdto.mprefer1}</td>
								<td>${mdto.mprefer2 eq null? '-':mdto.mprefer2}</td>
								<td>${mdto.mprefer3 eq null? '-':mdto.mprefer3}</td>
								<td>${mdto.rcnt }회</td>
								<td><input type="submit" value="등록"></td>
								<td><input type="hidden" name="pageNum" value="${param.pageNum }"></td>
								<td><input type="hidden" name="pnum" value="${param.pnum }"></td>
								<td><input type="hidden" name="mid" value="${mdto.mid }"></td>
							</tr>
						</c:forEach>
					</table>
				</form>
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
		</c:if>
		<%------------------------------------------------------------------------- --%>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>