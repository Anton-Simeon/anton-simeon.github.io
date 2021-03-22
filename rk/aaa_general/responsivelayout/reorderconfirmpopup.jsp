<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="reorderUrl"><fmt:message key='url.path.reorder' /></c:set>
<fmt:setLocale value="currencyLocale" />
<c:if test="${infoMessage != null}">
	<div class="alert alert-dismissible alert-info">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	<strong>${infoMessage}</strong>
	
	</div>
</c:if>
<c:if test="${warningMessage != null}">
	<div class="alert alert-dismissible alert-danger">
	<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	<strong>${warningMessage}</strong>
	
	</div>
</c:if>
<div class="modal-header">
	<h4 class="modal-title">&nbsp;</h4>
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
<%-- 	<h4 class="modal-title" style="text-align:center;font-size:18px;"><fmt:message key='label.reorderconfirm' /></h4> --%>
</div>
<div class="form-profile-modal">
	<table class="table">
		<tbody>${orderItemDetails}</tbody>
	</table>
	<table class="table">
		<tbody>
			<c:if test="${customerOrder.deliveryCharge > 0}">
				<tr>
					<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.delivery.charge' /></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount">
						<plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.deliveryCharge}"  />
					</td>
				</tr>
			</c:if>
			<c:if test="${customerOrder.surCharge > 0}">
				<tr>
					<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.surcharge' /></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount">
						<plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.surCharge}" />
					</td>
				</tr>
			</c:if>
			<c:if test="${customerOrder.orderDiscount > 0}">
				<tr>
					<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.discount' /></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount">
						<plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.orderDiscount}" />
					</td>
				</tr>
			</c:if>
			<c:if test="${customerOrder.promoCodeDiscount > 0}">
				<tr>
					<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.promocodediscount' /></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount">
						<plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.promoCodeDiscount}" />
					</td>
				</tr>
			</c:if>
			<c:if test="${customerOrder.orderCredit > 0}">
				<tr>
					<td class="col-md-6 col-sm-6 col-xs-6"><fmt:message key='label.ordercredit' /></td>
					<td class="col-md-6 col-sm-6 col-xs-6 amount">
						<plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.orderCredit}" />
					</td>
				</tr>
			</c:if>
			<tr class="sub-total">
				<td class="col-md-6 col-sm-6 col-xs-6"><b><fmt:message key='label.total' /></b></td>
				<td class="col-md-6 col-sm-6 col-xs-6 amount"><b> <plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.subTotal}" />
				</b></td>
			</tr>
			<c:if test="${not empty customerOrder.specialInstructions}">
				<tr>
					<td colspan="2">
						<h2><fmt:message key='label.specialinstructions' /></h2> <br />
						${customerOrder.specialInstructions}
					</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="d-flex justify-content-between">
		<button type="button" class="btn btn-secondary" aria-pressed="true" data-bs-dismiss="modal"><fmt:message key='label.button.cancel' /></button>
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${reorderUrl}/${customerOrder.id}?companyId=${companyId}" class="btn btn-primary" id="submitbutton">
					<fmt:message key='label.button.addorderitem' />
				</a>
			</c:when>
			<c:otherwise>
				<a href="/${reorderUrl}/${customerOrder.id}" class="btn btn-primary" id="submitbutton">
					<fmt:message key='label.button.addorderitem' />
				</a>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</div>