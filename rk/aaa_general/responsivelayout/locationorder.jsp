<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart"%>
<c:set var="restaurantsUrl"><fmt:message key='url.path.restaurantsurl' /></c:set>
<c:set var="displayOnlyOrderButton" value="false" />
<c:set var="geolocationaddress"><fmt:message key='url.path.geolocationaddress' /></c:set>
<c:set var="isCityPolyGon" value="${company.deliveryZoneType eq 'CITYPOLYGON'}" />
<c:set var="isRadius" value="${(company.deliveryZoneType eq 'RADIUS_MILES') or (company.deliveryZoneType eq 'RADIUS_KILOMETRES')}" />
<c:if test="${not empty param.locationurl}">
	<c:set var="displayOnlyOrderButton" value="true" />
	<c:set var="restaurantsUrl" value="${param.locationurl}" />
</c:if>
<div class="form-index">
<c:if test="${warningMessage != null}">
	<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		${warningMessage}
	</div>
</c:if>
<div id="errorInputDiv"></div>
<c:choose>
	<c:when test="${company.deliveryZoneType eq 'STORELISTING_ZIPCODE2'}">
		<div class="dropdown-style">
			<input name="dropdown-style-title" class="dropdown-style-title" id="dropdown-style-title" placeholder="<fmt:message key="store.listing.pickup.nearest.store" />." required="" type="text" autocomplete="off">
			<ul class="dropdown-style-content" id="dropdown-menu">
				<c:forEach var="thisBranch" items="${branches}">
				<li data-href="/menu/${thisBranch.urlPath}">${thisBranch.name} - ${thisBranch.town}</li>
				</c:forEach>	
			</ul>
			<a href="#" id="button-dropdown" class="search-button">Order</a>			
		</div>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<form accept-charset="UTF-8" action="/${restaurantsUrl}?companyId=${companyId}" method="POST" id="findbranchbypostcodeform" role="form">
			</c:when>
			<c:when test="${company.companyType eq 'GROCERYPORTAL'}">
				<form accept-charset="UTF-8"  action="/<fmt:message key='url.path.groceriesurl' />" method="POST" id="findbranchbypostcodeform" data-test="me">
			</c:when>
			<c:when test="${(company.id == '160') and (isCityPolyGon)}">
				<form accept-charset="UTF-8" action="/${geolocationaddress}?companyId=${companyId}" method="POST" id="findbranchbypostcodeform" role="form">
					<input type="hidden" name="locationFrom" id="locationFrom">
					<input type="hidden" name="city" id="city">
					<input type="hidden" name="area" id="area"> 
			</c:when>
			<c:otherwise>
				<form accept-charset="UTF-8" action="/${restaurantsUrl}" method="post" id="findbranchbypostcodeform" role="form">
			</c:otherwise>
		</c:choose>
		<input type="hidden" name="returnurl" value="${param.returnurl}" />
		<input type="hidden" id="companyId" name="companyId" value="${companyId}" />
		<input type="hidden" name="deliveryzonetype" id="deliveryzonetype" value="${company.deliveryZoneType}">
		<c:choose>
			<c:when test="${isCityPolyGon or isRadius}">
				<input type="hidden" name="latitude" id="latitude">
				<input type="hidden" name="longitude" id="longitude">
				<c:choose>
					<c:when test="${company.id != '160'}">
						<div id="addressFormDiv">
							<c:forEach items="${company.addressFieldRules}" var="fieldRule">
								<input type="hidden" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}">
							</c:forEach>
						</div>
						<div class="input-group">
							<label class="form-index-input form-index-address">
								<input type="text" class="form-control" id="address" placeholder="<fmt:message key="label.home.delivery.address"/>" autocomplete="off"/>
							</label>
							<button class="btn btn-primary form-index-btn index-btn-address-js" type="button" id="findStores"><fmt:message key="${param.buttontitle}" /></button>
							<div class="address-lists address-polygon-map-list"></div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="input-group">
							<plastocart:searchcriteria cityId="${cityId}" displayOnlyOrderButton="${displayOnlyOrderButton}"/>
							<button type="submit" class="btn btn-primary form-index-btn"><fmt:message key="${param.buttontitle}" /></button>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<div class="input-group">
					<plastocart:searchcriteria cityId="${cityId}" displayOnlyOrderButton="${displayOnlyOrderButton}"/>
					<button type="submit" class="btn btn-primary form-index-btn"><fmt:message key="${param.buttontitle}" /></button>
				</div>		
			</c:otherwise>
		</c:choose>
		</form>
	</c:otherwise>
</c:choose>
</div>