<%@page import="com.lec.soundbooker.dto.MemberDto"%>
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

		p{margin-top: 30px;}
		table{ margin: 0 auto;}
		body { background-color: #ffffaa; }

	</style>
</head>
<body>
	<%!String mbank; %>
	<%
		MemberDto member = (MemberDto)session.getAttribute("member");
		mbank = member.getMbank();
	%>
	<jsp:include page="../main/header.jsp"/>
	<form action="${conPath }/modify.do" method="post">
		<input type="hidden" name="dbMpw" value="${member.mpw }">
		<input type="hidden" name="pnum" value="${member.pnum }">
		<input type="hidden" name="pnumreg" value="${member.pnumreg }">
		<input type="hidden" name="mbirth" value="${member.mbirth }">
		<input type="hidden" name="mgender" value="${member.mgender }">
		<input type="hidden" name="morigin" value="${member.morigin }">
		<input type="hidden" name="rcnt" value="${member.rcnt }">
		<input type="hidden" name="mactivate" value="${member.mactivate }">
		<div id="wrapper">
			<table>
				<caption>정보수정</caption>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="mid" value="${member.mid }" readonly="readonly" size="3">
					</td>
				</tr>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="oldMpw" required="required" ></td>
				</tr>
				<tr>
					<th>바꿀 비밀번호</th>
					<td><input type="password" name="mpw" ></td>				
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="mname" required="required" value="${member.mname }"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="mbirth" value="${member.mbirth }" readonly="readonly"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="radio" name="mgender" value="${member.mgender }" required="required" readonly="readonly">남성
						<input type="radio" name="mgender" value="${member.mgender }">여성
				<td>
			<tr><th>전화번호</th>
				<td>
					<input type="text" name="mphone" required="required" value="${member.mphone }">
				</td>
			</tr>
			<tr><th>국적</th>
				<td>
					<input type="radio" name="morigin" value="n" checked="checked" required="required" value="${member.morigin }" readonly="readonly">내국인
					<input type="radio" name="morigin" value="i">외국인
				<td>
			<tr><th>주소</th><td><input type="text" name="maddress" value="${member.maddress }"></td></tr>
			<tr><th>운전 가능 여부</th>
				<td>
					<input type="radio" name="mdrive" value="n" checked="checked" value="${member.mdrive }">불가능
					<input type="radio" name="mdrive" value="y" value="${member.mdrive }">가능
				<td>
			<tr><th>선호 녹음 시간1</th><td><input type="text" name="mprefer1" value="${member.mprefer1 }"></td></tr>
			<tr><th>선호 녹음 시간2</th><td><input type="text" name="mprefer2" value="${member.mprefer2 }"></td></tr>
			<tr><th>선호 녹음 시간3</th><td><input type="text" name="mprefer3" value="${member.mprefer3 }"></td></tr>
			<tr>
				<th>은행</th>
			<td>
				<select name="mbank" id="mbank">
	        <option value="">은행명을 선택하세요</option>
	        <option <%if("경남은행".equals(mbank)){out.print("selected='selected'");} %>value="경남은행">경남은행</option>
	        <option <%if("광주은행".equals(mbank)){out.print("selected='selected'");} %>value="광주은행">광주은행</option>
	        <option <%if("국민은행".equals(mbank)){out.print("selected='selected'");} %>value="국민은행">국민은행</option>
	        <option <%if("기업은행".equals(mbank)){out.print("selected='selected'");} %>value="기업은행">기업은행</option>
	        <option <%if("농협중앙회".equals(mbank)){out.print("selected='selected'");} %>value="농협중앙회">농협중앙회</option>
	        <option <%if("농협회원조합".equals(mbank)){out.print("selected='selected'");} %>value="농협회원조합">농협회원조합</option>
	        <option <%if("대구은행".equals(mbank)){out.print("selected='selected'");} %>value="대구은행">대구은행</option>
	        <option <%if("도이치은행".equals(mbank)){out.print("selected='selected'");} %>value="도이치은행">도이치은행</option>
	        <option <%if("부산은행".equals(mbank)){out.print("selected='selected'");} %>value="부산은행">부산은행</option>
	        <option <%if("산업은행".equals(mbank)){out.print("selected='selected'");} %>value="산업은행">산업은행</option>
	        <option <%if("상호저축".equals(mbank)){out.print("selected='selected'");} %>value="상호저축">상호저축은행</option>
	        <option <%if("새마을금고".equals(mbank)){out.print("selected='selected'");} %>value="새마을금고">새마을금고</option>
	        <option <%if("수협중앙회".equals(mbank)){out.print("selected='selected'");} %>value="수협중앙회">수협중앙회</option>
	        <option <%if("신한금융투".equals(mbank)){out.print("selected='selected'");} %>value="신한금융투자">신한금융투자</option>
	        <option <%if("신한은행".equals(mbank)){out.print("selected='selected'");} %>value="신한은행">신한은행</option>
	        <option <%if("신협중앙회".equals(mbank)){out.print("selected='selected'");} %>value="신협중앙회">신협중앙회</option>
	        <option <%if("외환은행".equals(mbank)){out.print("selected='selected'");} %>value="외환은행">외환은행</option>
	        <option <%if("우리은행".equals(mbank)){out.print("selected='selected'");} %>value="우리은행">우리은행</option>
	        <option <%if("우체국".equals(mbank)){out.print("selected='selected'");} %>value="우체국">우체국</option>
	        <option <%if("전북은행".equals(mbank)){out.print("selected='selected'");} %>value="전북은행">전북은행</option>
	        <option <%if("제주은행".equals(mbank)){out.print("selected='selected'");} %>value="제주은행">제주은행</option>
	        <option <%if("카카오뱅크".equals(mbank)){out.print("selected='selected'");} %>value="카카오뱅크">카카오뱅크</option>
	        <option <%if("케이뱅크".equals(mbank)){out.print("selected='selected'");} %>value="케이뱅크">케이뱅크</option>
	        <option <%if("하나은행".equals(mbank)){out.print("selected='selected'");} %>value="하나은행">하나은행</option>
	        <option <%if("한국씨티은".equals(mbank)){out.print("selected='selected'");} %>value="한국씨티은행">한국씨티은행</option>
	        <option <%if("HSBC은행".equals(mbank)){out.print("selected='selected'");} %>value="HSBC은행">HSBC은행</option>
	        <option <%if("SC제일은행".equals(mbank)){out.print("selected='selected'");} %>value="SC제일은행">SC제일은행</option>
				</select>
			</td>
		</tr>
		<tr><th>계좌번호</th><td><input type="text" name="maccount" placeholder="-없이 입력" value="${member.maccount}"></td></tr>
				<tr>
					<td colspan="3" style="text-align:center">
						<input type="submit" value="정보수정" class="btn">
						<input type="reset" value="초기화" class="btn">
						<input type="reset" value="이전" onclick="history.back()" class="btn">
						<input type="button" value="회원탈퇴" onclick="location.href='${conPath}/withdrawal.do'" class="btn">
					</td>
				</tr>
			</table>
		</div>
	</form>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>