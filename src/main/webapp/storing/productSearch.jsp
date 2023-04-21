<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.card {
	margin: auto;
}

.btn {
	text-align: right;
}
</style>
<%-- <ul>
		<li>${product.product_code}</li>
		<li>${product.product_name}</li>
		<li>${product.product_stock}</li>
		<li>${product.product_safety}</li>
	</ul> --%>

<c:forEach items="${productList}" var="product" varStatus="status">
	<div class="card col-sm-6">
		<h5 class="card-header">검색된 품목 1</h5>
		<div class="card-body">
			<p class="card-text">상품코드 : ${product.product_code}</p>
			<p class="card-text">상품명 : ${product.product_name}</p>
			<p class="card-text">현재고 : ${product.product_stock}</p>
			<p class="card-text">안전재고 : ${product.product_safety}</p>
			<div class="d-flex flex-row bd-highlight mb-3">
				<input id="quantity${status.count}"    type="number" class="form-control" aria-label="quantity input with dropdown button"  placeholder="수량입력" /> 
				<input id="storingCount" class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-primary text-white" type="button"  
				onclick="f_storingCount(${product.product_code},'${product.product_name}', this, ${status.count})"
				value="입고" />
			</div>
		</div>,
	</div>
	<p>
</c:forEach>






