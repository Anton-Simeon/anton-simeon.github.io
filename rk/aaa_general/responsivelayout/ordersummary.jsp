<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<c:set var="checkOutUrl"><fmt:message key='url.path.checkout' /></c:set>
<c:set var="submitOrderUrl"><fmt:message key='url.path.submitorder' /></c:set>
<c:set var="payByCardUrl"><fmt:message key='url.path.paybycard' /></c:set>
<c:set var="currencyLocale" value="${defaultLocale}"></c:set>
<c:set var ="submitButttonkey" value="${param.submitButtonKey}"></c:set>
<c:set var ="companyName" value="${company.name}"></c:set>
<c:set var ="customerEmail" value="${customer.email}"></c:set>
<c:if test="${submitButttonkey eq null}">
	<c:set var="submitButttonkey" value="label.button.submitordertorestaurant"></c:set>
</c:if>
<c:set var="submitButttonkeyModal" value="label.button.paybycard.standard"></c:set>
<script type="text/javascript">
	function submitForm() {
		document.editDetails.submit();
	}
	sessionStorage.setItem('basketSession', false);
</script>
<div class="order-summary">
	<h6><fmt:message key="header.order.summary" /></h6>
	<div class="order-summary-content">
		<c:if test="${warningMessage != null}">
			<div class="validation">
				${warningMessage} 
			</div>
		</c:if>
		<c:if test="${promoCodeErrorMessage != null}">
			<div class="alert alert-dismissible alert-danger">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong><fmt:message key="${promoCodeErrorMessage}" /></strong>
			
			</div>
		</c:if>
		<table class="table">
			<tbody>
				<tr>
					<th class="orderitem_name"><b><fmt:message key="label.fooditem" /></b></th>
					<th class="orderitem_qty"><b><fmt:message key="label.qty" /></b></th>
					<th class="orderitem_price"><b><fmt:message key="label.amount" /></b></th>
				</tr>
				<c:forEach var="thisOrderItem" items="${shoppingcart.items}">	
					<plastocart:getshoppingcartmenuconfirmation orderItem="${thisOrderItem}" />	
				</c:forEach>
			</tbody>
		</table>
		<div class="row">
			<div class="col-lg-7 col-md-7">
				<c:set var="customerOrder" value="${customerorder}" />
				<table class="table table-border-free">
					<tbody>
						<tr>
							<td colspan="2">
								<fmt:message key="label.paymenttype.capital" />:
								<br />
								<plastocart:getmessage messageCode="${customerOrder.paymentType}" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<plastocart:getmessage messageCode="${customerOrder.orderType}" />:
								<br />
								${orderDate} <plastocart:printlocalisedordertime />
							</td>
						</tr>
						<c:if test="${customerOrder.orderType == 'DELIVERY'}">
							<tr>
								<td colspan="2">
									<fmt:message key="label.delivery.address" />:
									<br />					
									<c:forEach items="${company.addressFieldRules}" var="fieldRule">
										<c:if test="${fieldRule.display}">
											<c:forEach var="thisAddressField" items="${customerOrder.customerOrderAddress.customerOrderAddressFields}" varStatus="rowStatus1">
												<c:if test="${fieldRule.fieldName == thisAddressField.fieldName}">
													${thisAddressField.fieldValue}<c:if test="${rowStatus1.index < customerOrder.customerOrderAddress.customerOrderAddressFields.size() - 1}"><br /></c:if>
												</c:if> 
											</c:forEach>
										</c:if>
									</c:forEach>
								</td>
							</tr>
						</c:if>
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
			<div class="col-lg-5 col-md-5">
				<table class="table">
					<tbody>
						<tr>
							<td><fmt:message key="label.subtotal" /></td>
							<td class="text-end"><plastocart:fmcn locale="${currencyLocale}" value="${shoppingcart.value}" /></td>
						</tr>
						<plastocart:gtz value="${customerOrder.deliveryCharge}">
						<c:if test="${customerOrder.orderType == 'DELIVERY'}">
						<tr>
							<td class="ordertotal"><fmt:message key="label.delivery.charge" /></td>
							<td class="ordertotal_nr text-end"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.deliveryCharge}" /></td>
						</tr>
						</c:if>				
						</plastocart:gtz>				
						<plastocart:gtz value="${customerOrder.surCharge}">
						<tr>
							<td class="ordertotal"><fmt:message key="label.surcharge" /></td>
							<td class="ordertotal_nr text-end"><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.surCharge}" /></td>
						</tr>		
						</plastocart:gtz>
						<plastocart:gtz value="${customerOrder.orderDiscount}">
						<tr>
							<td class="ordertotal"><fmt:message key="label.discount" /></td>
							<td class="ordertotal_nr text-end"> - <plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.orderDiscount}" /></td>
						</tr>	
						</plastocart:gtz>
						<plastocart:gtz value="${customerOrder.promoCodeDiscount}">
						<tr>
							<td class="ordertotal"><fmt:message key="label.promotionalcodediscount" /></td>
							<td class="ordertotal_nr text-end"> - <plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.promoCodeDiscount}" /></td>
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
							<td class="ordertotal_nr text-end"><plastocart:fmcn locale="${currencyLocale}" value="${thisCustomerOrderTaxes.taxAmount}" /></td>
						</tr>
						</plastocart:gtz>
						</c:forEach>
						<plastocart:gtz value="${customerOrder.driverTip}">
							<tr>
								<td><fmt:message key="label.drivertip" /></td>
								<td class="text-end"><plastocart:fmcn locale="${currencyLocale}" value="${customerorder.driverTip}" /></td>
							</tr>
						</plastocart:gtz>
						<tr>
							<td><fmt:message key="label.total" /></td>
							<td class="text-end"><b><plastocart:fmcn locale="${currencyLocale}" value="${customerOrder.subTotal}" /></b></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row justify-content-between">
			<div class="col-lg-4 col-md-6">
				<form action="/${checkOutUrl}" method="post" name="editDetails">
					<input type="hidden" name="companyId" id="companyId" value="${companyId}">
					<input type="hidden" name="orderDate" id="orderDate" value="${orderDate}"/>
					<input type="hidden" name="orderTime" id="orderTime" value="${orderTime}"/> 
					<input type="hidden" name="orderType" id="orderType" value="${orderType}"/>
					<div class="d-grid">
						<a href="javascript: submitForm();" class="btn btn-primary"><i class="icon-chevron-with-circle-left"></i><fmt:message key="label.button.edit" /></a>
					</div>
				</form>
			</div>
			<div class="col-md-6 col-lg-4">
				<c:choose>
					<c:when test="${paymentmethod.paymentType == 'CASH' or paymentmethod.paymentType == 'MPESA' or paymentmethod.paymentType == 'CHEQUE' or paymentmethod.paymentType == 'CARDTERMINAL'}">
						<form action="/${submitOrderUrl}" method="post">
							<input type="hidden" name="companyId" id="companyId" value="${companyId}">
							<div class="d-grid">
								<button type="submit" class="btn btn-primary"><fmt:message key="${submitButttonkey}" /></button>
							</div>
						</form>
					</c:when>
					<c:otherwise>
						<div class="d-grid">
							<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#paymentformgenerator">
								<fmt:message key="${submitButttonkeyModal}" />
							</button>
						</div>
					</c:otherwise>
				</c:choose>
				<c:if test="${paymentmethod.paymentType == 'CARDTERMINAL'}">
					<fmt:message key="mobileterminal.securiy.message" />
				</c:if>
			</div>
			<div class="modal payment-process-modal" style="display: none">
				<div style="background: rgba(255, 255, 255, 0.85); height: 100%; width: 100%;">
					<div class="payment-process-center" style="top: 50%; margin-top: -50px; position: absolute; left: 0; width: 100%; z-index: 2;">
					<div class="payment-processing-text text-center"><p><fmt:message key="label.paymentprocess.message" /></p></div>
						<div class="text-center"><img alt="Loading..." src="/static/aaa_general/images/loader.gif" /></div>
					</div>
				</div>
			</div>		
			<div class="modal fade" id="paymentformgenerator" tabindex="-1" role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<button type="button" class="btn-close payment-close" data-bs-dismiss="modal" aria-label="Close"></button>
						<div class="paymentformgenerator-wrap">
							<div class="paymentformgenerator-top">
								<h4>${company.name}</h4>
								<hr>
								<p>${customer.email}</p>
							</div>
							<div class="paymentformgenerator-bottom example example2">
								<tg:paymentformgenerator />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="delete_card" tabindex="-1" role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<button type="button" class="btn-close payment-close" data-bs-dismiss="modal" aria-label="Close"></button>
						<div class="paymentformgenerator-wrap">
							<div class="paymentformgenerator-bottom example example2">
								<h3 class="text-center title-modal-question"><fmt:message key='info.card.deletecard.confirmation' /></h3>
								<div class="row">
									<div class="col-6 d-grid">
										<a href="#" class="btn btn-block btn-primary" data-dismiss="modal" aria-label="Close">No</a>
									</div>
									<div class="col-6 d-grid">
										<a href="#" class="btn btn-block btn-primary" id="delete-card-modal">Yes</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="duplicate-transaction" tabindex="-1" role="dialog">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<button type="button" class="btn-close payment-close" data-bs-dismiss="modal" aria-label="Close"></button>
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">&nbsp;</h5>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-6 d-grid">
									<button id="transaction-cancel" type="button" data-dismiss="modal" aria-label="Close" class="btn btn-primary"><fmt:message key='label.button.cancel' /></button>
								</div>
								<div class="col-6 d-grid">
									<button id="transaction-continue" type="button" class="btn btn-primary">
										<fmt:message key='label.button.continue.standard' />
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>