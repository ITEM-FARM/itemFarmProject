<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tr>
		<th>Index</th>
		<th>상품코드</th>
		<th>상품명</th>
		<th>발주수량</th>
</tr>
<c:forEach items="${baljuList}" var="balju" varStatus="status">	
	<tr>
		<td>${status.count }</td>
		<td>${balju.product_code}</td>
		<td>${balju.product_name}</td>
		<td>${balju.balju_quantity}</td>
	</tr>
	
</c:forEach>



	  	