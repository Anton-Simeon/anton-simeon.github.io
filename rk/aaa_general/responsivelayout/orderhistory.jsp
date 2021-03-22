<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="orderHistoryUrl"><fmt:message key='url.path.orderhistory' /></c:set>
<h2 class="profile-title"><fmt:message key='header.order.history' /></h2>
<c:url value="/${orderHistoryUrl}" var="pagedLink"><c:param name="p" value="~" /></c:url>
<div class="wrap-table-scroll">
	<div class="table-scroll">
		<table class="table table-style table-bordered table-striped table-hover" align="center">
			<thead>
				<tr>
					<th width="15%"><fmt:message key='label.orderstatus' /></th>
					<th width="15%"><fmt:message key='label.orderreference' /></th>
					<th width="15%"><fmt:message key='label.paymenttype' /></th>
					<th width="25%"><fmt:message key='label.store' /></th>
					<th width="15%"><fmt:message key='label.orderdate' /></th>
					<th width="15%"><fmt:message key='label.total' /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pagedListHolder.pageList}" var="customerOrder">
					<c:choose>
					<c:when test="${widgetSite == 'true'}">
					<tr class='clickable-row' data-href='/order/${customerOrder.id}?companyId=${companyId}'>
					</c:when>
					<c:otherwise>
					<tr class='clickable-row' data-href='/order/${customerOrder.id}'>
					</c:otherwise>
					</c:choose>
						<td>
							<div class="td-title"><fmt:message key='label.orderstatus' /></div>
							<div class="content-table">
								<c:if test="${not empty customerOrder.orderConfirmationStatus}">
									<c:choose>
										<c:when test="${customerOrder.orderConfirmationStatus eq 'AUTOCONFIRMED' }">
											<fmt:message key="orders.statuses.autoconfirmed" />
										</c:when>
										<c:when test="${customerOrder.orderConfirmationStatus eq 'PROCESSED' }">
											<fmt:message key="orders.statuses.processed" />
										</c:when>
										<c:when test="${customerOrder.orderConfirmationStatus eq 'PENDING'}">
											<fmt:message key="orders.statuses.pending" />
										</c:when>
										<c:when test="${customerOrder.orderConfirmationStatus eq 'REJECTED'}">
											<fmt:message key="orders.statuses.rejected" />
										</c:when>
										<c:when test="${customerOrder.orderConfirmationStatus eq 'ACCEPTED'}">
											<fmt:message key="orders.statuses.accepted" />
										</c:when>
										<c:otherwise>
											${customerOrder.orderConfirmationStatus}
										</c:otherwise>
									</c:choose>
								</c:if>
							</div>
						</td>
						<td>
							<div class="td-title"><fmt:message key='label.orderreference' /></div>
							<div class="content-table">
							${customerOrder.id}
							</div>
						</td>
						<td>
							<div class="td-title"><fmt:message key='label.paymenttype' /></div>
							<div class="content-table">
							<c:if test="${not empty customerOrder.paymentType}">
								<c:choose>
									<c:when test="${customerOrder.paymentType eq 'CASH' }">
										<fmt:message key="payment.statuses.cash" />
									</c:when>
									<c:when test="${customerOrder.paymentType eq 'CARD' }">
										<fmt:message key="payment.statuses.card" />
									</c:when>
									<c:when test="${customerOrder.paymentType eq 'CARDTERMINAL' }">
										<fmt:message key="payment.statuses.cardterminal" />
									</c:when>						
									<c:otherwise>
										${customerOrder.paymentType}
									</c:otherwise>
								</c:choose>
							</c:if>
							</div>
						</td>
						<td>
							<div class="td-title"><fmt:message key='label.store' /></div>
							<div class="content-table">
								<plastocart:grbid branchId="${customerOrder.branchId}" />
								${requestScope.requestBranch.name}
							</div>
						</td>
						<td>
							<div class="td-title"><fmt:message key='label.orderdate' /></div>
							<div class="content-table">
								${customerOrder.orderDate}
							</div>
						</td>
						<td>
							<div class="td-title"><fmt:message key='label.total' /></div>
							<div class="content-table">
								${customerOrder.subTotal}
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="table-scroll__track">
		<div class="table-scroll__bar"></div>
	</div>
</div>
<tg:paging pagedLink="${pagedLink}" pagedListHolder="${pagedListHolder}"></tg:paging>