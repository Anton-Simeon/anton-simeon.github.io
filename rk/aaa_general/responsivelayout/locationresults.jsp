<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="restaurantUrl"><fmt:message key='url.path.restaurantsurl' /></c:set>
<c:set value="/${restaurantUrl}/${fullLocation}/pagination/page-2" var="paginationLink"></c:set>
<c:set value="/${restaurantUrl}/${fullLocation}/filter" var="filterLink"></c:set>
<c:set var="params" value="" />
<c:set var="companyparams" value="?companyId=${companyId}" />
<c:if test="${restaurantname != null}">
	<c:set var="params" value="?name=${restaurantname}" />
	<c:set var="companyparams" value="${companyparams}&name=${restaurantname}" />
</c:if>
<c:if test="${listCuisinesPagination != null}">
	<c:choose>
		<c:when test="${fn:contains(params, '?')}">
			<c:set var="params" value="${params}&listCuisines=${listCuisinesPagination}" />
		</c:when>
		<c:otherwise>
			<c:set var="params" value="${params}?listCuisines=${listCuisinesPagination}" />
		</c:otherwise>
	</c:choose>
	<c:set var="companyparams" value="${companyparams}&listCuisines=${listCuisinesPagination}" />
</c:if>
<c:if test="${company.deliveryZoneType eq 'CITYPOLYGON' or company.deliveryZoneType eq 'RADIUS_MILES' or company.deliveryZoneType eq 'RADIUS_KILOMETRES'}">
	<c:set value="/${restaurantUrl}/geolocationaddress/filter${companyparams}&latitude=${latitude}&longitude=${longitude}" var="filterLink"></c:set>
</c:if>
<input type="hidden" id="nextURL" name="nextURL" value="${paginationLink}${companyparams}">
<input type="hidden" id="filterURL" name="filterURL" value="${filterLink}${companyparams}" />
<div class="fancy-collapse-panel">
	<div role="tablist" aria-multiselectable="true">
		<div class="panel">
			<div class="panel-collapse collapse in" role="tabpanel">
				<div class="panel-body" id="load-restaurant-list">
					<c:choose>
						<c:when test="${widgetSite == 'true'}">
							<c:set var="companyparam" value="?companyId=${companyId}" />
						</c:when>
						<c:otherwise>
							<c:set var="companyparam" value="" />
						</c:otherwise>
					</c:choose>
					<ul class="event-list">
						<c:set value="${company.companyType eq 'GROCERYPORTAL'}" var="isGrosseryStore"/>
						<c:forEach var="thisBranchWrapper" items="${pagedListHolder.pageList}" varStatus="rowStatus">
						<c:set var="thisBranch" value="${thisBranchWrapper.branch}" />
						<c:choose>
							<c:when test="${isGrosseryStore}">
								<li id="${thisBranch.id}" onclick="location.href='/store/${thisBranch.urlPath}${companyparam}';">									
							</c:when>
							<c:otherwise>
								<li id="${thisBranch.id}" onclick="location.href='/menu/${thisBranch.urlPath}${companyparam}';">
							</c:otherwise>								
						</c:choose>						
							<div class="rest-logo">
								<c:if test="${not empty thisBranch.locationWebLogoUrl}">
									<c:choose>
										<c:when test="${isGrosseryStore}">
											<a href="/store/${thisBranch.urlPath}${companyparam}"><img src="${thisBranch.locationWebLogoUrl}" alt="${thisBranch.name}" /></a>										
										</c:when>
										<c:otherwise>
											<a href="/menu/${thisBranch.urlPath}${companyparam}"><img src="${thisBranch.locationWebLogoUrl}" alt="${thisBranch.name}" /></a>
										</c:otherwise>								
									</c:choose>
								</c:if>
							</div>
							<div class="info">
								<h2 class="title">${thisBranch.name}</h2>
								<c:if test="${company.companyType eq 'PORTAL' and thisBranch.hasReviews}">
									<c:choose>
										<c:when test="${branchReviewCount[thisBranch.id] > 0}">
											<div class="rating-section"><span class="pull-left"><span class="branch-rate" id='branchRating-${thisBranch.id}' data-rate="${branchRatings[thisBranch.id]}"></span></span><span class="pull-left">(${branchReviewCount[thisBranch.id]})</span></div>
										</c:when> 
									</c:choose>
								</c:if>
								<p class="subdesc">
									<c:if test="${!(company.companyType eq 'RESTAURANT')}">
									<c:choose>
										<c:when test="${thisBranch.cuisineTypes.size() > 0}">
											<c:forEach var="thisBranchCuisines" items="${thisBranch.cuisineTypes}" varStatus="loop">
												<fmt:message key="common.constant.cuisinetype.${thisBranchCuisines.name}" /><c:if test="${!loop.last}">, </c:if>
											</c:forEach>
										</c:when>    
							    		<c:otherwise>
								    		<!-- &nbsp; -->
										</c:otherwise>
									</c:choose>
									</c:if>
									<c:if test="${(company.companyType eq 'RESTAURANT')}">
										${thisBranch.addressLine1} ${thisBranch.addressLine2} ${thisBranch.city} ${thisBranch.postCode}
									</c:if>
								</p>
								<c:if test="${!(company.companyType eq 'RESTAURANT') or isGrosseryStore}">
								<p class="desc">
									<plastocart:printdeliveryzoneandfee branchId="${thisBranch.id}" location="${fullLocation}" />
								</p>
								</c:if>
								<c:forEach var="thisBranchDiscountRule" items="${thisBranch.orderDiscountRules}" varStatus="loop">
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
							<div class="social">
								<c:if test="${rowStatus.index < 2 and companyId == 48}">
									<div class="promoted">Ad</div>
								</c:if>
								<c:choose>
									<c:when test="${!isGrosseryStore and thisBranchWrapper.open}">
										<p class="text-right-status">
											<object data="/static/ordertigerwidget/images/open-icn.svg" class="svg-icn" type="image/svg+xml"></object>
											<span class="store-open-text"><fmt:message key='label.store.open' /></span>
										</p>
										<button type="submit" class="btn btn-primary"><fmt:message key='locationresults.button.ordernow' /></button>
									</c:when>
									<c:when test="${thisBranchWrapper.hasPreOrdering or isGrosseryStore}">								
										<span class="status-menu"><fmt:message key='label.store.orderforlater' /></span>
									</c:when>    
						    			<c:otherwise>
							    			<p class="text-right-status">
											<object data="/static/ordertigerwidget/images/close-icn.svg" class="svg-icn" type="image/svg+xml"></object>
											<span class="store-close-text"><fmt:message key='label.store.close' /></span>
										</p>
										<c:choose>
											<c:when test="${isGrosseryStore}">
												<button type="button" class="btn btn-primary"><fmt:message key='locationresults.button.viewshop' /></button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-primary"><fmt:message key='locationresults.button.viewmenu' /></button>										
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</div>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<c:if test="${pagedListHolder.pageCount > 1 }">
	<c:if test="${pagedListHolder.page < pagedListHolder.lastLinkedPage}">
		<div class="restaurant-listing-pagination">
			<div id="load-restaurant-link">
				<div id="loadingDiv" style="display:none"><img src='/static/aaa_general/images/ajax-loader.gif' width="32" height="32" /></div>
			</div>
		</div>
	</c:if>
</c:if>