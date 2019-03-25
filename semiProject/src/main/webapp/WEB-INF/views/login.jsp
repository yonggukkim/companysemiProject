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
	$(document).ready(function () {
		/* 유효성 검사 시작 */
			$("#empId").focus();
		$("#btnLogin").click(function() {
			if($("#empId").val() == "" && $("#empPass").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#empId").focus();
			}else if($("#empId").val() == "" && $("#empPass").val() != "") {
				alert("아이디를 입력해주세요.");
				$("#empId").focus();
			}else if($("#empId").val() != "" && $("#empPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#empPass").focus();
			}else if($("#empId").val() != "" && $("#empPass").val() != "") {
				$("#frm").submit();
			}
		});
		/* 유효성 검사 종료*/
	});
</script>
<body>
	<form action="login" id="frm" method="post" accept-charset="utf-8" >
		<h3>login</h3>
		<table>
		<tr><th><label for="empId">아이디 : </label></th><td><input type="text" id="empId" name="empId" /></td></tr>
		<tr><th><label for="empPass">비밀번호 : </label></th><td><input type="password" id="empPass" name="empPass" /></td></tr>
		<tr><td colspan="2"><input type="button" id="btnLogin" value="로그인" /></td></tr>
		</table>
	</form>
</body>
</html>