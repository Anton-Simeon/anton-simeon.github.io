<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>	
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<c:set var="orderHistoryUrl"><fmt:message key='url.path.orderhistory' /></c:set>
<c:set var="customerOrder" value="${customerorder}" />	
<h2 class="successful-message">
	<fmt:message key="paymentconfirmation.thankyouforordering" />
</h2>
<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
		<h4 class="dark"><fmt:message key="paymentconfirmation.reference.number.is" /> <span class="reference">${customerOrder.transId}</span></h4>
		<h5 class="dark"><fmt:message key='orderconfirmation.your.order.is' /></h5>
		<h5 class="dark"><fmt:message key='orderconfirmation.if.the.restaurant' /></h5>
	</div>
</div>
<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
		<table class="table table-border-right-free">
			<thead>
				<tr>
					<th class="col-md-3 col-sm-4 col-xs-4" colspan="4"><fmt:message key='label.yourorder' /></th>
				</tr>
			</thead>
			<c:set var="shoppingCartEmpty" value="TRUE" />	
			<plastocart:gtz value="${shoppingcart.value}">
			<tbody>
				<c:set var="shoppingCartEmpty" value="FALSE" />	
				<c:forEach var="thisOrderItem" items="${shoppingcart.items}">	
					<plastocart:getshoppingcartmenu orderItem="${thisOrderItem}"  menu="${menu}" />	
				</c:forEach>
				<tr>
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.subtotal" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></td>
					<td class="col-md-3"></td>
				</tr>				
				<plastocart:gtz value="${customerOrder.deliveryCharge}">
				<c:if test="${customerOrder.orderType == 'DELIVERY'}">
				<tr class="tr_delivery_charge">
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.delivery.charge" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.deliveryCharge}" /></td>
				</tr>
				</c:if>				
				</plastocart:gtz>		 
				<plastocart:gtz value="${customerOrder.surCharge}">
				<tr class="tr_surcharge">
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.surcharge" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.surCharge}" /></td>
				</tr>		
				</plastocart:gtz>	  	
				<plastocart:gtz value="${customerOrder.orderDiscount}">
				<tr class="tr_discount">
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.discount" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.orderDiscount}" /></td>
				</tr>	
				</plastocart:gtz>		  
				<plastocart:gtz value="${customerOrder.promoCodeDiscount}">
				<tr class="tr_promotional">
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.promotionalcodediscount" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"> - <plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.promoCodeDiscount}" /></td>
				</tr>				
				</plastocart:gtz>
				<plastocart:gtz value="${customerOrder.driverTip}">
					<tr>
						<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.drivertip" /></td>
						<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${currencyLocale}" value="${customerorder.driverTip}" /></td>
						<td class="col-md-3"></td>
					</tr>
				</plastocart:gtz>
			</tbody>
			<tfoot>
				<tr class="sub-total">
					<td class="col-md-3 col-sm-4 col-xs-4" colspan="2"><fmt:message key="label.subtotal.capital" /></td>
					<td class="col-md-3 col-sm-4 col-xs-4 amount amount-price"><plastocart:fmcn locale="${defaultLocale}" value="${customerOrder.subTotal}" /></td>
					<td class="col-md-3"></td>
				</tr>
			</tfoot>
			</plastocart:gtz>
			<c:if test="${shoppingCartEmpty == 'TRUE'}">
			<tfoot>
				<tr>
					<td colspan="3"><fmt:message key="shoppingcart.empty" /></td>
				</tr>
			</tfoot>
			</c:if>
		</table>
	</div>
</div>
<div class="row">
	<div class="col-md-12 col-sm-12 col-xs-12">
		<table class="table table-border-right-free">
			<thead>
				<tr>
					<th class="col-md-3 col-sm-4 col-xs-4" colspan="4"><fmt:message key='label.yourdetails' /></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${customerOrder.customerFirstName != '' || customerOrder.customerLastName != ''}">
				<tr>
					<td class="col-md-4 col-sm-6 col-xs-6"><fmt:message key='header.name' /></td>
					<td class="col-md-4 col-sm-6 col-xs-6 text-center">
						<c:if test="${customerOrder.customerFirstName != ''}">${customerOrder.customerFirstName} </c:if>
						<c:if test="${customerOrder.customerLastName != ''}">${customerOrder.customerLastName}</c:if>
					</td>
					<td class="col-md-4 col-sm-6 col-xs-6"></td>
				</tr>
				</c:if>
				<tr>
					<td class="col-md-4 col-sm-6 col-xs-6"><fmt:message key='header.telephone' /></td>
					<td class="col-md-4 col-sm-6 col-xs-6 text-center">${customerOrder.customerPhone}</td>
					<td class="col-md-4 col-sm-6 col-xs-6"></td>
				</tr>
				<c:if test="${customerOrder.orderType == 'DELIVERY'}">
				<tr>
					<td class="col-md-4 col-sm-6 col-xs-6"><fmt:message key='header.address' /></td>
					<td class="col-md-4 col-sm-6 col-xs-6 text-center">
						<c:forEach items="${customerOrder.customerOrderAddress.customerOrderAddressFields}" var="addressFieldsList" varStatus="rowStatus">
						${addressFieldsList.fieldValue}<c:if test="${rowStatus.index < customerOrder.customerOrderAddress.customerOrderAddressFields.size() - 1}"><br /></c:if> 
						</c:forEach>
					</td>
					<td class="col-md-4 col-sm-6 col-xs-6"></td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
<% WebContextUtil.invalidateSession(); %>