<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	if(session.getAttribute("login") == null) {
		response.sendRedirect("/com/login");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<script>
	$(document).ready(function(){
		$("#logout").click(function(){
			window.location.href='http://localhost:8090/com/logout';
		});
		
		$('#datepicker, #datepicker1').click(function() {
			$(this).datepicker({
				dateFormat: 'yy/mm/dd'
			});
		});
		
		$("#nosession").click(function(){
			alert("로그인 해주세요.");
			window.location.href='http://localhost:8090/com/login';
		});
		
		$("#substitute").click(function(){
			var w = 300;
			var h = 300;
// 			var h = window.document.body.offsetHeight;
			var popupX = (window.screen.width / 2) - (300 / 2);
			// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
			var popupY= (window.screen.height /2) - (300 / 2);
			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
			var win = window.open("http://localhost:8090/com/substitute", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top="+popupY+",left="+popupX+",width="+w+",height="+h);
		});

		$("#write").click(function(){
			window.location.href='http://localhost:8090/com/write';
		});
		
		$(".cli").click(function (){
			var boardNum = $(this).children().eq(0).text();
			alert(boardNum);
			window.location.href='http://localhost:8090/com/modify?board_num='+boardNum;
		});
		
		$(document).on('click','#search', function() {
			$("#frm").prop("method", "post").prop("action","board").submit();
		});
		
		$(document).on('change','#conditionOption', function() {
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/condition',
				data : $('#frm').serialize(),
				success : function(html, status, xhr) {
					console.log(html);
					console.log(status);
					console.log(xhr);
					$('#other').html(html);
				},
				error : function(data, status, xhr) {
					console.log(data);
					console.log(status);
					console.log(xhr);
					alert(data);
				}
			});
		});
		
		$(document).on('click','.cli1',function (){
			var boardNum = $(this).children().eq(0).text();
			alert(boardNum);
			window.location.href='http://localhost:8090/com/modify?board_num='+boardNum;
		});
		
		$("#substitute").click(function () {
			
		});
	});
</script>
<body>
	${login.empName}(
	<c:choose>
	<c:when test="${login.empRank eq 'e'}">사원</c:when>
	<c:when test="${login.empRank eq 'a'}">대리</c:when>
	<c:when test="${login.empRank eq 'mm'}">과장</c:when>
	<c:otherwise>부장</c:otherwise>
	</c:choose>
	)
	<c:if test="${login.empSub eq 'y' }">
	- ${login.EMP_NAME1 }(
	<c:choose>
	<c:when test="${login.EMP_RANK1 eq 'mm'}">과장</c:when>
	<c:otherwise>부장</c:otherwise>
	</c:choose>
	)
	</c:if> 님 환영합니다.
	<input type="button" value="로그아웃" id="logout" />
	<p>${login.SUB_REGDATE }</p>
	<p><input type="button" value="글쓰기" id="write" /> <c:if test="${login.empRank eq 'gg' or login.empRank eq 'mm' }"><input type="button" value="대리결재" id="substitute" /></c:if></p>
	<form id="frm" accept-charset="utf-8">
		<input type="hidden" id="sessId" name="sessId" value="${login.empId}">
		<select id="searchOption" name="searchOption">
 			<option value="">선택</option>
			<option value="writer" <c:if test="${reset.searchOption eq 'writer'}">selected</c:if>>작성자</option>
			<option value="title" <c:if test="${reset.searchOption eq 'title'}">selected</c:if>>제목</option>
			<option value="supervisor" <c:if test="${reset.searchOption eq 'supervisor'}">selected</c:if>>결재자</option>
		</select> <input type="search" id="keyword" name="keyword" value="${reset.keyword }" /> 
		<select id="conditionOption" name="conditionOption">
			<option value="">결재상태</option>
			<option value="a" <c:if test="${reset.conditionOption eq 'a'}">selected</c:if>>임시저장</option>
			<option value="b" <c:if test="${reset.conditionOption eq 'b'}">selected</c:if>>결재대기</option>
			<option value="c" <c:if test="${reset.conditionOption eq 'c'}">selected</c:if>>결재중</option>
			<option value="d" <c:if test="${reset.conditionOption eq 'd'}">selected</c:if>>결재완료</option>
			<option value="e" <c:if test="${reset.conditionOption eq 'e'}">selected</c:if>>반려</option>
		</select>
		<p><input type="text" id="datepicker" name="datepicker" value="${reset.datepicker }" autocomplete="off"> ~ 
		<input type="text" id="datepicker1" name="datepicker1" value="${reset.datepicker1 }" autocomplete="off"> <input type="button" value="검색" id="search" /></p>
	</form>
	<input type="hidden" id="sessId" name="sessId" value="${login }" />
		<div id="other">
		<table border="1">
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>작성일</th>
				<th>결재일</th>
				<th>결재자</th>
				<th>결재상태</th>
			</tr>
			<c:choose>
				<c:when test="${ empty list}">
				<tr>
					<td colspan="7">데이터가 없습니다.</td>
				</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${list }" var="list">
						<tr class="cli">
							<td>${list.boardNum }</td>
							<td>${list.empName }</td>
							<td>${list.boardSubject }</td>
							<td>${list.boardRegdate }</td>
							<td>${list.boardUptdate }</td>
							<td>${list.boardName }</td>
							<c:choose>
								<c:when test="${list.boardCondition eq 'e'}">
									<td>반려</td>
								</c:when>
								<c:when test="${list.boardCondition eq 'd'}">
									<td>결재완료</td>
								</c:when>
								<c:when test="${list.boardCondition eq 'c'}">
									<td>결재중</td>
								</c:when>
								<c:when test="${list.boardCondition eq 'b'}">
									<td>결재대기</td>
								</c:when>
								<c:otherwise>
									<td>임시저장</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
</body>
</html>