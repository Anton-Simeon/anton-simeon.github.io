<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="restaurantsUrl"><fmt:message key='url.path.restaurantsurl' /></c:set>
<div class="search-product">
	<input type="text" class="form-control" placeholder="<fmt:message key='label.restsearch.searchstorebyname'/>" name="restname" id="restname" value="${restaurantname}" />
</div>
<c:if test="${empty param.disableCuisineFilter}">
	<div class="menu-nav-wrap-main-js">
		<div class="menu-nav-wrap-main menu-nav-wrap-main-category">
			<div class="menu-nav-wrap menu-nav-wrap2">
				<ul class="menu-nav menu-nav-more-js">
					<li><a href="#" class="radio-option <c:if test="${splitCuisine == null}">click</c:if>" id="all"><fmt:message key='label.locationresults.all' /></a></li>
					<c:forEach var="thisCuisineTypes" items="${cuisineTypes}">
						<c:set var="contains" value="false" />
						<c:forEach var="thisSplitCuisine" items="${splitCuisine}">
							<c:if test="${thisSplitCuisine == thisCuisineTypes.name}">
								<c:set var="contains" value="true" />
							</c:if>
						</c:forEach>
						<li><a href="#" class="radio-option <c:if test="${contains}">click</c:if>" id="${thisCuisineTypes.name}"><fmt:message key="common.constant.cuisinetype.${thisCuisineTypes.name}" /></a></li>
					</c:forEach>
				</ul>
				<a href="" class="menu-nav-more">
					<div class="scroll-text"></div>
					<span class="more-text">
						<fmt:message key='label.more.products' />
					</span>
					<span class="less-text">
						<fmt:message key='label.less.products' />
					</span> 
					<i class="more-icn"></i> 
				</a>
			</div>
			<div class="menu-nav-dropdown"><ul></ul></div>
		</div>
	</div>
</c:if>