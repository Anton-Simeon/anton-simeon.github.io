<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.blueplustechnologies.plastocart.util.Constants" %>
<c:set var="selectedCity"/>
<c:set var="selectedArea"/>
<c:if test="${(!empty sessionScope.selectedCity) and (!empty sessionScope.selectedArea) and (!empty referralPage)}">
	<c:set var="selectedCity" value="${sessionScope.selectedCity}"/>
	<c:set var="selectedArea" value="${sessionScope.selectedArea}"/>
</c:if>
<jsp:include page="/aaa_general/js/addresspopup-polygon.jsp">
	<jsp:param value="add" name="action"/>
</jsp:include>
<div>
	<c:if test="${not empty addresses}">
		<div class="saved-address">
			<div class="text-center">
				<div class="row">
					<div class="col-sm-8 col-sm-push-2">
					<h2><fmt:message key='label.provide.delivery.address' /></h2>
					<h4><fmt:message key='label.choose.from.saved.address' /></h4>
					<select id="savedAddressList" name="savedAddressList" class="form-control select-address">
						<option value="-1"><fmt:message key='label.select.saved.addresses' /></option>
						<c:forEach var="address" items="${addresses}">
							<option value="${address.id}" >
								<c:forEach items="${company.addressFieldRules}" var="fieldRule">
									<c:forEach var="thisAddressFields" items="${address.addressFields}" varStatus="rowStatus1">
										<c:if test="${fieldRule.fieldName == thisAddressFields.fieldName && fieldRule.display}">
											${thisAddressFields.fieldValue}<c:if test="${rowStatus1.index < thisCustomerAddress.addressFields.size() - 1}">, </c:if>
										</c:if> 
									</c:forEach>
								</c:forEach>
							</option>
						</c:forEach>
					</select>
					</div>
				</div>
			</div>
		</div>
	</c:if>
	<c:if test="${warningMessage != null}">
		<div class="alert alert-dismissible alert-danger polygon">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${warningMessage}</strong>
			
		</div>
	</c:if>
	<c:set var="hideFormsection" value="display:block"/>
	<c:if test="${company.companyLocale.language ne 'en' or company.companyLocale.country ne 'GB'}">
		<c:set var="hideFormsection" value="display:none"/>
		<div id="map-section">
			<div class="address-section">
				<div class="address-search-options"><a class="my-location" ><fmt:message key='label.mapaddress.link.yourcurrentlocation' /></a></span>
				</div>
				<input type="text" id="mapaddress" placeholder="<fmt:message key='label.mapaddress.message.typeyourdeliverylocation' />" class="form-field " style="width:100%"><button id="btnmapaddress" class="pull-right hidden apply-btn" style="width:8%"><fmt:message key='label.mapaddress.button.apply' /></button>
				<div class="alert alert-dismissible alert-danger" id="mapError">
					<strong><fmt:message key='label.mapaddress.require' /></strong>
					
				</div>
				<div class="address-lists polygon-map-list">
				</div>
			</div>				
		</div>
	</c:if>
	<div class="map-polygon hidden" id="formSection">
		<form method="POST" class="submenuform col-md-12 col-sm-12 col-xs-12" action="/restaurants">
			<input type="hidden" name="companyId" id="companyId" value="${companyId}">
			<input type="hidden" name="latitude" id="latitude">
			<input type="hidden" name="longitude" id="longitude">
			<input type="hidden" name="deliveryzonetype" id="deliveryzonetype" value="${company.deliveryZoneType}">
			<input type="hidden" name="returnUrl" id="returnUrl" value="${param.returnurl}">
			<input type="hidden" name="isFindMyLocation" id="isFindMyLocation" value="true">
			<input type="hidden" name="coordinates" id="coordinates">
			<input type="hidden" name="addressId" id="addressId">
			<div id="errorDiv"></div>
			<c:forEach items="${addressFieldRules}" var="fieldRule">
				<c:if test="${fieldRule.userInterfaceType != 'option'}">
					<c:if test="${fieldRule.display}">
						<div class="form-group ${fieldRule.fieldName == 'directionsLandmarks' ? 'instruction-section' : ''} ${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor' ? 'hidden dependent-field' : ''}" data-dependant-field="${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor'}" data-field-parent="${fieldRule.parent}" data-type-id="${fieldRule.fieldName}-${fieldRule.parent}">
							<label for="${fieldRule.fieldName}"><fmt:message key="label.${fieldRule.label}" /><c:if test="${fieldRule.required}"><span class="required">*</span></c:if></label>
							<c:choose>
								<c:when test="${fieldRule.fieldName == 'city'}">
									<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control ${!empty selectedCity ? 'readonly=\"true\"' : ''}" >
										<c:forEach var="thisCity" items="${cityList}">
											<option value="${thisCity.city}" ${fn:containsIgnoreCase(thisCity.city, selectedCity) ? 'selected' : ''}>${thisCity.city}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:when test="${fieldRule.fieldName == 'area'}">
									<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control ${!empty selectedArea ? 'readonly=\"true\"' : ''}">
										<c:forEach var="thisArea" items="${areaList}">
											<option value="${thisArea.area}" ${fn:containsIgnoreCase(thisArea.area, selectedArea) ? 'selected' : ''}>${thisArea.area}</option>
										</c:forEach>
									</select>
								</c:when>
								<c:when test="${fieldRule.userInterfaceType == 'selectbox'}">
									<select data-position="${fieldRule.id}" name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
										<c:forEach var="thisAddressFieldRule" items="${addressFieldRules}">
											<c:if test="${thisAddressFieldRule.userInterfaceType == 'option'}">
												<option data-position="${thisAddressFieldRule.parent}" value="${thisAddressFieldRule.fieldName}"><fmt:message key="label.${thisAddressFieldRule.label}" /></option>
											</c:if>
										</c:forEach>
									</select>
								</c:when>
								<c:when test="${fieldRule.fieldName == 'directionsLandmarks'}">
									<textarea data-position="${fieldRule.parent}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control" ></textarea>
								</c:when>			
								<c:otherwise>
									<input data-position="${fieldRule.parent}"  type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" ${(fieldRule.fieldName eq 'number' || fieldRule.fieldName eq 'directionsLandmarks')  ? '' : 'readonly=\"true\"'} value="" class="form-control" />
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</c:if>
			</c:forEach>
			<div class="form-group pull-right no-margin">
				<label>&nbsp;</label>
				<button type="submit" class="btn pull-right btn-primary fullwidth address-submit-button-js"><fmt:message key='label.button.confirmlocation' /></button>
			</div>
		</form>
	</div>
	<div id="mapSection" class="poygon-map-div">
	</div>
</div>
<script type="text/javascript">
	jQuery("#savedAddressList").change(function(){
		if(this.options[this.selectedIndex].value != '-1') {
			jQuery("#formSection #latitude").val("");
			jQuery("#formSection #longitude").val("");
			jQuery("#formSection #addressId").val(this.options[this.selectedIndex].value);
			jQuery("#formSection form").submit();
		}
	});
</script>