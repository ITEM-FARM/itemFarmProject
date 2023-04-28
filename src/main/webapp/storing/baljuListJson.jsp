<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
{"dataSet": [  
<c:forEach items="${baljuListRows}" var="baljuRow" varStatus="status">
	{
	  "baljuCode" : "${baljuRow.balju_code}",
	  "productCode" : "${baljuRow.product_code}",
	  "productName" : "${baljuRow.product_name}",
	  "baljuQuantity" : "${baljuRow.balju_quantity}"
	}
	
	<c:if test="${not status.last}">
	,
	</c:if>

</c:forEach>
]
}
