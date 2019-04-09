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
	$(document).ready(function() {
		/* 유효성 검사 시작 */
		$("#empId").focus();
		$("#btnLogin").click(function() {
			if ($("#empId").val() == "" && $("#empPass").val() == "") {
				alert("아이디를 입력해주세요.");
				$("#empId").focus();
			} else if ($("#empId").val() == "" && $("#empPass").val() != "") {
				alert("아이디를 입력해주세요.");
				$("#empId").focus();
			} else if ($("#empId").val() != "" && $("#empPass").val() == "") {
				alert("비밀번호를 입력해주세요.");
				$("#empPass").focus();
			} else if ($("#empId").val() != "" && $("#empPass").val() != "") {
				$("#frm").submit();
			}
		});
		/* 유효성 검사 종료*/
	});
</script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<body>
	<form action="login" id="frm" method="post" accept-charset="utf-8">
		<h3>login</h3>
		<table>
			<tr>
				<th><label for="empId">아이디 : </label></th>
				<td><input type="text" id="empId" name="empId" /></td>
			</tr>
			<tr>
				<th><label for="empPass">비밀번호 : </label></th>
				<td><input type="password" id="empPass" name="empPass" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" id="btnLogin" value="로그인" /></td>
			</tr>
		</table>
	</form>



	<a id="kakao-login-btn"></a>
	<script>
		//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('b5cdc60bceb24a135c068ea11f8b1408');
		// 카카오 로그인 버튼을 생성합니다.
		Kakao.Auth.createLoginButton({
			container : '#kakao-login-btn',
			success : function(authObj) {
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						alert(JSON.stringify(res));
						var userNickName = JSON.stringify(res.properties.nickname);
						alert(userNickName);
						location.href = '/com/snslogin?userNickName='+userNickName;
						alert("dssda");
					},
					fail : function(err) {
						alert(JSON.stringify(err));
					}
				});
			}
		});
		//]]>
	</script>
</body>
</html>