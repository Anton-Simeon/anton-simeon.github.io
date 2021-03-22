<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<div class="row">
	<div class="col-md-5">
		<div class="mb-3">
			<h2 class="menu-title">${branch.name}</h2>
			<c:if test="${branch.hasReviews}">
				<div class="menu-rating">
					<div id="overAllReviewHeader"></div><span id="headerTotalReviewCount"></span>
				</div>
			</c:if>
			<c:if test="${not empty menus}">
				<c:if test="${menus.size() gt 1}">
					<div class="dropdown-select d-none d-md-block">
						<div class="form-select" data-bs-toggle="dropdown" aria-expanded="false">
							<c:choose>
								<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
									${menu.name2}					
								</c:when>
								<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
									${menu.name3}
								</c:when>
								<c:otherwise>
									${menu.name1}
								</c:otherwise>
							</c:choose>				
						</div>			
						<ul class="dropdown-menu">
							<c:forEach var="thisMenu" items="${menus}" varStatus="status">
								<c:choose>
									<c:when test="${menu.language2 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
										<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name2}</a></li>
									</c:when>
									<c:when test="${menu.language3 eq sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
										<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name3}</a></li>
									</c:when>
									<c:otherwise>
										<li><a class="dropdown-item" href="/${locationUrl}/${branch.urlPath}/${thisMenu.id}?companyId=${companyId}">${thisMenu.name1}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</c:if>
		</div>
	</div>
	<div class="col-md-7">
		<div class="d-flex justify-content-end align-items-center">
			<div id="statusText" class="status-menu" style="opacity: 0;"></div>
			<c:forEach var="thisBranchDiscountRule" items="${branch.orderDiscountRules}" varStatus="loop">
				<c:choose>
					<c:when test="${thisBranchDiscountRule.chargeMode == 2}">
						<c:if test="${(thisBranchDiscountRule.active eq true) and (thisBranchDiscountRule.archive eq false)}">
							<div class="button-menu-discount">
								<i class="icon-discount-badge"></i>
								<div class="delivery-tooltip">
									<p>
										<b>${thisBranchDiscountRule.discount*100}% <fmt:message key='label.locationresults.offwhenyouspend' /> 
										<plastocart:gtz value="${thisBranchDiscountRule.subTotal}">
											<plastocart:fmcn locale="${defaultLocale}" value="${thisBranchDiscountRule.subTotal}" />
										</plastocart:gtz>
										<fmt:message key='label.locationresults.on' /> ${thisBranchDiscountRule.orderType} <fmt:message key='label.locationresults.and' /> ${thisBranchDiscountRule.paymentType}
										<c:if test="${thisBranchDiscountRule.useOnceOnly eq 'true'}"><fmt:message key='label.locationresults.useonlyonce.firsttime' /></c:if> </b>
									</p>
								</div>
							</div>
						</c:if>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${branch.services.size() > 0}">
				<c:forEach var="thisBranchServices" items="${branch.services}" varStatus="loop">
					<c:if test="${thisBranchServices.active}">
						<c:choose>
							<c:when test="${thisBranchServices.orderType == 'DELIVERY'}">
								<!-- <span data-toggle="tooltip" class="process-menu-icn delivery-menu-icn" title="Delivery"></span> -->
							</c:when>
						</c:choose> 
					</c:if>
				</c:forEach>
			</c:if>
			<div class="button-menu-info" data-bs-toggle="modal" data-bs-target="#info-modal"><i class="icon-info"></i></div>
		</div>
		<div class="text-end mt-3 mb-3">
			<div class="min-delivery-amount">
				<fmt:message key='label.minimum.delivery' />: <span class="jsMinDeliveryAmount">${journeyState.minDeliveryAmount}</span>
			</div>
			<div class="delivery-charge-menu">
				<fmt:message key='label.delivery.charge' />:
				<span class="value">
					<plastocart:fmcn locale="${defaultLocale}" value="${journeyState.deliveryFee}" />
				</span>
			</div>
		</div>
		<div class="symbol-js" style="display: none;"><plastocart:fmc locale="${currencyLocale}"  /></div>
	</div>
</div>