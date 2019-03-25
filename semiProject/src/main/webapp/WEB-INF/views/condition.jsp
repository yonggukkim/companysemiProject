<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
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
						<tr class="cli1">
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