<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<c:set var="orderHistoryUrl"><fmt:message key='url.path.orderhistory' /></c:set>
<c:set var="customerOrder" value="${customerorder}" />
<c:set var="currencyLocale" value="${defaultLocale}"></c:set>
<div class="submit-order">
	<h6>
		<fmt:message key="paymentconfirmation.thankyouforordering" />
	</h6>
	<div class="submit-order-content">
		<div class="submit-order-text">
			<h5><fmt:message key="paymentconfirmation.reference.number.is" /><span class="reference">${customerorder.id}</span></h5>
			<p><fmt:message key='orderconfirmation.your.order.is' /></p>
			<p>
				<c:choose>
					<c:when test="${widgetSite == 'true'}">
						<fmt:message key='orderconfirmation.to.track.the'>
							<fmt:param value="${orderHistoryUrl}?companyId=${companyId}" />
						</fmt:message>
			        </c:when>
					<c:otherwise>
						<fmt:message key='orderconfirmation.to.track.the'>
							<fmt:param value="${orderHistoryUrl}" />
						</fmt:message>
			        </c:otherwise>
				</c:choose>
			</p>
			<p><fmt:message key='orderconfirmation.if.the.restaurant' /></p>
		</div>
		<table class="table">
			<tbody>
				<tr>
					<th colspan="4"><fmt:message key='label.yourorder' /></th>
				</tr>
				<c:set var="shoppingCartEmpty" value="TRUE" />	
				<plastocart:gtz value="${shoppingcart.value}">
				<c:set var="shoppingCartEmpty" value="FALSE" />	
				<c:forEach var="thisOrderItem" items="${shoppingcart.items}">	
					<plastocart:getshoppingcartmenu orderItem="${thisOrderItem}" menu="${menu}"/>	
				</c:forEach>
				<tr>
					<td colspan="2"><fmt:message key="label.subtotal" /></td>
					<td class="orderitem_price"><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></td>
				</tr>
				<plastocart:gtz value="${customerOrder.deliveryCharge}">
				<c:if test="${customerOrder.orderType == 'DELIVERY'}">
				<tr class="tr_delivery_charge">
					<td colspan="2"><fmt:message key="label.delivery.charge" /></td>
					<td class="orderitem_price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.deliveryCharge}" /></td>
				</tr>
				</c:if>				
				</plastocart:gtz>		 
				<plastocart:gtz value="${customerOrder.surCharge}">
				<tr class="tr_surcharge">
					<td colspan="2"><fmt:message key="label.surcharge" /></td>
					<td class="orderitem_price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.surCharge}" /></td>
				</tr>		
				</plastocart:gtz>	  	
				<plastocart:gtz value="${customerOrder.orderDiscount}">
				<tr class="tr_discount">
					<td colspan="2"><fmt:message key="label.discount" /></td>
					<td class="orderitem_price"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.orderDiscount}" /></td>
				</tr>	
				</plastocart:gtz>		  
				<plastocart:gtz value="${customerOrder.promoCodeDiscount}">
				<tr class="tr_promotional">
					<td colspan="2"><fmt:message key="label.promotionalcodediscount" /></td>
					<td class="orderitem_price"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.promoCodeDiscount}" /></td>
				</tr>	
				</plastocart:gtz>
				<c:forEach var="thisCustomerOrderTaxes" items="${customerOrder.customerOrderTaxes}" varStatus="rowStatus">
				<plastocart:gtz value="${thisCustomerOrderTaxes.taxAmount}">
				<tr>
					<c:choose>
						<c:when test="${thisCustomerOrderTaxes.chargeMode == 2}">
							<td colspan="2">${thisCustomerOrderTaxes.taxLabel} (<fmt:formatNumber type="number" maxFractionDigits="2" value="${thisCustomerOrderTaxes.rate*100}" />%)</td>								
						</c:when>
						<c:otherwise>
							<td colspan="2">${thisCustomerOrderTaxes.taxLabel}</td>
						</c:otherwise>
					</c:choose>
					<td class="orderitem_price"><plastocart:fmcn locale="${currencyLocale}" value="${thisCustomerOrderTaxes.taxAmount}" /></td>
				</tr>
				</plastocart:gtz>
				</c:forEach>	
				<plastocart:gtz value="${customerOrder.driverTip}">
					<tr>
						<td colspan="2"><fmt:message key="label.drivertip" /></td>
						<td class="orderitem_price"><plastocart:fmcn locale="${currencyLocale}" value="${customerorder.driverTip}" /></td>
					</tr>
				</plastocart:gtz>
			<tr class="sub-total">
				<td colspan="2"><fmt:message key="label.total.capital" /></td>
				<td class="orderitem_price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.subTotal}" /></td>
			</tr>
			</plastocart:gtz>
			<c:if test="${shoppingCartEmpty == 'TRUE'}">
			<tr>
				<td colspan="3"><fmt:message key="shoppingcart.empty" /></td>
			</tr>
			</c:if>
			</tbody>
		</table>
		<table class="table">
			<tbody>
				<tr>
					<th><fmt:message key='label.yourdetails' /></th>
				</tr>
				<tr>
					<td>
						<fmt:message key='header.name' />
						<br />
						${customer.firstName} ${customer.lastName}
					</td>
				</tr>
				<tr>
					<td>
						<fmt:message key='header.telephone' />
						<br />
						${customer.phone}
					</td>
				</tr>
				<c:if test="${customerOrder.orderType == 'DELIVERY'}">
				<tr>
					<td><fmt:message key='header.address' />
						<br />
						<c:forEach items="${customerOrder.customerOrderAddress.customerOrderAddressFields}" var="addressFieldsList" varStatus="rowStatus">
						${addressFieldsList.fieldValue}<c:if test="${rowStatus.index < customerOrder.customerOrderAddress.customerOrderAddressFields.size() - 1}"><br /></c:if> 
						</c:forEach>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<% WebContextUtil.removeShoppingCartFromSession(); %>