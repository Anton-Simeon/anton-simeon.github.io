<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:forEach var="review" items="${reviews}">
	<li>
		<div>
			<div class="name">${customerOrders[review.id].customerFirstName}</div>
			<div class="review-date order-date-no-done">${customerOrders[review.id].orderDate}</div>
		</div>
		<div class="rating-section">
			<jsp:include page="rating-section.jsp">
				<jsp:param name="reviewId" value="${review.id}" />
				<jsp:param name="deliveryService" value="${review.deliveryService}" />
				<jsp:param name="foodQuality" value="${review.foodQuality}" />
				<jsp:param name="valueForMoney" value="${review.valueForMoney}" />
				<jsp:param name="isAverage" value="true" />
			</jsp:include>
		</div>
		<div class="comment">${review.comment}</div>
	</li>
</c:forEach>