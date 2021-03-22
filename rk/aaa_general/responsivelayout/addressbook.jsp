<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="addAddressUrl"><fmt:message key='url.path.addaddress' /></c:set>
<fmt:requestEncoding value = "UTF-8" />
<c:set var="editAddressUrl"><fmt:message key='url.path.editaddress' /></c:set>
<c:set var="addressBookUrl"><fmt:message key='url.path.addressbook' /></c:set>
<h2 class="profile-title"><fmt:message key='header.address.book' /></h2>
<div class="d-flex flex-row-reverse mb-3">
	<c:choose>
		<c:when test="${widgetSite == 'true'}">
			<button type="button" class="btn btn-primary" data-modal-href="/${addAddressUrl}?companyId=${companyId}" data-bs-target="#addressBookModal" data-bs-toggle="modal">
				<i class="icon-plus-alt"></i>
				<fmt:message key='label.link.addaddress' />
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="btn btn-primary" data-modal-href="/${addAddressUrl}" data-bs-target="#addressBookModal" data-bs-toggle="modal">
				<i class="icon-plus-alt"></i>
				<fmt:message key='label.link.addaddress' />
			</button>
		</c:otherwise>
	</c:choose>
</div>
<c:url value="/${addressBookUrl}" var="pagedLink"><c:param name="p" value="~" /></c:url>
<div class="wrap-table-scroll">
	<div class="table-scroll">
		<table class="table table-style table-bordered table-striped table-hover" align="center">
			<thead>
				<tr>
					<c:forEach items="${addressFieldRules}" var="fieldRule">
						<c:if test="${fieldRule.userInterfaceType != 'option' and fieldRule.display}">
							<th><fmt:message key='label.${fieldRule.label}' /></th>
						</c:if>
					</c:forEach>
					<th width="90px"><fmt:message key='label.action' /></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${pagedListHolder.pageList}" var="address">
				<tr>
					<c:forEach items="${addressFieldRules}" var="fieldRule">
						<c:if test="${fieldRule.userInterfaceType != 'option' and fieldRule.display}">
							<c:set var="isAddressFieldExists" value="false"/>
							<c:forEach items="${address.addressFields}" var="addressFieldsList">
								<c:if test="${fieldRule.userInterfaceType != 'option' and addressFieldsList.fieldName eq fieldRule.fieldName}">	
									<c:choose>
										<c:when test="${addressFieldsList.fieldValue != null and addressFieldsList.fieldValue != ''}">
											<td>
												<div class="td-title"><fmt:message key='label.${fieldRule.label}' />:</div>
												${addressFieldsList.fieldValue}
											</td>
										</c:when>
										<c:otherwise>
											<td class="td-empty"></td>
										</c:otherwise>
									</c:choose>
									<c:set var="isAddressFieldExists" value="true"/>
								</c:if>
							</c:forEach>
							<c:if test="${isAddressFieldExists eq false}">
								<td></td>
							</c:if>
						</c:if>
					</c:forEach>
					<td>
						<div class="td-title"><fmt:message key='label.action' />:</div>
						<a href="javascript: deleteaddress(${address.id})"  role="button" class="customer-id"> <fmt:message key='label.link.delete' /> </a>
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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw&v=3.27&libraries=geometry,places&region=${company.companyLocale.country}"></script>