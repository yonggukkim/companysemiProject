<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
</head>
<script>
$(document).ready(function (){
	var empName;
	var empRank;
	$('#sublist').focus();
	
// 	$(window).bind("beforeunload", function (e){
// 		return "대리결재를 취소하시겠습니까?";
// 	});
	
	$("#nosession").click(function(){
		alert("로그인 해주세요.");
		window.location.href='http://localhost:8090/com/login';
	});
	
	$("#sublist").change(function(){
// 		alert("dsa");
		var sub = $(this).val();
		var sub2 = sub.split(',');
		subName = sub2[0];
		subRank = sub2[1];
		if(sub2[1] == 'e') {
			sub2[1] = '사원';
		}else if(sub2[1] == 'a') {
			sub2[1] = '대리';
		}
		$("input[name=subRank]").val(sub2[1]);
	});
	
	$("#cancel").click(function(){
		window.close();
	});
	
	$("#know").click(function(){
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/substitute',
			data : {'subName':subName, 'subRank':subRank},
			success : function(html, status, xhr) {
				console.log(html);
				console.log(status);
				console.log(xhr);
				opener.location.reload();
				window.self.close();
			},
			error : function(data, status, xhr) {
				console.log(data);
				console.log(status);
				console.log(xhr);
				alert(data);
			}
		});
	});
});
</script>
<body>
	<c:choose>
		<c:when test="${empty login }">
			<input type="button" id="nosession" />
		</c:when>
		<c:otherwise>
	<form id="frm1" accept-charset="utf-8">
		<p><label>대리결재자 : </label><select id="sublist" name="sublist">
			<option value="">선택</option>
			<c:forEach items="${sublist }" var="sublist">
			<option value="${sublist.empName},${sublist.empRank}">${sublist.empName }</option>
			</c:forEach>
		</select></p>
		<p><label>직급 : </label><input type="text" name="subRank" readonly="readonly" value="" /></p>
		<p><label>대리자 : </label><input type="text" readonly="readonly" value="${login.empName }(<c:if test="${login.empRank eq 'mm'}">과장</c:if><c:if test="${login.empRank eq 'gg'}">부장</c:if>)" /></p>
		<p><input type="button" value="취소" id="cancel" /> <input type="button" value="승인" id="know" /></p>
	</form>
	</c:otherwise>
	</c:choose>
</body>
</html>