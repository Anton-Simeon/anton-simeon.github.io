<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${sessionScope.fullLocation == null}">
	<c:set var="fullLocation" value="all" scope="session" />
</c:if>
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
<c:set value="/stores/${fullLocation}/filter${companyparams}" var="filterLink"></c:set>
<c:set value="/stores/${fullLocation}/pagination/page-2${companyparams}" var="paginationLink"></c:set>
<c:if test="${company.deliveryZoneType eq 'CITYPOLYGON' or company.deliveryZoneType eq 'RADIUS_MILES' or company.deliveryZoneType eq 'RADIUS_KILOMETRES'}">
	<c:set value="${filterLink}&latitude=${latitude}&longitude=${longitude}" var="filterLink"></c:set>
	<c:set value="${paginationLink}&latitude=${latitude}&longitude=${longitude}" var="paginationLink"></c:set>
</c:if>
<input type="hidden" id="nextURL" name="nextURL" value="${paginationLink}">
<input type="hidden" id="filterURL" name="filterURL" value="${filterLink}" />


<input type="hidden" id="labelStoreOpen" value="<fmt:message key='label.store.open' />" />
<input type="hidden" id="labelStoreOrderforlater" value="<fmt:message key='label.store.orderforlater' />" />
<input type="hidden" id="labelStoreClose" value="<fmt:message key='label.store.close' />" />
<input type="hidden" id="labelStoreOffline" value="<fmt:message key='label.store.offline' />" />


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
					<div class="filter-button-sidebar">
						<a href="#"><fmt:message key="label.filter" /> <i class="icon icon-equalizer"></i></a>
					</div>
					<input type="hidden" id="businessFilterLink" name="businessFilterLink" value="${filterLink}">
					<input type="hidden" id="businessPaginationLink" name="businessPaginationLink" value="${paginationLink}">
					<ul class="products-list2">
						<c:set value="${company.companyType eq 'GROCERYPORTAL'}" var="isGrosseryStore"/>
						<c:forEach var="thisBranchWrapper" items="${pagedListHolder.pageList}" varStatus="rowStatus">
							<c:set var="thisBranch" value="${thisBranchWrapper.branch}" />
							<li id="${thisBranch.id}" onclick="location.href='/store/${thisBranch.urlPath}${companyparam}';">	
							<a href="/store/${thisBranch.urlPath}${companyparam}" class="one-product2">		
								<div class="product-img-wrap-main">
									<c:choose>
										<c:when test="${not empty thisBranch.locationWebLogoUrl}">
										    <c:set var="logoUrl" value="${fn:replace(thisBranch.locationWebLogoUrl, '/image/upload/v', '/image/upload/f_auto,q_auto,dpr_auto,w_640,c_limit/v')}" />
											<c:choose>
												<c:when test="${isGrosseryStore}">
													<div class="product-img-wrap" /><div style="background-image: url(${logoUrl});"></div></div>
												</c:when>
												<c:otherwise>
													<div class="product-img-wrap" /><div style="background-image: url(${logoUrl});"></div></div>
												</c:otherwise>								
											</c:choose>
										</c:when>
										<c:otherwise>
											<div class="product-img-wrap"/></div>
										</c:otherwise>	
									</c:choose>
									<c:choose>
										<c:when test="${thisBranchWrapper.isOpen}">
											<span class="status-menu"><fmt:message key='label.store.open' /></span>
										</c:when>
										<c:when test="${thisBranchWrapper.hasPreOrdering}">								
											<span class="status-menu status-menu-pre"><fmt:message key='label.store.orderforlater' /></span>
										</c:when> 
										<c:when test="${thisBranchWrapper.isClosed}">								
											<span class="status-menu status-menu-close"><fmt:message key='label.store.close' /></span>
										</c:when>										 
							    			<c:otherwise>
											<span class="status-menu status-menu-offline"><fmt:message key='label.store.offline' /></span>
										</c:otherwise>
									</c:choose>			
								</div>
								<h2 class="product-title">${thisBranch.name}</h2>
								<p class="subdesc">									
									<c:if test="${(company.companyType eq 'RESTAURANT')}">
										${thisBranch.addressLine1} ${thisBranch.addressLine2} ${thisBranch.city} ${thisBranch.postCode}
									</c:if>
								</p>
								<div class="clearfix">
									<c:if test="${company.companyType eq 'PORTAL'}">								
										<c:choose>
											<c:when test="${thisBranch.hasReviews}">
												<div class="rating-wrap">
													<div class="rating-section"><span class="pull-left"><span class="branch-rate" id='branchRating-${thisBranch.id}' data-rate="${branchRatings[thisBranch.id]}"></span></span><span class="pull-left">${branchReviewCount[thisBranch.id]}</span></div>
												</div>
											</c:when> 
										</c:choose>
									</c:if>
									<c:forEach var="thisBranchDiscountRule" items="${thisBranch.orderDiscountRules}" varStatus="loop">
										<c:choose>
											<c:when test="${thisBranchDiscountRule.chargeMode == 2}">
												<c:if test="${(thisBranchDiscountRule.active eq true) and (thisBranchDiscountRule.archive eq false)}">
													<div class="process-menu-icn restaurant-menu-icn">
														<div class="delivery-tooltip">
															<p class="discount">
																<strong>${thisBranchDiscountRule.discount*100}% <fmt:message key='label.locationresults.offwhenyouspend' /> 
																	<plastocart:gtz value="${thisBranchDiscountRule.subTotal}">
																		<plastocart:fmcn locale="${defaultLocale}" value="${thisBranchDiscountRule.subTotal}" />
																	</plastocart:gtz>
																	<fmt:message key='label.locationresults.on' /> ${thisBranchDiscountRule.orderType} <fmt:message key='label.locationresults.and' /> ${thisBranchDiscountRule.paymentType}
																	<c:if test="${thisBranchDiscountRule.useOnceOnly eq 'true'}"><fmt:message key='label.locationresults.useonlyonce.firsttime' /></c:if> 
																</strong>
															</p>
														</div>								
													</div>								
												</c:if>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:forEach>
								</div>
							</a>
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
<c:if test="${pagedListHolder.pageCount < 2 }">
	<div class="restaurant-listing-pagination">
		<div id="loadingDiv" style="display:none"><img src='/static/aaa_general/images/ajax-loader.gif' width="32" height="32" /></div>
	</div>
</c:if>