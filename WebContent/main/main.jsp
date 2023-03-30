<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="conPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.2/examples/jumbotron/">
<link href="/docs/5.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">

<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }

  .b-example-divider {
    height: 3rem;
    background-color: rgba(0, 0, 0, .1);
    border: solid rgba(0, 0, 0, .15);
    border-width: 1px 0;
    box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
  }

  .b-example-vr {
    flex-shrink: 0;
    width: 1.5rem;
    height: 100vh;
  }

  .bi {
    vertical-align: -.125em;
    fill: currentColor;
  }

  .nav-scroller {
    position: relative;
    z-index: 2;
    height: 2.75rem;
    overflow-y: hidden;
  }

  .nav-scroller .nav {
    display: flex;
    flex-wrap: nowrap;
    padding-bottom: 1rem;
    margin-top: -1px;
    overflow-x: auto;
    text-align: center;
    white-space: nowrap;
    -webkit-overflow-scrolling: touch;
  }
 	#wrapper {
		height: 906px;
	  min-height: 100%;
	  padding-bottom: 100px;
	} 
	.main{height:930px; padding:0;
	}
	.p-5 mb-4 bg-light rounded-3{height:100%;
	}
	.image_wrapper {
	overflow:hidden; height:930px;
  display: inline-block;
  padding: 0;
  animation: fadein 3s;
  -webkit-animation: fadein 3s;
  }
	.image_wrapper img{
		width:800px; 
		height:930px; 
		cursor:default;
	  object-fit: cover;
    margin: auto;
    }
	.greeting {
  display: inline-block;
  padding: 10px;
  animation: fadein 2.5s;
  animation-delay:1s;
  -webkit-animation: fadein 3s;
  font-weight:10em;
  font-size:4.7em;
  margin-left:90px;
  margin-top:-90px;
  
	}
		.content {
  display: inline-block;
  padding: 10px;
  animation: fadein 2.5s;
  animation-delay:2s;
  -webkit-animation: fadein 3s; 
  font-weight:4em;
  font-size:1.7em;
  text-align:left;
  word-break: keep-all;
  line-height:2em;
  margin-left:90px;
	}
		.button {
  display: inline-block;
  padding: 10px;
  background-color:#6A56C7;
  color:#EFC53F;
  border:none;
  border-radius:14px;
  animation: fadein 3s;
  animation-delay:2.5s;
  -webkit-animation: fadein 3s; 
  font-weight:3em;
  font-size:1.5em;
  margin-left:300px;
	}
	@keyframes fadein {
	    from {
	        opacity: 0;
	    }
	    to {
	        opacity: 1;
	    }
	}
	@-webkit-keyframes fadein { 
	    from {
	        opacity: 0;
	    }
	    to {
	        opacity: 1;
	    }
	}
	.py-5{
		padding:0px;
	}
</style>
</head>
<body>
	<c:if test="${param.method eq 'write'}">
		<script>
			location.href = '${conPath}/boardWriteView.do';
		</script>
	</c:if>
	<c:if test="${param.method eq 'modify'}">
		<script>
			location.href = '${conPath}/modifyView.do.do?mid=${param.mid}';
		</script>
	</c:if>
	<c:if test="${not empty activateId}">
		<script>
			alert('${activateId}');
		</script>
	</c:if>
	<c:if test="${not empty loginErrorMsg }">
		<script>
			alert('${loginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty rtLoginErrorMsg }">
		<script>
			alert('${rtLoginErrorMsg}');
			history.back();
		</script>
	</c:if>
	<c:if test="${not empty withdrawalResult }">
		<script>
			alert('${withdrawalResult}');
		</script>
	</c:if>
	<jsp:include page="../main/header.jsp"/>
	<div id="wrapper">
		<table>
			<tr>
				<td class="main">
			    <div class="p-5 mb-4 bg-light rounded-3" style="width:1000px; margin: 0 auto; height:100%;">
<!-- 			      <div class="container-fluid py-5">
 -->			      	<br><br><br><br><br><br><Br>
			        <p class="greeting">어서오세요</p>
			        <br><br><br><!-- display-5 fw-bold -->
			        <p class="content" >SoundBooker만의 쉽고 간단한 녹음 프로젝트에 참여하세요. 여러 재미있는 녹음부터 자녀와 함께할 수 있는 녹음, 외국어 녹음 등 많은 프로젝트가 준비되어 있으니 놓치지 말고 참여하세요</p>
			        <br><br><br><br><br><!-- col-md-8 fs-4 -->
			        <button class="button" type="button" onclick="location.href='${conPath}/joinView.do'">회원가입 하러가기</button>
			      <!-- </div> --><!-- btn btn-primary btn-lg -->
			    </div>
		    </td>
		    <td>
		    	<div class="image_wrapper">
    				<img src="${conPath }/db/main.jpg" alt="mainIMG" >
    			</div>
		    </td>
	    </tr>
		</table>
<!--     <div class="row align-items-md-stretch">
      <div class="col-md-6">
        <div class="h-100 p-5 text-bg-dark rounded-3">
          <h2>Change the background</h2>
          <p>Swap the background-color utility and add a `.text-*` color utility to mix up the jumbotron look. Then, mix and match with additional component themes and more.</p>
          <button class="btn btn-outline-light" type="button">Example button</button>
        </div>
      </div>
      <div class="col-md-6">
        <div class="h-100 p-5 bg-light border rounded-3">
          <h2>Add borders</h2>
          <p>Or, keep it light and add a border for some added definition to the boundaries of your content. Be sure to look under the hood at the source HTML here as we've adjusted the alignment and sizing of both column's content for equal-height.</p>
          <button class="btn btn-outline-secondary" type="button">Example button</button>
        </div>
      </div>
    </div> -->
	</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>