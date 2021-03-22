<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<c:set var="guestsubmitOrderUrl"><fmt:message key='url.path.guestsubmitorder' /></c:set>
<c:set var="payByCardUrl"><fmt:message key='url.path.paybycard' /></c:set>
<c:set var="guestConfirmDetailsUrl"><fmt:message key='url.path.guestconfirmdetails' /></c:set>
<c:set var ="submitButttonkey" value="${param.submitButtonKey}"></c:set>
<c:if test="${submitButttonkey eq null}">
	<c:set var="submitButttonkey" value="label.button.submitordertorestaurant"></c:set>
</c:if>
<script type="text/javascript">	
	function agreeToTermsCheck() {
		if (jQuery('#agreetoterms').prop('checked') == false) {
			alert('<fmt:message key="submitorder.agreetoterms" />');
			return false;
		} else {
			return confirm('<fmt:message key="submitorder.alert" />');
		}
	}
	function submitForm() {
		document.editDetails.submit();
	}
</script>
<h2><fmt:message key="header.order.summary" /></h2>
<c:if test="${warningMessage != null}">
	<div class="validation">
		${warningMessage}
	</div>
</c:if>
<table class="table">
	<thead>
		<tr>
			<th><fmt:message key="label.fooditem" /></th>
			<th class="text-center"><fmt:message key="label.qty" /></th>
			<th class="amount"><fmt:message key="label.amount" /></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="thisOrderItem" items="${shoppingcart.items}">	
			<plastocart:getshoppingcartmenuconfirmation orderItem="${thisOrderItem}" menu="${menu}" />	
		</c:forEach>
	</tbody>
</table>
<div class="row">
	<div class="col-md-7 col-sm-7 col-xs-12">
		<c:set var="customerOrder" value="${customerorder}" />
		<table class="table table-border-free">
			<tbody>
				<tr>
					<td><fmt:message key="label.paymenttype.capital" />:</td>
					<td><plastocart:getmessage messageCode="${customerOrder.paymentType}" /></td>
				</tr>
				<tr>
					<td><plastocart:getmessage messageCode="${customerOrder.orderType}" />:</td>
					<td>[<fmt:message key="label.ordertime.capital" />: ${customerOrder.orderTime}]</td>
				</tr>
				<c:if test="${not empty customerOrder.specialInstructions}">
					<tr>
						<td><fmt:message key="label.specialinstructions.capital" />:<br /></td>
						<td>${customerOrder.specialInstructions}</td>
					</tr>
				</c:if>		
				<c:if test="${not empty customerOrder.promoCode}">
					<tr>
						<td><fmt:message key="label.promotionalcode.capital" />:</td>
						<td>${customerOrder.promoCode}</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div class="col-md-5 col-sm-5 col-xs-12">
		<table class="table">
			<tbody>
				<tr class="total-food-price">
					<td><fmt:message key="label.subtotal" /></td>
					<td class="text-right"><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></td>
				</tr>
				<plastocart:gtz value="${customerOrder.deliveryCharge}">
				<c:if test="${customerOrder.orderType == 'DELIVERY'}">
				<tr>
					<td class="ordertotal"><fmt:message key="label.delivery.charge" /></td>
					<td class="ordertotal_nr"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.deliveryCharge}" /></td>
				</tr>
				</c:if>				
				</plastocart:gtz>				
				<plastocart:gtz value="${customerOrder.surCharge}">
				<tr>
					<td class="ordertotal"><fmt:message key="label.surcharge" /></td>
					<td class="ordertotal_nr"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.surCharge}" /></td>
				</tr>		
				</plastocart:gtz>
				<plastocart:gtz value="${customerOrder.orderDiscount}">
				<tr>
					<td class="ordertotal"><fmt:message key="label.discount" /></td>
					<td class="ordertotal_nr"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.orderDiscount}" /></td>
				</tr>	
				</plastocart:gtz>
				<plastocart:gtz value="${customerOrder.promoCodeDiscount}">
				<tr>
					<td class="ordertotal"><fmt:message key="label.promotionalcodediscount" /></td>
					<td class="ordertotal_nr"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.promoCodeDiscount}" /></td>
				</tr>	
				</plastocart:gtz>
				<c:forEach var="thisCustomerOrderTaxes" items="${customerOrder.customerOrderTaxes}" varStatus="rowStatus">
				<plastocart:gtz value="${thisCustomerOrderTaxes.taxAmount}">
				<tr>
					<c:choose>
						<c:when test="${thisCustomerOrderTaxes.chargeMode == 2}">
							<td class="ordertotal">${thisCustomerOrderTaxes.taxLabel} (<fmt:formatNumber type="number" maxFractionDigits="2" value="${thisCustomerOrderTaxes.rate*100}" />%)</td>								
						</c:when>
						<c:otherwise>
							<td class="ordertotal">${thisCustomerOrderTaxes.taxLabel}</td>
						</c:otherwise>
					</c:choose>
					<td class="ordertotal_nr"><plastocart:fmcn locale="${defaultLocale}" value="${thisCustomerOrderTaxes.taxAmount}" /></td>
				</tr>
				</plastocart:gtz>
				</c:forEach>
				<plastocart:gtz value="${customerOrder.driverTip}">
					<tr class="total-food-price">
						<td><fmt:message key="label.drivertip" /></td>
						<td class="text-right"><plastocart:fmcn locale="${currencyLocale}" value="${customerorder.driverTip}" /></td>
					</tr>
				</plastocart:gtz>				
			</tbody>			
			<tfoot>
				<tr class="sub-total">
					<td><fmt:message key="label.total" /></td>
					<td class="amount"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.subTotal}" /></td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<div class="row">
	<c:set var="paymentForm" value="${paymentmethod.paymentForm}" />
	<c:if test="${paymentForm == 8}">
		<div class="col-md-4 col-sm-4 col-xs-12 pull-right edit-details">
			<input type="checkbox" name="agreetoterms" id="agreetoterms" /><fmt:message key="label.agreetoterms" />
		</div>
	</c:if>
	<div class="col-lg-3 col-md-5 col-sm-6 col-xs-12 pull-left edit-details">
		<form action="/${guestConfirmDetailsUrl}" method="get" name="editDetails">
		<input type="hidden" name="companyId" id="companyId" value="${companyId}">
			<a href="javascript: submitForm();" class="btn btn-primary btn-block"><i class="arrow-right-circle"></i><fmt:message key="label.button.edit" /></a>
		</form>
	</div>
	<div class="col-lg-3 col-md-5 col-sm-6 col-xs-12 pull-right">
		<c:choose>
			<c:when test="${paymentmethod.paymentType == 'CASH' or paymentmethod.paymentType == 'CHEQUE' or paymentmethod.paymentType == 'CARDTERMINAL'}">
				<form onsubmit="return agreeToTermsCheck()" action="/${guestsubmitOrderUrl}" method="post">
					<input type="hidden" name="companyId" id="companyId" value="${companyId}">
					<c:choose>
						<c:when test="${param.custombuttons == 'yes'}">				
							<c:choose>
								<c:when test="${param.hoverbuttons == 'yes'}">
									<button type="submit" class="btn btn-primary btn-block"><fmt:message key="${submitButttonkey}" /></button>							
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary btn-block"><fmt:message key="${submitButttonkey}" /></button>							
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<button type="submit" class="btn btn-primary btn-block"><fmt:message key="${submitButttonkey}" /></button>		
						</c:otherwise>
					</c:choose>			
				</form>				
			</c:when>
			<c:otherwise>
				<tg:paymentformgenerator />
			</c:otherwise>
		</c:choose>
		<c:if test="${paymentmethod.paymentType == 'CARDTERMINAL'}">
			<fmt:message key="mobileterminal.securiy.message" />
		</c:if>
	</div>
</div>