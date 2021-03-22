<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="confirmDetailsUrl"><fmt:message key='url.path.confirmdetails' /></c:set>
<script src="/static/aaa_general/js/jquery.validate.min.js"></script>
<script type="text/javascript">
	var selectedCompanyId = '${company.id}';
	function editAddress() {		   	
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxeditaddress',
	    	data: jQuery('#submenuform').serialize(),
	    	success: function(response) {
	    		var orderType= jQuery("#ordertype").val();
	    		var companyId = selectedCompanyId;
	    		var addressId = response.addressId;
	    		if (response.status == 'failure') {
	    			jQuery("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
	    		} else if (response.status == 'sessiontimeout') {
	    			jQuery("#errorDiv").html("");
	    			jQuery('#addressBookModal').modal('toggle');
	    			 window.location.replace('/sessiontimeout');
	    		} else {
	    			if (response.refererUrl == 'confirmdetails') {
	    				jQuery('#addressModal').modal('toggle');
		    			jQuery('#addressbookTablediv').html(response.addressbookHtml);
		    			changeAddress(orderType, companyId, addressId);
		    		} else {
		    			jQuery("#errorDiv").html("");
		    			jQuery('#addressBookModal').modal('toggle');
		    			location.reload();
	    			}
	    		}
	    	},
	    	dataType: 'json'
	    });
		return false;
	};	
jQuery(document).ready(function() {
	jQuery("#submitbutton_edit").click(function() {
		jQuery("#submenuform").submit();
	});

	if (jQuery('#city').length > 0 && jQuery("#city" ).attr("type") != 'text') {
		jQuery('#city').on('change', function() {
			var value = jQuery(this).val(); 
	        jQuery.ajax({
	            type: "POST",
	            url: '/getAreaNames?companyId=${companyId}',
	            data: { city: value},
	            dataType: "json",
	            success: function(response) {
	                jQuery("#area").get(0).options.length = 0;
	        		$.each(response.areaList, function(index, item) {
	                	jQuery("#area").get(0).options[jQuery("#area").get(0).options.length] = new Option(item.area, item.area);
	                });
	            },
	            error: function() {
	                jQuery("#area").get(0).options.length = 0;
	            }
	         });
	    })
	}
})
</script>
<jsp:include page="/aaa_general/js/addresspopup.jsp">
	<jsp:param value="edit" name="action"/>
</jsp:include>
<div class="modal-header">
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
	<h4 class="modal-title"><fmt:message key='header.editaddress' /></h4>
</div>
<div class="modal-body">
	<c:set var="hideFormsection" value="display:block"/>
		<c:if test="${((company.companyLocale.language ne 'en') or (company.companyLocale.country ne 'GB'))}">
			<c:set var="hideFormsection" value="display:none"/>
			<div id="map-section">
				<div class="address-section">
					<div class="address-search-option"><p><a class="my-location" ><fmt:message key='label.mapaddress.link.yourcurrentlocation' /></a><p></div>
					<div class="map-address-wrap">
						<input type="text" id="mapaddress" placeholder="<fmt:message key='label.mapaddress.message.typeyourdeliverylocation' />" class="form-control" style="width:80%"><button id="btnmapaddress" class="btn btn-primary" style="width:20%"><fmt:message key='label.mapaddress.button.submit' /></button>
						<div class="address-lists">
						</div>
					</div>					<div class="alert alert-dismissible alert-danger" id="mapError">
						<strong><fmt:message key='label.mapaddress.require' /></strong>
						
					</div>
				</div>
				<div id="mapSection" style="width:100%; height: 350px;">
				</div>
			</div>
		</c:if>
		<div id="formSection" style="${hideFormsection}">
			<c:if test="${hideFormsection eq 'display:none'}">
				<a href="#" id="selectAddress"> << <fmt:message key="label.link.selectaddress" /></a>
			</c:if>
			<form onsubmit="return false" method="post" id="submenuform">
				<input type="hidden" name="refererUrl" id="refererUrl" value="${refererUrl}">
				<input type="hidden" name="id" id="id" value="${address.id}">
				<input type="hidden" name="companyId" id="companyId" value="${companyId}">
				<div id="errorDiv"></div>
				<c:forEach items="${addressFieldRules}" var="fieldRule">
					<c:if test="${fieldRule.fieldName eq 'coordinates'}">
						<c:forEach items="${address.addressFields}" var="addressFields">
							<c:if test="${fieldRule.fieldName == addressFields.fieldName}">
								<input type="hidden" name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" value="${addressFields.fieldValue}">
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${fieldRule.display and fieldRule.userInterfaceType != 'option'}">
						<div class="form-group ${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor' ? 'hidden dependent-field' : ''}" data-dependant-field="${fieldRule.fieldName == 'buildingName' or fieldRule.fieldName == 'floor'}" data-field-parent="${fieldRule.parent}" data-type-id="${fieldRule.fieldName}-${fieldRule.parent}">
							<label for="${fieldRule.fieldName}"><fmt:message key="label.${fieldRule.label}" /><c:if test="${fieldRule.required}"><span class="required">*</span></c:if></label>
							<c:set value="false" var="isValueSet"/>
							<c:forEach items="${address.addressFields}" var="addressFields">
								<c:if test="${fieldRule.fieldName == addressFields.fieldName}">
									<c:set value="true" var="isValueSet"/>	
									<c:choose>
										<c:when test="${fieldRule.fieldName == 'city'}">
											<c:choose>
												<c:when  test="${fieldRule.userInterfaceType eq 'text'}">
													<input  value="${addressFields.fieldValue}" type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control">
												</c:when>
												<c:otherwise>
													<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
														<c:forEach var="thisCity" items="${cityList}">
															<c:choose>
															<c:when test="${thisCity.city == addressFields.fieldValue}">
																<option value="${thisCity.city}" selected>${thisCity.city}</option>
															</c:when>
															<c:otherwise>
																<option value="${thisCity.city}">${thisCity.city}</option>
															</c:otherwise>
															</c:choose>
														</c:forEach>
													</select>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${fieldRule.fieldName == 'area'}">
											<select name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
												<c:forEach var="thisArea" items="${areaList}">
													<c:choose>
													<c:when test="${thisArea.area == addressFields.fieldValue}">
														<option value="${thisArea.area}" selected>${thisArea.area}</option>
													</c:when>
													<c:otherwise>
														<option value="${thisArea.area}">${thisArea.area}</option>
													</c:otherwise>
													</c:choose>
												</c:forEach>
											</select>
										</c:when>
										<c:when test="${fieldRule.userInterfaceType == 'selectbox'}">
											<select data-position="${fieldRule.id}" name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
												<c:forEach var="thisAddressFieldRule" items="${addressFieldRules}">
													<c:if test="${thisAddressFieldRule.userInterfaceType == 'option'}">
														<option ${addressFields.fieldValue eq thisAddressFieldRule.fieldName ? 'selected' : ''} data-position="${thisAddressFieldRule.parent}" value="${thisAddressFieldRule.fieldName}"><fmt:message key="label.${thisAddressFieldRule.label}" /></option>
													</c:if>
												</c:forEach>
											</select>
										</c:when>	
										<c:otherwise>
											<input data-position="${fieldRule.parent}"  type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}"  value="${addressFields.fieldValue}" class="form-control" />											
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
							<c:if test="${isValueSet == false}">
							<c:choose>
								<c:when test="${fieldRule.fieldName == 'city'}">
									<c:choose>
										<c:when test="${fieldRule.userInterfaceType eq 'text'}">
											<input value="${addressFields.fieldValue}" type="${fieldRule.userInterfaceType}" id="${fieldRule.fieldName}" name="${fieldRule.fieldName}" class="form-control">
										</c:when>
										<c:otherwise>
											<select  name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
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
									<select  data-position="${fieldRule.id}" name="${fieldRule.fieldName}" id="${fieldRule.fieldName}" class="form-control">
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
							</c:if>
						</div>
					</c:if>
				</c:forEach>
				<div class="mb-3">
					<button type="button" class="btn btn-primary btn-block address-submit-button-js" id="submitbutton_edit"><fmt:message key='label.button.update' /></button>
				</div>		
			</form>
		</div>
</div>