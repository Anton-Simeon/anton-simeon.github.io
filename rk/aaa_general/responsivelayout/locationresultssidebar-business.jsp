<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="restaurantsUrl"><fmt:message key='url.path.restaurantsurl' /></c:set>
<div class="business-search-wrap">
	<div class="business-search">
		<input type="text" class="form-control" placeholder="<fmt:message key='label.restsearch.searchstorebyname'/>" name="restname" id="business-restname" value="${restaurantname}" />
		<div class="business-search-button"><i class="icon icon-search"></i></div>
		<div class="business-search-button-close"><i class="icon icon-close"></i></div>
	</div>
	<ul class="business-search-list">
	</ul>
</div>
<c:if test="${empty param.disableCuisineFilter}">
	<div class="wrap-sidebar-filter">
		<div class="sidebar-filter">
			<div class="sidebar-filter-title">
				<button type="button" class="close-sidebar-filter">×</button> <span>Filters</span>
			</div>
			<input type="hidden" id=companyId name="" value="${companyId}">
			<input type="hidden" id=longitude name="" value="${longitude}">
			<input type="hidden" id=latitude name="" value="${latitude}">
			<div class="sidebar-filter-scroll">
				<!--  class active: click -->
				<ul class="menu-nav-business-new-js">
					<li><a href="#" id="all" class="click"><fmt:message key='label.locationresults.all' /></a></li>
				</ul>
			</div>
		</div>
	</div>
</c:if>