<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="personalInfoUrl"><fmt:message key='url.path.personalinfo' /></c:set>
<c:set var="addressBookUrl"><fmt:message key='url.path.addressbook' /></c:set>
<c:set var="orderHistoryUrl"><fmt:message key='url.path.orderhistory' /></c:set>
<c:set var="updatePasswordUrl"><fmt:message key='url.path.updatepassword' /></c:set>
<div class="col-md-3">
	<ul class="profile-menu">
		<c:if test="${param.selected == 'personalinfo'}">
		<li class="active">
			<a href="/${personalInfoUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.personal.info' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected != 'personalinfo'}">
		<li>
			<a href="/${personalInfoUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.personal.info' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected == 'addressbook'}">
		<li class="active">
			<a href="/${addressBookUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.address.book' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected != 'addressbook'}">
		<li>
			<a href="/${addressBookUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.address.book' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected == 'orderhistory'}">
		<li class="active">
			<a href="/${orderHistoryUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.order.history' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected != 'orderhistory'}">
		<li>
			<a href="/${orderHistoryUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.order.history' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected == 'updatepassword'}">
		<li class="active">
			<a href="/${updatePasswordUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.update.password' /></a>
		</li>
		</c:if>
		<c:if test="${param.selected != 'updatepassword'}">
		<li>
			<a href="/${updatePasswordUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.update.password' /></a>
		</li>
		</c:if>
	</ul>
</div>