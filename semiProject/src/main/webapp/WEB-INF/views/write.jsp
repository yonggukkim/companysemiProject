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
<script src="./resources/js/jquery-3.3.1.min.js"></script>
</head>
<script>
	$(document).ready(function(){
		var rank = $("#rank").val();
		var rank1 = $("#rank1").val();
		var sub = $("#sub").val();
		//////////////////첫 게시글//////////////////////////////
		$("#fail").click(function() {
			$("#frm").append("<input type='hidden' name='fail' value='e' />")
			$("#frm").prop("method", "post").prop("action","write").submit();
		});
		
		$("#save").click(function() {
			$("#frm").append("<input type='hidden' name='save' value='a' />")
			$("#frm").prop("method", "post").prop("action","write").submit();
		});
		
		if((rank == 'e' && sub == 'n') || (rank == 'a' && sub == 'n')) {
			$("#payment").click(function() {
				$("#frm").append("<input type='hidden' name='payment' value='b' />")
				$("#frm").prop("method", "post").prop("action","write").submit();
			});
		}else if(rank == 'mm' || (rank1 == 'mm' && sub == 'y')) {
			$("#payment").click(function() {
				$("#frm").append("<input type='hidden' name='payment' value='c' />")
				$("#frm").prop("method", "post").prop("action","write").submit();
			});
		}else if(rank == 'gg' || (rank1 == 'gg' && sub == 'y')) {
			$("#payment").click(function() {
				$("#frm").append("<input type='hidden' name='payment' value='d' />")
				$("#frm").prop("method", "post").prop("action","write").submit();
			});
		}
		//////////////////첫 게시글//////////////////////////////
		
// 		$("#upfail").click(function() {
// 			$("#frm").append("<input type='hidden' name='upfail' value='e' />")
// 			$("#frm").prop("method", "post").prop("action","write").submit();
// 		});
		
// 		$("#upsave").click(function() {
// 			$("#frm").append("<input type='hidden' name='upsave' value='a' />")
// 			$("#frm").prop("method", "post").prop("action","write").submit();
// 		});
		
// 		if(rank == 'e' || rank == 'a') {
// 			$("#uppayment").click(function() {
// 				$("#frm").append("<input type='hidden' name='uppayment' value='b' />")
// 				$("#frm").prop("method", "post").prop("action","write").submit();
// 			});
// 		}else if(rank == 'mm') {
// 			$("#uppayment").click(function() {
// 				$("#frm").append("<input type='hidden' name='uppayment' value='c' />")
// 				$("#frm").prop("method", "post").prop("action","write").submit();
// 			});
// 		}else {
// 			$("#uppayment").click(function() {
// 				$("#frm").append("<input type='hidden' name='uppayment' value='d' />")
// 				$("#frm").prop("method", "post").prop("action","write").submit();
// 			});
// 		}
	});
</script>
<body>
	<!-- 직인 부분 시작 /////////////////////////////////////////// -->
	<label>결재요청 : </label><input type="checkbox" disabled="disabled" <c:if test="${board.boardCondition eq 'b' or board.boardCondition eq 'c' or board.boardCondition eq 'd'}">checked="checked"</c:if> />
	<label>과장 : </label><input type="checkbox" disabled="disabled" <c:if test="${board.boardCondition eq 'c' or board.boardCondition eq 'd'}">checked="checked"</c:if> />
	<label>부장 : </label><input type="checkbox" disabled="disabled" <c:if test="${board.boardCondition eq 'd'}">checked="checked"</c:if>/>
	<!-- 직인 부분 끝 //////////////////////////////////////////// -->
	<!-- 글쓰기 부분 시작 ///////////////////////////////////////////////////////////////////////////////////// -->
	<form id="frm" accept-charset="utf-8">
		<input type="hidden" name="sessName" id="sessName" value="${login.empName }" />
		<input type="hidden" name="EMP_NAME1" id="EMP_NAME1" value="${login.EMP_NAME1 }" />
		<input type="hidden" name="EMP_RANK1" id="EMP_RANK1" value="${login.EMP_RANK1 }" />
		<table>
			<c:choose>
				<c:when test="${empty board.boardCondition}"><!-- 첫 게시글 부분 -->
					<tr><th><label>번호 : </label></th><td><input type="text" name="boardNum" readonly="readonly" value="${count}" /></td></tr>
					<tr><th><label>작성자 : </label></th><td><input type="text" name="empName" readonly="readonly" value="${login.empName }" /></td></tr>
					<tr><th><label>제목 : </label></th><td><input type="text" name="boardSubject" value="" /></td></tr>
					<tr><th><label>내용 : </label></th><td><input type="text" name="boardContent" value="" style="text-align:center; width:200px; height:50px;" /></td></tr>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${login.empName eq board.empName and (board.boardCondition eq 'a' or board.boardCondition eq 'e')}"><!-- 본인의 임시저장이나 반려일 경우 -->
							<tr><th><label>번호 : </label></th><td><input type="text" name="boardNum" readonly="readonly" value="${board.boardNum}" /></td></tr>
							<tr><th><label>작성자 : </label></th><td><input type="text" name="empName" readonly="readonly" value="${board.empName}" /></td></tr>
							<tr><th><label>제목 : </label></th><td><input type="text" name="boardSubject" value="${board.boardSubject}" /></td></tr>
							<tr><th><label>내용 : </label></th><td><input type="text" name="boardContent" value="${board.boardContent}" style="text-align:center; width:200px; height:50px;" /></td></tr>
						</c:when>
						<c:otherwise><!-- 이외 여러가지 등등... -->
							<tr><th><label>번호 : </label></th><td><input type="text" name="boardNum" readonly="readonly" value="${board.boardNum}" /></td></tr>
							<tr><th><label>작성자 : </label></th><td><input type="text" name="empName" readonly="readonly" value="${board.empName}" /></td></tr>
							<tr><th><label>제목 : </label></th><td><input type="text" name="boardSubject" readonly="readonly" value="${board.boardSubject}" /></td></tr>
							<tr><th><label>내용 : </label></th><td><input type="text" name="boardContent" readonly="readonly" value="${board.boardContent}" style="text-align:center; width:200px; height:50px;" /></td></tr>
						</c:otherwise>
					</c:choose>	
				</c:otherwise>
			</c:choose>
			<tr>
				<%-- <c:choose>
					<c:when test="${empty board.boardCondition}"><!-- 첫 게시글 작성 부분  update, insert 따로 사용 할 때 -->
						<td><input type="button" id="save" name="save" value="임시저장"/></td>
						<td><input type="button" id="payment" name="payment" value="결재"/></td>
					</c:when>
					<c:when test="${login.empRank eq 'e' and (board.boardCondition eq 'b' or board.boardCondition eq 'c' or board.boardCondition eq 'd')}"><!-- 사원 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'a' and (board.boardCondition eq 'b' or board.boardCondition eq 'c' or board.boardCondition eq 'd')}"><!-- 대리 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'mm' and (board.boardCondition eq 'c' or board.boardCondition eq 'd')}"><!-- 과장 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'mm' and board.boardCondition eq 'e'}"><!-- 과장 반려 -->
						<c:if test="${login.empName eq board.empName}"><!-- 부장 반려 -->
							<td><input type="button" id="upsave" name="upsave" value="임시저장"/></td>
							<td><input type="button" id="uppayment" name="uppayment" value="결재"/></td>
						</c:if>
					</c:when>
					<c:when test="${login.empRank eq 'gg' and (board.boardCondition eq 'd' or board.boardCondition eq 'e')}"><!-- 부장 결재 -->
					</c:when>
					<c:when test="${board.boardCondition eq 'a' or board.boardCondition eq 'e'}"><!-- 임시저장이나 반려일 경우 -->
						<td><input type="button" id="upsave" name="upsave" value="임시저장"/></td>
						<td><input type="button" id="uppayment" name="uppayment" value="결재"/></td>
					</c:when>
					<c:when test="${login.empRank eq 'mm' or login.empRank eq 'gg'}"><!-- 과장, 부장 일 때 보여지는 버튼 -->
						<td><input type="button" id="upfail" name="upfail" value="반려"/>&nbsp;</td>
						<td><input type="button" id="uppayment" name="uppayment" value="결재"/></td>
					</c:when>
				</c:choose> --%>
				<c:choose>
					<c:when test="${empty board.boardCondition}"><!-- merge 처리 부분 -->
						<td><input type="button" id="save" name="save" value="임시저장"/></td>
						<td><input type="button" id="payment" name="payment" value="결재"/></td>
					</c:when>
					<c:when test="${login.empRank eq 'e' and (board.boardCondition eq 'b' or board.boardCondition eq 'c' or board.boardCondition eq 'd') and login.empSub eq 'n'}"><!-- 사원 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'a' and (board.boardCondition eq 'b' or board.boardCondition eq 'c' or board.boardCondition eq 'd') and login.empSub eq 'n'}"><!-- 대리 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'mm' and (board.boardCondition eq 'c' or board.boardCondition eq 'd')}"><!-- 과장 결재 -->
					</c:when>
					<c:when test="${login.EMP_RANK1 eq 'mm' and (board.boardCondition eq 'c' or board.boardCondition eq 'd')}"><!-- 과장 대리 결재 -->
					</c:when>
					<c:when test="${login.empRank eq 'mm' and board.boardCondition eq 'e' }"><!-- 과장 반려 -->
						<c:if test="${login.empName eq board.empName}"><!-- 부장 반려 -->
							<td><input type="button" id="save" name="save" value="임시저장"/></td>
							<td><input type="button" id="payment" name="payment" value="결재"/></td>
						</c:if>
					</c:when>
					<c:when test="${login.EMP_RANK1 eq 'mm' and board.boardCondition eq 'e' }"><!-- 과장  대리 반려 -->
						<c:if test="${login.empName eq board.empName}"><!-- 부장 대리 반려 -->
							<td><input type="button" id="save" name="save" value="임시저장"/></td>
							<td><input type="button" id="payment" name="payment" value="결재"/></td>
						</c:if>
					</c:when>
					<c:when test="${login.empRank eq 'gg' and (board.boardCondition eq 'd' or board.boardCondition eq 'e')}"><!-- 부장 결재 및 반려 -->
					</c:when>
					<c:when test="${login.EMP_RANK1 eq 'gg' and (board.boardCondition eq 'd' or board.boardCondition eq 'e')}"><!-- 부장 대리 결재 및 대리 반려 -->
					</c:when>
					<c:when test="${board.boardCondition eq 'a' or board.boardCondition eq 'e'}"><!-- 임시저장이나 반려일 경우 -->
						<td><input type="button" id="save" name="save" value="임시저장"/></td>
						<td><input type="button" id="payment" name="payment" value="결재"/></td>
					</c:when>
					<c:when test="${login.empRank eq 'mm' or login.empRank eq 'gg' or login.empSub eq 'y'}"><!-- 과장, 부장 일 때 보여지는 버튼 -->
						<td><input type="button" id="fail" name="fail" value="반려"/>&nbsp;</td>
						<td><input type="button" id="payment" name="payment" value="결재"/></td>
					</c:when>
				</c:choose>
			</tr>
		</table>
	</form>
	<input type="hidden" name="rank" id="rank" value="${login.empRank }" />
	<input type="hidden" name="sub" id="sub" value="${login.empSub }" />
	<input type="hidden" name="rank1" id="rank1" value="${login.EMP_RANK1 }" />
	<!-- 글쓰기 부분 끝 ////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- 히스토리 부분 시작 ////////// -->
	<table border="1">
		<tr>
		<th>번호</th>
		<th>결재일</th>
		<th>결재자(대리 결재자)</th>
		<th>결재상태</th>
		</tr>
		<c:forEach items="${history }" var="history">
			<tr>
				<td>${history.hisNum }</td>
				<td>${history.hisUptdate }</td>
				<td>${history.hisName }</td>
				 <c:choose>
				 	<c:when test="${history.hisCondition eq 'a'}">
				 		<td>임시저장</td>
				 	</c:when>
				 	<c:when test="${history.hisCondition eq 'b'}">
				 		<td>결재대기</td>
				 	</c:when>
				 	<c:when test="${history.hisCondition eq 'c'}">
				 		<td>결재중</td>
				 	</c:when>
				 	<c:when test="${history.hisCondition eq 'd'}">
				 		<td>결재완료</td>
				 	</c:when>
				 	<c:otherwise>
				 		<td>반려</td>
				 	</c:otherwise>
				 </c:choose>
			</tr>
		</c:forEach>
	</table>
	<!-- 히스토리 부분 끝 //////////// -->
</body>
</html>