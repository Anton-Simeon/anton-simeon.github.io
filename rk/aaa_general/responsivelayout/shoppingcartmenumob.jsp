<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="checkOutUrl"><fmt:message key='url.path.checkout' /></c:set>
<div id="menu-cart-contentmob">
	<c:choose>
		<c:when test="${not empty shoppingcart.items}">
			<c:if test="${category == null}">
				<c:set var="thisCategoryId" value="${param.categoryId}" />
			</c:if>
			<c:if test="${category != null}">
				<c:set var="thisCategoryId" value="${category.id}" />
			</c:if>
			<c:set var="orderItems" value="${shoppingcart.items}" />
			<div class="footer-bottom1 mobile-show">
				<div class="col-lg-12">
					<button type="button" class="btn btn-primary btn-block" id="orderBtn">
						<img src="${website.rootStaticUrl}/images/cart-white.png">
						&nbsp;<span><fmt:message key='label.total' /></span>
						<span class='price'><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></span> <div class="col-mobile-basket-wr">(<span class="col-mobile-basket-js">${shoppingcart.items.size()}</span>)</div>
					</button>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="footer-bottom1 mobile-show" style="display: none;">
				<div class="col-lg-12">
					<button type="button" class="btn btn-primary btn-block" id="orderBtn">
						<img src="${website.rootStaticUrl}/images/cart-white.png">
						&nbsp;<span><fmt:message key='label.total' /></span>
						<span class='price'><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></span> <div class="col-mobile-basket-wr">(<span class="col-mobile-basket-js">${shoppingcart.items.size()}</span>)</div>
					</button>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<div id="myCartModal" class="panel panel-info panel-fullscreen mobile-show" style="display: none;">
		<div class="panel-heading">
			<fmt:message key='label.link.my.order' /> 
			<span class="pull-right"> 
				<a href="#" class="closeCartModal"><img src="/static/ordertigerwidget/images/close.png"></a>
			</span>
		</div>
		<c:choose>
			<c:when test="${company.companySetting != null and company.companySetting.enableDriverTip == true}">
				<div class="panel-body driver-tip-js driver-tip-active">
			</c:when>
			<c:otherwise>
				<div class="panel-body">
			</c:otherwise>
		</c:choose>
			<div id="pre-order-section">
				<div class="menu-type-tabs"></div>
				<ul class="radio-cart-wrap" style="display: none;">
					<li class="order-wrap-now-js" style="display: none;"><input type="radio" name="radio-cart3" value="order-for-now" class="order-for-now-js"><fmt:message key='order.now' /></li>
					<li class="order-wrap-later-js" style="display: none;"><input type="radio" name="radio-cart3" value="order-for-later" class="order-for-later-js"><fmt:message key='order.later' /></li>
				</ul>
				<div class="pre-order-section-new"></div>
			</div>
			<div id="mobile_cart">
				<div class="cart-top mobcarttop">
					<c:forEach var="thisOrderItem" items="${orderItems}">
						<plastocart:getcartmenuitemsmob orderItem="${thisOrderItem}" menu="${menu}" categoryId="${thisCategoryId}" />
					</c:forEach>
				</div>
				<div class="cart-bottom">
					<hr>
					<div class="row">
						<div class="col-xs-12">
							<strong class="item"><fmt:message key='label.ordertotal' /></strong>
							<div class="pull-right value">
								<span class="value-js-mobile"><plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" /></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<form action="/${checkOutUrl}" method="post" class="inlinee checkOutForm" id="checkOutForm" >
								<input type="hidden" name="checkout" value="yes" /> 
								<input type="hidden" name="orderDate" id="orderDate"/>
								<input type="hidden" name="orderTime" id="orderTime" /> 
								<input type="hidden" name="orderType" id="orderType"/> 
								<input type="hidden" class="orderForNow-input-js" name="orderForNow" value="false" />
								<input type="hidden" class="orderForLater-input-js" name="orderForLater" value="false" />
								<input type="hidden" name="companyId" id="companyId" value="${companyId}">
								<input type="hidden" name="driverTip" class="driverTipVal" value="0.00" />
								<button onclick="validateData(this);" type="button"  class="btn btn-primary btn-block">
									<img src="${website.rootStaticUrl}/images/cart-white.png">
									&nbsp;<fmt:message key='label.button.checkout.responsive' />
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="driver-tip-wrap">
				<div class="driver-tip-text">
					<h5><fmt:message key='label.tipdriver' /></h5>
				</div>
				<div class="driver-tip-links">
					
					<input type="hidden" name="driverTip" class="driverTip-js" value="${customerorder.driverTip}" />
					<div>
						<div class="driver-tip-link" data-tip="1">
							<div class="driver-tip-percent">10%</div>
							<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js10"></span></div>
						</div>
					</div>
					<div>
						<div class="driver-tip-link" data-tip="2">
							<div class="driver-tip-percent">15%</div>
							<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js15"></span></div>
						</div>
					</div>
					<div>
						<div class="driver-tip-link" data-tip="3">
							<div class="driver-tip-percent">20%</div>
							<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js20"></span></div>
						</div>
					</div>
					<div>
						<div class="driver-tip-link" data-tip="4">
							<div class="driver-tip-percent">25%</div>
							<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js25"></span></div>
						</div>
					</div>
					<div>
						<a href="#driver-tip-edit" data-tip="5" class="driver-tip-link driver-tip-edit-link" data-toggle="modal" data-target="#driver-tip-edit">
							<div class="driver-tip-edit"><fmt:message key='label.tipdriver.edit' /></div>
							<div class="driver-tip-percent"><fmt:message key='label.tipdriver.edit' /></div>
							<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-jsEdit"></span></div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>