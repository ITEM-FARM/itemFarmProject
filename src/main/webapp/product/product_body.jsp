<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach items="${productList}" var="product">
	<tr>
		<td>
			<a data-product="${product}" class="modal-link"
			href="../productDetail-code:${product.product_code}" role="button"
			aria-haspopup="true" aria-expanded="false" data-toggle="modal"
			data-target="#ProductModifyModal">${product.product_code}</a>
		</td>
		<td>
			<a data-product="${product}" class="modal-link"
			href="../productDetail-name:${product.product_name}" role="button"
			aria-haspopup="true" aria-expanded="false" data-toggle="modal"
			data-target="#ProductModifyModal">${product.product_name}</a>
		</td>
		<td>${product.subcategory_name}</td>
		<td><fmt:formatNumber value="${product.product_cost}"></fmt:formatNumber></td>
		<td><fmt:formatNumber value="${product.product_price}"></fmt:formatNumber></td>
		<td>${product.product_stock}</td>
		<td>${product.product_safety}</td>
		<td><fmt:formatDate value="${product.product_regdate}"
				pattern="yyyy-MM-dd hh:mm:ss" /></td>
		<td>${product.product_status == "Y".charAt(0) ? "활성" : "비활성"}</td>
		<td>${product.manager_name}</td>
	</tr>
</c:forEach>