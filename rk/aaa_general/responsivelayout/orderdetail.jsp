<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="reorderConfirmURL"><fmt:message key='url.path.reorderconfirm' /></c:set>
<c:set var="companyIdQueryString" value=""/>
<c:if test="${widgetSite == 'true'}">
 	<c:set var="companyIdQueryString" value="?companyId=${companyId}"/>
</c:if>
<fmt:setLocale value="companyLocale" />
<h2 class="profile-title"><fmt:message key='header.order.detail' /></h2>
<c:if test="${infoMessage != null}">
	<div class="alert alert-dismissible alert-info">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	${infoMessage}
	</div>
</c:if>
<c:if test="${warningMessage != null}">
	<div class="alert alert-dismissible alert-danger">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	${warningMessage}
	</div>
</c:if>
<div class="order-detail-from-to">
	<div class="row">
		<div class="col-6">
			<h4><fmt:message key='label.from' /></h4>
			<h5>${orderBranch.name}</h5>
			<p>
				<c:if test="${!empty orderBranch.addressLine1}">
					${orderBranch.addressLine1}
				</c:if>
				<c:if test="${!empty orderBranch.addressLine2}">
					<br /> ${orderBranch.addressLine2}
				</c:if>
				<c:if test="${!empty orderBranch.city != 'null'}">
					<br /> ${orderBranch.city}
				</c:if>
				<c:if test="${!empty orderBranch.county != 'null'}">
					<br /> ${orderBranch.county}
				</c:if>
				<c:if test="${!empty orderBranch.country != 'null'}">
					<br /> ${orderBranch.country}
				</c:if>
				<c:if test="${!empty orderBranch.postCode != 'null'}">
					<br /> ${orderBranch.postCode}
				</c:if>
			</p>
		</div>
		<div class="col-6">
			<h4><fmt:message key='label.to' /></h4>
			<h5>${customer.firstName} ${customer.lastName}</h5>
			<p>
				<c:forEach items="${company.addressFieldRules}" var="fieldRule">
					<c:if test="${fieldRule.display}">
						<c:forEach var="thisAddressFields" items="${address.customerOrderAddressFields}" varStatus="rowStatus1">
							<c:if test="${fieldRule.fieldName == thisAddressFields.fieldName}">
								${thisAddressFields.fieldValue}<br />
							</c:if> 
						</c:forEach>
					</c:if>
				</c:forEach>
			</p>
			<p>${customer.phone}</p>
		</div>
	</div>
</div>
<div class="form-profile">
	<h6><fmt:message key='label.order.capital' /> #${customerOrder.id}</h6>
	<div class="form-profile-content">
		<table class="table">
			<tbody>${orderItemDetails}</tbody>
		</table>
		<table class="table">
			<tbody>
				<c:if test="${customerOrder.deliveryCharge > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.delivery.charge' /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.deliveryCharge}" /></td>
					</tr>
				</c:if>
				<c:if test="${customerOrder.surCharge > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.surcharge' /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.surCharge}" /></td>
					</tr>
				</c:if>
				<c:if test="${customerOrder.orderDiscount > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.discount' /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.orderDiscount}" /></td>
					</tr>
				</c:if>
				<c:if test="${customerOrder.promoCodeDiscount > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.promocodediscount' /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.promoCodeDiscount}" /></td>
					</tr>
				</c:if>
				<c:if test="${customerOrder.orderCredit > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.ordercredit' /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.orderCredit}" /></td>
					</tr>
				</c:if>
				<c:forEach var="thisCustomerOrderTaxes" items="${customerOrder.customerOrderTaxes}" varStatus="rowStatus">
				<plastocart:gtz value="${thisCustomerOrderTaxes.taxAmount}">
				<tr>
					<c:choose>
						<c:when test="${thisCustomerOrderTaxes.chargeMode == 2}">
							<td class="col-md-6 col-sm-6 col-xs-6">${thisCustomerOrderTaxes.taxLabel} (<fmt:formatNumber type="number" maxFractionDigits="2" value="${thisCustomerOrderTaxes.rate*100}" />%)</td>								
						</c:when>
						<c:otherwise>
							<td class="col-md-6 col-sm-6 col-xs-6">${thisCustomerOrderTaxes.taxLabel}</td>
						</c:otherwise>
					</c:choose>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${currencyLocale}" value="${thisCustomerOrderTaxes.taxAmount}" /></td>
				</tr>
				</plastocart:gtz>
				</c:forEach>							
				<c:if test="${customerOrder.driverTip > 0}">
					<tr>
						<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key="label.drivertip" /></td>
						<td class="col-md-6 col-sm-6 col-xs-6 amount"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.driverTip}" /></td>
					</tr>
				</c:if>						
				<tr class="sub-total">
					<td class="col-md-6 col-sm-6 col-xs-6"><b><fmt:message key='label.total' /></b></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount"><b><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.subTotal}" /></b></td>
				</tr>
				<c:if test="${not empty customerOrder.specialInstructions}">
					<tr>
						<td colspan="2" class="wrap-sub-headingaddress">
							<h2><fmt:message key='label.specialinstructions' /></h2> <br />
							${customerOrder.specialInstructions}
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<div class="d-flex justify-content-md-end">
			<c:choose>
			<c:when test="${widgetSite == 'true'}">
			<button type="button" data-modal-href="/${reorderConfirmURL}/${customerOrder.id}?companyId=${companyId}" class="btn btn-primary ms-md-3" data-bs-toggle="modal" data-bs-target="#reorderConfirmModal">
				<fmt:message key="label.button.reorder" />
			</button>
			</c:when>
			<c:otherwise>
			<button type="button" data-modal-href="/${reorderConfirmURL}/${customerOrder.id}" class="btn btn-primary ms-md-3" data-bs-toggle="modal" data-bs-target="#reorderConfirmModal">
				<fmt:message key="label.button.reorder" />
			</button>
			</c:otherwise>
			</c:choose>
			<c:if test="${orderBranch.hasReviews}">
				<c:choose>
					<c:when test="${customerOrder.review eq null}">
						<a class="btn btn-primary ms-md-3" href="/order/review-order/${customerOrder.id}${companyIdQueryString}">
							<fmt:message key="label.reviews.button.revieworder" />
						</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-primary ms-md-3" href="/order/view-review/${customerOrder.review.id}${companyIdQueryString}">
							<fmt:message key="label.reviews.button.viewreview" />
						</a>
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</div>
</div>