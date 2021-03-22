<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="com.blueplustechnologies.core.model.DeliveryZoneType" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plastocart" uri="/WEB-INF/plastocart.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="citypolygon"><%= DeliveryZoneType.CITYPOLYGON.name() %></c:set>
<c:set var="hasDelivery" value="false" />
<c:set var="hasCollection" value="false" />
<c:set var="hasCurbSide" value="false" />
<div class="info-box-hours">	<div class="info-box-head">
		<i class="address-info-icn"></i>
		<h2><fmt:message key='label.address' /></h2>
	</div>
	<div class="info-box-content">
		<div class="map-section">
			<div class="time-hours-row">
				<span>${branch.addressLine1} ${branch.addressLine2}, ${branch.city}, ${branch.postCode}</span>
			</div>
		</div>
	</div>
</div>
<c:if test="${branch.services.size() > 0}">
	<c:forEach var="branchServices" items="${branch.services}" varStatus="loop">
		<c:if test="${branchServices.active}">
			<div class="info-box-hours">
				<div class="info-box-head">
					<c:choose>
						<c:when test="${branchServices.orderType == 'DELIVERY'}">
							<c:set var="hasDelivery" value="true" />							
							<i class="dilivery-hours-icn"></i>
							<h2> <fmt:message key='DELIVERY' /> <fmt:message key='HOURS' /></h2>						
						</c:when>
						<c:when test="${branchServices.orderType == 'COLLECTION'}">
							<c:set var="hasCollection" value="true" />						
							<i class="collection-hours-icn"></i>
							<h2> <fmt:message key='COLLECTION' /> <fmt:message key='HOURS' /></h2>						
						</c:when>
						<c:when test="${branchServices.orderType == 'CURB-SIDE'}">
							<c:set var="hasCurbSide" value="true" />					
							<i class="collection-hours-icn"></i>
							<h2> <fmt:message key='CURB-SIDE' /> <fmt:message key='HOURS' /></h2>						
						</c:when>						
						<c:otherwise>
							<i class="collection-hours-icn"></i>
							<h2>${branchServices.orderType} <fmt:message key='HOURS' /></h2>						
						</c:otherwise>
					</c:choose>
				</div>
				<div class="info-box-content">
					<plastocart:dayopeningtimewriter title="${branch.name}" orderType="${branchServices.orderType}" branchId="${branch.id}" />
				</div>			
			</div>
		</c:if>
	</c:forEach>
</c:if>
<c:if test="${branch.paymentMethods.size() > 0}">
	<div class="info-box-hours">
		<div class="info-box-head">
			<i class="payment-info-icn"></i>
			<h2><fmt:message key='label.paymenttype' /></h2>
		</div>
		<div class="info-box-content">
			<div class="time-hours">
				<c:if test="${hasDelivery == 'true'}">
					<div class="time-hours-row">
						<span>
							<strong><fmt:message key='DELIVERY' /></strong>:
							<c:set var="deliveryIndex" value="0" />
							<c:forEach var="branchPaymentMethod" items="${branch.paymentMethods}" varStatus="status">
								<c:if test="${branchPaymentMethod.orderType == 'DELIVERY'}">
									<c:if test="${deliveryIndex > 0}">, </c:if><fmt:message key='${branchPaymentMethod.paymentType}' />
									<c:set var="deliveryIndex" value="${deliveryIndex + 1}" />									
								</c:if>							
							</c:forEach>							
						</span>
					</div>
				</c:if>
				<c:if test="${hasCollection == 'true'}">
					<div class="time-hours-row">
						<span>
							<strong><fmt:message key='COLLECTION' /></strong>:
							<c:set var="collectionIndex" value="0" />
							<c:forEach var="branchPaymentMethod" items="${branch.paymentMethods}" varStatus="status">
								<c:if test="${branchPaymentMethod.orderType == 'COLLECTION'}">
									<c:if test="${collectionIndex > 0}">, </c:if><fmt:message key='${branchPaymentMethod.paymentType}' />
									<c:set var="collectionIndex" value="${collectionIndex + 1}" />
								</c:if>
							</c:forEach>						
						</span>
					</div>
				</c:if>
				<c:if test="${hasCurbSide == 'true'}">
					<div class="time-hours-row">
						<span>
							<strong><fmt:message key='CURB-SIDE' /></strong>:
							<c:set var="curbSideIndex" value="0" />
							<c:forEach var="branchPaymentMethod" items="${branch.paymentMethods}" varStatus="status">
								<c:if test="${branchPaymentMethod.orderType == 'CURB-SIDE'}">
									<c:if test="${curbSideIndex > 0}">, </c:if><fmt:message key='${branchPaymentMethod.paymentType}' />
									<c:set var="curbSideIndex" value="${curbSideIndex + 1}" />									
								</c:if>							
							</c:forEach>				
						</span>
					</div>
				</c:if>							
			</div>
		</div>
	</div>		
</c:if>
<div class="info-box-hours">
	<c:if test="${hasDelivery == 'true'}">	
		<div class="info-box-head">
			<i class="delivery-zone-icn"></i>
			<h2><fmt:message key='label.branchdeliveryzones' /></h2>
		</div>
		<plastocart:printdeliveryzonesandfees branch="${branch}"  />
		<c:if test="${company.deliveryZoneType eq citypolygon}">
			<div id="map" style="width: 100%; height:300px;"></div>
		</c:if>
	</c:if>
</div>
<c:if test="${hasDelivery == 'true' and company.deliveryZoneType eq citypolygon}">
	<script type="text/javascript">

		var initMapDone = false;
		var map, polygonList = {};
		function initMap(selectedCity) {
			getLongitudeLatitudeByCityName(selectedCity, function(_location){

				if(initMapDone == false) {
					map = new google.maps.Map(document.getElementById('map'), {
						center: _location,
						zoom: 4
					});
					initMapDone = true;
				}
				drawingManager = new google.maps.drawing.DrawingManager({
				    drawingMode: google.maps.drawing.OverlayType.POLYGON,
				    drawingControl: false,
				    drawingControlOptions: {
				      position: google.maps.ControlPosition.TOP_CENTER,
				      drawingModes: ['polygon']
				    },
				    polygonOptions: {
				      editable : false, 
				      clickable : false
				    }
				});
				setCordsForPolygons();

			});
		}
		
		var getLongitudeLatitudeByCityName = (function(){
			return function(selectedCity, callback){
				var jsonDefualtLocationParams = {
					componentRestrictions : {
						locality : selectedCity,
					}
				};
				var geocoder = new google.maps.Geocoder();
				geocoder.geocode(jsonDefualtLocationParams, function(results, status) {
				    if (status == google.maps.GeocoderStatus.OK) {
				        callback(results[0].geometry.location);
				    } else {
				    	callback(null);
				    }
				});
			}
		})();

		var setCordsForPolygons = (function(){
			return function(){
				for(var i=0; i<_allDeliveryZoneCordsWithType.length; i++) {
					var polygonCordsListString = _allDeliveryZoneCordsWithType[i].polygon;
					var longitudeLatitudeStrings = polygonCordsListString.split(",");
					if (longitudeLatitudeStrings.length > 0) {
						var paths = [];
						for(var j=0; j<longitudeLatitudeStrings.length; j++) {
							var _cords = longitudeLatitudeStrings[j].split(" ");
							var latitudeLongitude = new google.maps.LatLng(_cords[0], _cords[1]);
							paths.push(latitudeLongitude);
						};
						paths.push(paths[0]);
						var randomColor = getRandomColor();
						var polyGon = new google.maps.Polygon({
			                 paths: paths,
			                 strokeColor: randomColor,
			                 editable : false,
			                 strokeOpacity: 0.8,
			                 strokeWeight: 2,
			                 fillColor: randomColor,
			                 fillOpacity: 0.35
			     		});
						polyGon.setMap(map);
						jQuery("#zone-section-color-"+_allDeliveryZoneCordsWithType[i].id).css({"background-color" : randomColor});
						polygonList[_allDeliveryZoneCordsWithType[i].id] = {
							polygon : polyGon,
							color : randomColor
						};
					}
				}
				setViewPortWithAllPolygones();
			}
		})();
		
		function getRandomColor() {
			var letters = '0123456789ABCDEF';
			var color = '#';
			for (var i = 0; i < 6; i++) {
				color += letters[Math.floor(Math.random() * 16)];
			}
			return color;
		}
		
		function setViewPortWithAllPolygones() {
			var viewport = map.getBounds();
			var latlngbounds = new google.maps.LatLngBounds();
			for(var i=0; i<_allDeliveryZoneCordsWithType.length; i++) {
				var polygonCordsListString = _allDeliveryZoneCordsWithType[i].polygon;
				var longitudeLatitudeStrings = polygonCordsListString.split(",");
				if (longitudeLatitudeStrings.length > 0) {
					for(var j=0; j<longitudeLatitudeStrings.length; j++) {
						var _cords = longitudeLatitudeStrings[j].split(" ");
						latlngbounds.extend(new google.maps.LatLng(_cords[0], _cords[1]));
					};
				}
			}
			map.fitBounds(latlngbounds);
		}
	</script>
</c:if>