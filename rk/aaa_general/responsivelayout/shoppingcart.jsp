<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="shoppingCartEmpty" value="TRUE" />
<c:set var="customerOrder" value="${customerOrder}" />
<c:set var="customer" value="${customer}" />
<c:set var="currencyLocale" value="${defaultLocale}"></c:set>
<div class="shopping-cart">
	<h6><fmt:message key="label.link.my.order.capital" /></h6>
	<div class="shopping-cart-content">
		<table class="table shopping-cart-table">
			<tbody>
				<plastocart:gtz value="${shoppingcart.value}">
					<c:set var="shoppingCartEmpty" value="FALSE" />
					<c:forEach var="thisOrderItem" items="${shoppingcart.items}">
						<plastocart:getshoppingcartmenu orderItem="${thisOrderItem}"  menu="${menu}"/>
					</c:forEach>
					<tr class="shopping-cart-table-space">
						<td class="orderitem_name"><fmt:message key="label.subtotal" /></td>
						<td class="orderitem_qty"></td>
						<td class="orderitem_price"><plastocart:fmcn locale="${currencyLocale}" value="${shoppingcart.value}" /></td>
					</tr>
					<%-- 			<plastocart:getdeliverycharge customerOrder="${customerorder}"/>		 --%>
					<c:if test="${not empty customerorder}">
						<plastocart:gtz value="${customerorder.driverTip}">
							<tr>
								<td class="orderitem_name"><fmt:message key="label.drivertip" /></td>
								<td class="orderitem_qty"></td>
								<td class="orderitem_price"><plastocart:fmcn locale="${currencyLocale}" value="${customerorder.driverTip}" /></td>
							</tr>
						</plastocart:gtz>
					</c:if>
				</plastocart:gtz>
			</tbody>
		</table>
		<div class="hidden" id="warningMessageNoZoneFound">
			<c:if test="${not empty warningMessageNoZoneFound}">
				${warningMessageNoZoneFound}
			</c:if>
		</div>
	</div>
</div>