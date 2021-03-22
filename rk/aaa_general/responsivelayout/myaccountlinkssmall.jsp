<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="personalInfoUrl"><fmt:message key='url.path.personalinfo' /></c:set>
<c:set var="addressBookUrl"><fmt:message key='url.path.addressbook' /></c:set>
<c:set var="orderHistoryUrl"><fmt:message key='url.path.orderhistory' /></c:set>
<c:set var="updatePasswordUrl"><fmt:message key='url.path.updatepassword' /></c:set>
<form role="form" class="d-block d-md-none mb-5">
	<select class="form-select" id="sel1" onchange="location = this.options[this.selectedIndex].value;">
		<c:if test="${param.selected == 'personalinfo'}">
			<option value="/${personalInfoUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>" selected="selected"><fmt:message key='label.link.personal.info' /></option>
		</c:if>
		<c:if test="${param.selected != 'personalinfo'}">
			<option value="/${personalInfoUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.personal.info' /></option>
		</c:if>
		<c:if test="${param.selected == 'addressbook'}">
			<option value="/${addressBookUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>" selected="selected"><fmt:message key='label.link.address.book' /></option>
		</c:if>
		<c:if test="${param.selected != 'addressbook'}">
			<option value="/${addressBookUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.address.book' /></option>
		</c:if>
		<c:if test="${param.selected == 'orderhistory'}">
			<option value="/${orderHistoryUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>" selected="selected"><fmt:message key='label.link.order.history' /></option>
		</c:if>
		<c:if test="${param.selected != 'orderhistory'}">
			<option value="/${orderHistoryUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.order.history' /></option>
		</c:if>
		<c:if test="${param.selected == 'updatepassword'}">
			<option value="/${updatePasswordUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>" selected="selected"><fmt:message key='label.link.update.password' /></option>
		</c:if>
		<c:if test="${param.selected != 'updatepassword'}">
			<option value="/${updatePasswordUrl}<c:if test="${widgetSite == 'true'}">?companyId=${companyId}</c:if>"><fmt:message key='label.link.update.password' /></option>
		</c:if>
	</select>
</form>