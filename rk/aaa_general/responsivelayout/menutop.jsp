<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="categories" scope="request" value="${menu.categories}" />
<c:set value="${company.companyType eq 'GROCERYPORTAL'}" var="isGrosseryStore"/>
<c:forEach var="thisCategory" items="${categories}">
	<c:if test="${thisCategory.id == currentCategory.id}">
		<c:set var="category" scope="request" value="${thisCategory}" />
	</c:if>
</c:forEach>
<c:if test="${category == null}">
	<c:set var="category" scope="request" value="${categories[0]}" />
</c:if>
<div class="restaurant-list-content">
	<div class="restaurant-data">
		<div class="row restaurant-info">
			<c:if test="${company.companyType != 'RESTAURANT'}">
			<div class="col-xs-4 col-sm-2 col-md-2">
				<div class="restaurant-img">
					<img src="${branch.locationWebLogoUrl}" />
				</div>
			</div>
			</c:if>
			<div class="col-xs-8 col-sm-10 col-md-8 restaurant-dcontent">
				<div class="">
					<h2>${branch.name}</h2>
					<c:if test="${branch.hasReviews}">
						<div class="clearfix">
							<div id="overAllReviewHeader" class="pull-left"></div><span class="pull-left" id="headerTotalReviewCount"></span>
						</div>
					</c:if>
					<c:if test="${branch.cuisineTypes.size() > 0}">
						<p class="text-color">
							<c:forEach var="branchCuisines" items="${branch.cuisineTypes}" varStatus="loop">
								${branchCuisines.name}<c:if test="${!loop.last}">, </c:if>
							</c:forEach>
						</p>
					</c:if>
					<div class="process-step">
						<div class="first-step">
							<c:if test="${branch.services.size() > 0}">
								<c:forEach var="thisBranchServices" items="${branch.services}" varStatus="loop">
									<c:if test="${thisBranchServices.active}">
										<c:choose>
											<c:when test="${thisBranchServices.orderType == 'DELIVERY'}">
												<span data-toggle="tooltip" class="process-icn delivery-icn" title="Delivery"></span>
											</c:when>
											<c:when test="${thisBranchServices.orderType == 'COLLECTION'}">
												<span data-toggle="tooltip" class="process-icn restaurant-icn" title="Collection"></span>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose> 
									</c:if>
								</c:forEach>
							</c:if>
						</div>
					</div>
					<c:set var="isDeliveryOpen" value="false" /> 
					<c:set var="isCollectionOpen" value="false" /> 
					<plastocart:isbranchopen orderType="DELIVERY" branch="${branch}">
						<c:set var="isDeliveryOpen" value="true" />
					</plastocart:isbranchopen> 
					<plastocart:isbranchopen orderType="COLLECTION" branch="${branch}">
						<c:set var="isCollectionOpen" value="true" />
					</plastocart:isbranchopen>
					<c:choose>
						<c:when test="${(isDeliveryOpen == 'true' or isCollectionOpen == 'true') and !isGrosseryStore}">
							<div class="status"><i></i><fmt:message key='locationresults.open' /></div>
						</c:when>
						<c:when test="${branch.hasPreOrdering or isGrosseryStore}">
							<div class="menu-top-opensatwriter">
								<plastocart:branchOpensAtDayTimeWriter branch="${branch}" isGrosseryStore="${isGrosseryStore}" hideOrderButton="true"/>
							</div>
						</c:when>
						<c:otherwise>
							<div class="restaurant-close"><div class="status"><i></i><fmt:message key='locationresults.closed' /></div></div>
						</c:otherwise>
					</c:choose> 
				</div>
			</div>
			<div class="col-xs-12 col-sm-8 col-md-8 restaurant-dcontent">
				<div>
					<c:if test="${sessionScope.fullLocation != null}">
						<p class="deliveryfee"><c:if test="${company.companyType != 'RESTAURANT' or isGrosseryStore}"></c:if>
							<plastocart:printdeliveryzoneandfee branchId="${branch.id}" location="${sessionScope.fullLocation}" />
						</p>
					</c:if>
					<c:forEach var="thisBranchDiscountRule" items="${branch.orderDiscountRules}" varStatus="loop">
						<c:choose>
							<c:when test="${thisBranchDiscountRule.chargeMode == 2}">
								<c:if test="${(thisBranchDiscountRule.active eq true) and (thisBranchDiscountRule.archive eq false)}">
									<p class="discount">
										<strong>${thisBranchDiscountRule.discount*100}% <fmt:message key='label.locationresults.offwhenyouspend' /> 
										<plastocart:gtz value="${thisBranchDiscountRule.subTotal}">
											<plastocart:fmcn locale="${defaultLocale}" value="${thisBranchDiscountRule.subTotal}" />
										</plastocart:gtz>
										<fmt:message key='label.locationresults.on' /> ${thisBranchDiscountRule.orderType} <fmt:message key='label.locationresults.and' /> ${thisBranchDiscountRule.paymentType}
										<c:if test="${thisBranchDiscountRule.useOnceOnly eq 'true'}"><fmt:message key='label.locationresults.useonlyonce.firsttime' /></c:if> </strong>
									</p>
								</c:if>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div class="min-delivery-amount">
					<fmt:message key='label.minimum.delivery' />: <span class="jsMinDeliveryAmount">${journeyState.minDeliveryAmount}</span>
				</div>
				<div class="delivery-charge-menu">
					<fmt:message key='label.delivery.charge' />:
					<span class="value">
						<plastocart:fmcn locale="${currencyLocale}" value="${journeyState.deliveryFee}" />
					</span>
				</div>
				<div class="symbol-js" style="display: none;"><plastocart:fmc locale="${currencyLocale}"  /></div>
			</div>
		</div>
	</div>
</div>