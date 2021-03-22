<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
var map, centerOfMap, options;
function initMap() {
	centerOfMap = new google.maps.LatLng(-34.397, 150.644);    
	options = {
	  center: centerOfMap, 
	  zoom: 18 
	};
	
	map = new google.maps.Map(document.getElementById('mapSection'), options);
	
	if (navigator.geolocation) {
		var pos;
		navigator.geolocation.getCurrentPosition(function(position) {
			pos = {
				lat: position.coords.latitude,
				lng: position.coords.longitude
			};
			console.log(pos.lat+"----"+pos.lng);
			map.setCenter(pos);
		});
		
	}	 
}
</script>
<script type="text/javascript">
	jQuery(document).ready(function(){
		var checkFieldRules = (function(){	 
			var typeField = {
				"home" : "2",
				"office" : "3",
				"apartment" : "1"
			}
	    	return function(selectedType, callback){    		
	    		for(var key in typeField) {
		    		if(selectedType == key) {
		    			jQuery("[data-field-parent='"+typeField[key]+"']").show();
		    		} else {
		    			jQuery("[data-field-parent='"+typeField[key]+"']").hide();
		    		}
		    	}    		
				var selectedTypeParent = jQuery("#addressType option[value="+selectedType+"]").data("position")
	    		jQuery("[data-type-id=buildingName-"+selectedTypeParent+"]").removeClass("hidden");
	        	jQuery("[data-type-id=floor-"+selectedTypeParent+"]").removeClass("hidden");
	        	if(callback) {
	        		callback();
	        	}
	    	}
	    })();
		
		jQuery('#addressType').on('change', function(){
	    	var selectedType = jQuery(this).val();
	    	jQuery("[data-dependant-field=true]").addClass("hidden");	    	
	    	checkFieldRules(selectedType);
	    });		
		jQuery.validator.addMethod("alpha_numeric", function(value, element) {
			return this.optional(element)
					|| value == value.match(/^[a-zA-Z0-9\s]+$/);
		});
		// Extend email validation method so that it ignores whitespace
		jQuery.validator.addMethod("minlengthWithoutSpace", function(value, element) {
		    return (value+"").replace(/ /g,'').length >= 5;
		});
		jQuery.validator.addMethod("maxlengthWithoutSpace", function(value, element) {
		    return (value+"").replace(/ /g,'').length <= 7;
		});
		
		checkFieldRules(jQuery('#addressType').val(), function(){
			jQuery('#submenuform').validate({
			    rules: {				    	
			    	<c:forEach items="${addressFieldRules}" var="fieldRule">
					<c:if test="${fieldRule.userInterfaceType != 'option' && fieldRule.required}">
						<c:choose>
							<c:when test="${fieldRule.fieldName eq 'homeNo.'}">
							"homeNo." : {
					    		required: function(element) {
					            	return jQuery("#addressType").val() == "home";
					    		}
					        },
							</c:when>
							<c:when test="${fieldRule.fieldName eq 'postCode'}">
								<c:choose>
									<c:when test="${company.deliveryZoneType eq 'ZIPCODE2'}">
										"postCode" : {
											required : true,
											alpha_numeric : true,
											minlengthWithoutSpace : true,
											maxlengthWithoutSpace : true
								        },
							        </c:when>
							        <c:otherwise>
								        "postCode" : {
											required : true
								        },
							        </c:otherwise>
						        </c:choose>
							</c:when>
					        <c:when test="${fieldRule.fieldName eq 'apartmentNo.' or fieldRule.fieldName eq 'apartmentFloor.' or fieldRule.fieldName eq 'apartmentBuildingName'}">
							"${fieldRule.fieldName}" : {
					    		required: function(element) {
					            	return jQuery("#addressType").val() == "apartment";
					    		}
					        },
							</c:when>
					        <c:when test="${fieldRule.fieldName eq 'officeNo.' or fieldRule.fieldName eq 'officeFloor' or fieldRule.fieldName eq 'officeBuildingName'}">
							"${fieldRule.fieldName}" : {
					    		required: function(element) {
					            	return jQuery("#addressType").val() == "office";
					    		}
					        },
							</c:when>
					        <c:otherwise>
					        "${fieldRule.fieldName}":  "required",
					        </c:otherwise>
						</c:choose>
			    	</c:if>
			    	</c:forEach>
			    },
			    messages: {
			    	"addressLine1": "<fmt:message key='addressLine1.required'/>",
			    	"addressLine2": "<fmt:message key='addressLine2.required'/>",
			    	"postCode": "<fmt:message key='postCode.required'/>",
			    	"street": "<fmt:message key='street.required'/>",
			    	"buildingName": "<fmt:message key='buildingname.required'/>",
			        "homeNo.": {
			            required: "<fmt:message key='homeNo..required'/>"
			        },
			        "apartmentNo." : {
			        	required: "<fmt:message key='apartmentNo..required'/>"
			        },
			        "officeNo." : {
			    		required: "<fmt:message key='officeNo..required'/>"
			        },
			        "officeFloor" : {
			    		required: "<fmt:message key='floor.required'/>"
			        }, 
		        	"officeBuildingName": {
			    		required: "<fmt:message key='buildingname.required'/>"
			        },
			        "apartmentFloor" : {
			    		required: "<fmt:message key='floor.required'/>"
			        }, 
		        	"apartmentBuildingName": {
			    		required: "<fmt:message key='buildingname.required'/>"
			        },
			        "postCode" : {
						required : "<fmt:message key='postCode.required'/>",
						alpha_numeric : "<fmt:message key='postcode.invalid'/>",
						minlengthWithoutSpace : "<fmt:message key='postcode.invalid'/>",
						maxlengthWithoutSpace : "<fmt:message key='postcode.invalid'/>",
			        }
			    }
			});
		});
		jQuery(".address-submit-button-js").on("click", function(){
			if (jQuery('#submenuform').valid()) {		        		
        		${param.action eq 'add' ? 'addAddress();' : "editAddress();"}
        	}
		})
		<c:if test="${(param.action eq 'add') and ((company.companyLocale.language ne 'en') or (company.companyLocale.country ne 'GB'))} ">
			initMap();
		</c:if>
	})
</script>