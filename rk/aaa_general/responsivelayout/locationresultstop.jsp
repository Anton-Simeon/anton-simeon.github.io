<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="restaurantUrl"><fmt:message key='url.path.restaurantsurl' /></c:set>
<c:set var="restaurantCityUrl"><fmt:message key='url.path.restaurantscityurl' /></c:set>
<c:if test="${company.companyType eq 'GROCERYPORTAL'}">
	<c:set var="groceriesCityUrl"><fmt:message key='url.path.groceriescityurl' /></c:set>
	<c:set var="groceriesUrl"><fmt:message key='url.path.groceriesurl' /></c:set>
</c:if>
<div class="${param.className}">
	<c:choose>
		<c:when test="${company.companyType eq 'GROCERYPORTAL'}">
			<div class="total-restaurants">
				<c:choose>
					<c:when test="${deliveryZoneType == 'CITYAREA'}">
						<c:choose>
							<c:when test="${area != null and area != ''}">
								${pagedListHolder.source.size()} <fmt:message key='label.storesin' /> ${fn:toLowerCase(city)}, ${fn:toLowerCase(area)}
							</c:when>    
							<c:otherwise>
								${pagedListHolder.source.size()} <fmt:message key='label.storesin' /> ${fn:toLowerCase(city)}
							</c:otherwise>
						</c:choose>
					</c:when>    
					<c:when test="${deliveryZoneType == 'ZIPCODE2' or deliveryZoneType == 'ZIPCODE'}">
						${pagedListHolder.source.size()} <fmt:message key='label.storesin' /> ${fullLocation}
					</c:when>    
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${deliveryZoneType == 'CITYAREA'}">
					<c:choose>
					<c:when test="${area != null and area != ''}">
						<div class="total-restaurants">
						<c:choose>
						<c:when test="${cuisine != null and cuisine != ''}">
							${pagedListHolder.source.size()} ${fn:toLowerCase(cuisine)} <fmt:message key='label.restaurantin' /> ${fn:toLowerCase(city)}, ${fn:toLowerCase(area)}
						</c:when>
						<c:otherwise>
							${pagedListHolder.source.size()} <fmt:message key='label.restaurantin' /> ${fn:toLowerCase(city)}, ${fn:toLowerCase(area)}
						</c:otherwise>
						</c:choose>
						</div>
					</c:when>    
					<c:otherwise>
						<div class="total-restaurants">
						${pagedListHolder.source.size()} <fmt:message key='label.restaurantin' /> ${fn:toLowerCase(city)}
						</div>
					</c:otherwise>
					</c:choose>
				</c:when>    
				<c:when test="${deliveryZoneType == 'ZIPCODE2' or deliveryZoneType == 'ZIPCODE'}">
					<div class="total-restaurants">
					${pagedListHolder.source.size()} <fmt:message key='label.restaurantin' /> ${fullLocation}
					</div>
				</c:when>    
				<c:otherwise>								
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
</div>