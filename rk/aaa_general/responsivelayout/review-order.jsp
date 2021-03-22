<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="reorderConfirmURL"><fmt:message key='url.path.reorderconfirm' /></c:set>
<c:set var="companyIdQueryString" value=""/>
<c:if test="${widgetSite == 'true'}">
	<c:set var="companyIdQueryString" value="?companyId=${companyId}"/>
</c:if>
<div class="order-review">
	<fmt:message key="label.reviews.orderfrom" /> <br>
	<div class="branch-name">${branch.name}</div>
	<div>${customerOrder.orderStatus}</div>
	<h4>${customerOrder.orderDate}</h4>
	<div class="top-buttons">
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${reorderConfirmURL}/${customerOrder.id}?companyId=${companyId}" oncontextmenu="return false;" data-toggle="modal" role="button" data-refresh="true" title="ReorderConfirmModal" data-target="#reorderConfirmModal" >
					<button type="button" class="btn btn-primary full-width" id="submitbutton">
						<fmt:message key="label.button.reorder" />
					</button>
				</a>
			</c:when>
			<c:otherwise>
				<a href="/${reorderConfirmURL}/${customerOrder.id}" oncontextmenu="return false;" data-toggle="modal" role="button" data-refresh="true" title="ReorderConfirmModal" data-target="#reorderConfirmModal" >
					<button type="button" class="btn btn-primary full-width" id="submitbutton">
						<fmt:message key="label.button.reorder" />
					</button>
				</a>
			</c:otherwise>
		</c:choose>
		<a href="/menu/${branch.urlPath}${companyIdQueryString}" oncontextmenu="return false;" role="button" data-refresh="true" title=<fmt:message key="locationresults.button.viewmenu" />>
			<button type="button" class="btn btn-primary full-width" id="submitbutton">
				<fmt:message key="locationresults.button.viewmenu" />
			</button>
		</a>
	</div>
	<c:if test="${reviewSuccess eq true}">
		<h4><fmt:message key="label.review.message.success"></fmt:message></h4>
	</c:if>
	<div class="row justify-content-center">
		<div class="col-lg-6">
			<c:choose>
				<c:when test="${reviewSuccess eq true}">
					<div class="review-form">
						<div class="mb-3">
							<label for="delivery-service">
								<fmt:message key='label.reviews.orderdeliveryservice' />
							</label>
							<div id="orderDeliveryService" class="rating-center"></div>
						</div>
						<div class="mb-3">
							<label for="value-for-Money">
								<fmt:message key='label.reviews.ordervalueforMoney' />
							</label>
							<div id="orderValueForMoney" class="rating-center"></div>
						</div>
						<div class="mb-3">
							<label for="food-quality">
								<fmt:message key='label.reviews.orderfoodquality' />
							</label>
							<div id="orderFoodQuality" class="rating-center"></div>
						</div>
						<div class="mb-3">
							<label for="leave-review">
								<fmt:message key='label.reviews.review' />
							</label>
							${reviewForm.comment}	
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<form:form action="/order/review-order/${customerOrder.id}" method="POST" modelAttribute="reviewForm">
						<div class="review-form">
							<form:hidden path="customerOrderId"></form:hidden>
							<form:hidden path="customerId"></form:hidden>		
							<form:hidden path="companyId"></form:hidden>		
							<form:hidden path="branchId"></form:hidden>
							<div class="mb-3">
								<label for="delivery-service">
									<fmt:message key='label.reviews.mealquestion' >
										<fmt:param value="${customer.firstName}"/>
									</fmt:message>
								</label>
							</div>
							<div class="mb-3">
								<label for="delivery-service">
									<fmt:message key='label.reviews.orderdeliveryservice' />
								</label>
								<div id="orderDeliveryService" class="rating-center"></div>
								<form:hidden path="deliveryService"></form:hidden>			
							</div>
							<div class="mb-3">
								<label for="value-for-Money">
									<fmt:message key='label.reviews.ordervalueforMoney' />
								</label>
								<div id="orderValueForMoney" class="rating-center"></div>
								<form:hidden path="valueForMoney"></form:hidden>
							</div>
							<div class="mb-3">
								<label for="food-quality">
									<fmt:message key='label.reviews.orderfoodquality' />
								</label>
								<div id="orderFoodQuality" class="rating-center"></div>
								<form:hidden path="foodQuality"></form:hidden>					
							</div>
							<div class="mb-3">
								<label for="leave-review">
									<fmt:message key='label.reviews.leavereview' />
								</label>
								<c:set var="commentPlaceholder"><fmt:message key='label.reviews.leavereview' /></c:set> 
								<form:textarea class="form-control" rows="3"  path="comment"  placeholder="${commentPlaceholder}"></form:textarea>		
							</div>
							<button class="btn btn-primary btn-block review-button" type="submit">Submit</button>
						</div>
					</form:form>
				</c:otherwise>
			</c:choose>			
		</div>
	</div>
</div>
<div id="reorderConfirmModal" data-modal-ajax class="modal spinner-active modal-style-header" role="dialog">
	<div class="lds-spinner"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>
	<div id="test" class="modal-dialog">
		<div class="modal-content"></div>
	</div>
</div>
<script type="text/javascript">
	jQuery(document).ready(function(){
		var defaultValue = {
			rating: parseFloat('0'),
			starWidth: "30px"
		};
		jQuery("#orderDeliveryService").rateYo({
			rating: parseFloat('${reviewForm.deliveryService eq null ? 0 : reviewForm.deliveryService}'),
			starWidth: "30px",
			readOnly : eval('${reviewSuccess eq true}')
		}).on("rateyo.change", function (e, data) {
            var rating = data.rating;
            jQuery("#deliveryService").val(rating);
        });
		jQuery("#orderValueForMoney").rateYo({
			rating: parseFloat('${reviewForm.valueForMoney eq null ? 0 : reviewForm.valueForMoney}'),
			starWidth: "30px",
			readOnly : eval('${reviewSuccess eq true}')
		}).on("rateyo.change", function (e, data) {
            var rating = data.rating;
            jQuery("#valueForMoney").val(rating);
        });
		jQuery("#orderFoodQuality").rateYo({
			rating: parseFloat(' ${reviewForm.foodQuality eq null ? 0 : reviewForm.foodQuality}'),
			starWidth: "30px",
			readOnly : eval('${reviewSuccess eq true}')
		}).on("rateyo.change", function (e, data) {
            var rating = data.rating;
            jQuery("#foodQuality").val(rating);
        });
	});
</script>