<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach items="${baljulist}" var="balju" varStatus="status">
	<tr>
		<td id="${balju.balju_code}">
			<div class="form-check"><input class="form-check-input text-center mx-0 my-2"  name="checkBaljuOne" type="checkbox" value="${balju.balju_code}" >
			</div>
		</td>
		<td>${status.count}</td>
		<td>
			<a href="javascript:searchBaljuProducts('${balju.balju_code}')">
			${balju.balju_code}</a>
		</td>
		<td><fmt:formatDate value="${balju.balju_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
		<td>${balju.manager_id}</td>
		<td>${balju.balju_memo}</td>
	</tr>
</c:forEach>

