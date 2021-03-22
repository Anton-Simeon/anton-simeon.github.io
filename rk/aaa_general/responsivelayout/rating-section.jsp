<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="">
	<c:choose>
		<c:when test="${param.isAverage}">
			<div id="average${param.reviewId}"></div>
		</c:when>
		<c:otherwise>
			Deliver service :- <div id="deliveryService${param.reviewId}"></div><br/>
			Value For money :- <div id="valueForMoney${param.reviewId}"></div><br/>
			Food Quality :- <div id="foodQuality${param.reviewId}"></div><br/>
		</c:otherwise>
	</c:choose>
</div>
<script>
jQuery(document).ready(function(){
	var isAverage = ${param.isAverage};
	var rating${param.reviewId} = {
		deliveryService : parseFloat('${param.deliveryService}'),
		foodQuality : parseFloat('${param.foodQuality}'),
		valueForMoney : parseFloat('${param.valueForMoney}')
	};
	if(isAverage) {
		var averageRating = (rating${param.reviewId}.deliveryService + rating${param.reviewId}.foodQuality + rating${param.reviewId}.valueForMoney) / 3;
		jQuery("#average${param.reviewId}").rateYo({
			rating: averageRating,
			readOnly: true,
			starWidth: "14px"
		});
	} else {
		jQuery("#deliveryService${param.reviewId}").rateYo({
			rating: rating${param.reviewId}.deliveryService
		});
		jQuery("#valueForMoney${param.reviewId}").rateYo({
			rating: rating${param.reviewId}.valueForMoney
		});
		jQuery("#foodQuality${param.reviewId}").rateYo({
			rating: rating${param.reviewId}.foodQuality
		});	
	}	
});
</script>