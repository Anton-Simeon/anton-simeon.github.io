<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="isZone" value="${(company.deliveryZoneType eq 'RADIUS_MILES') or (company.deliveryZoneType eq 'RADIUS_KILOMETRES') or (company.deliveryZoneType eq 'CITYPOLYGON') or (company.deliveryZoneType eq 'POLYGON')}" />
<script src="/static/aaa_general/js/jquery.validate.min.js"></script>
<script type="text/javascript">
	var selectedCompanyId = '${company.id}';
	var selectedArea = '';
	function addAddress() {		   	
		$.ajax({
	    	type: "POST",
	    	url: '/ajaxaddaddress',
	    	data: $('#submenuform').serialize(),
	    	success: function(response) {
	    		var orderType= $("#orderType").val();
	    		var companyId = selectedCompanyId;
	    		var addressId = response.addressId;
	    		if (response.status == 'failure') {
	    			$("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
	    		} else if (response.status == 'sessiontimeout') {
	    			$("#errorDiv").html("");
	    			$('#addressBookModal').modal('toggle');
	    			 window.location.replace('/sessiontimeout');
	    		} else {
	    			if (response.refererUrl == 'confirmdetails') {
	    				$('#addressModal').modal('toggle');
		    			$('#addressbookTablediv').html(response.addressbookHtml);
		    			changeAddress(orderType, companyId, addressId);
		    		} else {
		    			$("#errorDiv").html("");
		    			$('#addressBookModal').modal('toggle');
		    			location.reload();
	    			}
	    		}
	    	},
	    	dataType: 'json'
	    });
		return false;
};
$(document).ready(function() {
	var cityValue = '';
	if($('#city').length > 0 && $("#city" ).attr("type") != 'text') {
		$('#city').on('change', function() {
			loadArea(this.value, null);
		});
	}
	function loadArea(_city, _selectedArea) {
		var value = _city; 
        $.ajax({
            type: "POST",
            url: '/getAreaNames?companyId=${companyId}',
            data: { city: value},
            dataType: "json",
            success: function(response) {
                $("#area").get(0).options.length = 0;
        		$.each(response.areaList, function(index, item) {
        			var __option = new Option(item.area, item.area);
        			if(_selectedArea != null && _selectedArea.toLowerCase() == item.area.toLowerCase()) {
        				$(__option).prop("selected", "selected");
        			}
                	$("#area").get(0).options[$("#area").get(0).options.length] = __option;
                });
            },
            error: function() {
                $("#area").get(0).options.length = 0;
            }
         });
    }
})
</script>
<jsp:include page="/aaa_general/js/addresspopup.jsp">
	<jsp:param value="add" name="action"/>
</jsp:include>
<div class="modal-header">
	<h4 class="modal-title"><fmt:message key='header.addaddress' /></h4>
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
</div>
<div class="modal-body">
	<c:set var="hideFormsection" value="display:block"/>
	<c:if test="${company.deliveryZoneType eq 'POLYGON' or company.deliveryZoneType eq 'CITYPOLYGON' or company.deliveryZoneType eq 'RADIUS_MILES' or company.deliveryZoneType eq 'RADIUS_KILOMETRES'}">
		<c:set var="hideFormsection" value="display:none"/>
		<div id="map-section">
			<div class="address-section">
				<div class="address-search-option"><p><span class="my-location"><fmt:message key='label.mapaddress.link.yourcurrentlocation' /></span><p></div>
				<div class="alert alert-dismissible alert-danger" id="mapErrorDropdown" style="display: none;">
					<strong><fmt:message key='label.mapaddress.requireDropdown' /></strong>
					<a href="#" class="alert-link"></a>
				</div>
				<div class="map-address-wrap">
					<input type="text" id="mapaddress" placeholder="<fmt:message key='label.mapaddress.message.typeyourdeliverylocation' />" class="form-control" style="width:80%"><button id="btnmapaddress" class="btn btn-primary" style="width:20%"><fmt:message key='label.mapaddress.button.submit' /></button>
					<div class="address-lists"></div>
				</div>
				<div class="alert alert-dismissible alert-danger" id="mapError">
					<strong><fmt:message key='label.mapaddress.require' /></strong>
					
				</div>
			</div>
	<div id="mapSection" class="dsd" style="width:100%; height: 350px; display: none;"></div>
		</div>
	</c:if>
	<div id="formSection" style="${hideFormsection}">
		<c:if test="${hideFormsection eq 'display:none'}">
			<a href="#" id="selectAddress"> &lt;&lt; <fmt:message key="label.link.selectaddress" /></a>
		</c:if>
		<form onsubmit="return false;" id="submenuform">
			<input type="hidden" name="refererUrl" id="refererUrl" value="${refererUrl}" />
			<input type="hidden" name="companyId" id="companyId" value="${companyId}" />
			<div id="errorDiv"></div>
			<c:forEach items="${addressFieldRules}" var="fieldRule">
				<c:if test="${fieldRule.userInterfaceType != 'option'}">
					<c:if test="${(fieldRule.fieldName eq 'coordinates') and (!fieldRule.display)}">
						<input type="hidden" name="coordinates" id="coordinates">
					</c:if>
					<c:if test="${fieldRule.display}">
						<div class="mb-3 ${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor' ? 'hidden dependent-field' : ''}" data-dependant-field="${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor'}" data-field-parent="${fieldRule.parent}" data-type-id="${fieldRule.fieldName}-${fieldRule.parent}">
							<label class="form-label" for="${fieldRule.fieldName}"><fmt:message key="label.${fieldRule.label}" /><c:if test="${fieldRule.required}"><span class="required">*</span></c:if></label>
							<c:choose>
								<c:when test="${ (fieldRule.fieldName == 'zipCode') or (fieldRule.fieldName == 'postCode') or (fieldRule.fieldName == 'coordinates') }">
									<c:choose>
										<c:when test="${isZone}">
											<input readonly="readonly" data-position="${fieldRule.parent}"  type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control check-value-js" />
										</c:when>
										<c:otherwise>
											<input data-position="${fieldRule.parent}"  type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control" />
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${fieldRule.fieldName == 'city'}">
									<c:choose>
										<c:when test="${fieldRule.userInterfaceType eq 'text'}">
											<input type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control">
										</c:when>
										<c:otherwise>
											<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control" >
												<c:forEach var="thisCity" items="${cityList}">
													<option value="${thisCity.city}">${thisCity.city}</option>
												</c:forEach>
											</select>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${fieldRule.fieldName == 'area'}">
									<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
										<c:forEach var="thisArea" items="${areaList}">
											<option value="${thisArea.area}">${thisArea.area}</option>
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
								<c:otherwise>
									<input data-position="${fieldRule.parent}"  type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control" />
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</c:if>
			</c:forEach>
			<div class="mb-3 d-grid">
				<button type="submit" class="btn btn-primary address-submit-button-js"><fmt:message key='label.button.addaddress' /></button>
			</div>
		</form>
	</div>
</div>