<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:forEach items="${storingDetail}" var="detail" varStatus="status">
	<tr>
		<td>${status.count }</td>
		<td>${detail.product_code}</td>
		<td>${detail.product_name}</td>
		<td>${detail.storing_quantity}</td>
	</tr>
</c:forEach>
					
					  	