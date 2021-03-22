<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${(param.action ne 'edit') and (company.deliveryZoneType eq 'POLYGON' or company.deliveryZoneType eq 'CITYPOLYGON' or company.deliveryZoneType eq 'RADIUS_MILES' or company.deliveryZoneType eq 'RADIUS_KILOMETRES')}">
<c:set var="selectedCity"/>
<c:if test="${(!empty sessionScope.selectedCity)}">
	<c:set var="selectedCity" value="${sessionScope.selectedCity}"/>
</c:if>
	<script type="text/javascript">
		
		var add_address_map_service, add_address_pin_my_location;

		var map, pos, center;
		var jsonDefualtLocationParams = {};
		var selectedCity = '${sessionScope.selectedCity}';
		var selectedArea = '${sessionScope.selectedArea}';
		var companyCounty = '${company.country.country}';
		var latitude = '${branch.latitude}';
		var longitude = '${branch.longitude}';
		var isNotLocationeFromLatLng = true;
		jQuery('.modal-content').css('opacity', 0);
		
		if(latitude.length > 0 && latitude != '' && longitude.length > 0 && longitude != '') { 
			var latlng = {lat: parseFloat(latitude), lng: parseFloat(longitude)};
			jsonDefualtLocationParams['location'] = latlng;
			isNotLocationeFromLatLng = false;
		}
		
		if(isNotLocationeFromLatLng && selectedCity != '') {
			jsonDefualtLocationParams = {
				componentRestrictions : {
					locality : selectedCity,
				}
			};
		}
		if(isNotLocationeFromLatLng) {
			jsonDefualtLocationParams["address"] = selectedArea == '' ? companyCounty : selectedArea;
		}
		var languageLocale = '${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}';
		var lanagueRegion = languageLocale.split("_");
		var	languageCode = lanagueRegion[0];
		var	region = lanagueRegion[1];
		var checkForType = (function(){
			return function(types, typeLabel){
				for(var i=0; i<types.length;i++) {
					if(typeLabel.indexOf(types[i]) > -1) {
						return true;
					}				
				}
				return false;
			}
		})();
	
		var interpreatAddress = (function(){
			return function(address){
				var addressComponents = {};
				var addComponents = address.address_components;
				for(var i=0; i<addComponents.length;i++) {
					var addComponent = addComponents[i];
					if(checkForType(addComponent.types, ['premise', 'street_number','subpremise'])) {
						addressComponents["number"] = addComponent.long_name;
						addressComponents["houseNo"] = addComponent.long_name;
						addressComponents["appartNo"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['route', 'street', 'neighborhood', 'intersection', 'ward', 'park', 'colloquial_area'])) {
						addressComponents["street"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, 'postal_code')) {
						addressComponents["postcode"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['country'])) {
						addressComponents["country"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['administrative_area_level_4'])) {
						addressComponents["state"] = addComponent.long_name;
						addressComponents["region"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['administrative_area_level_3'])) {
						if(!addressComponents["state"]) {
							addressComponents["state"] = addComponent.long_name;
						}
						addressComponents["city"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['administrative_area_level_2', 'locality'])) {
						if(!addressComponents["city"]) {
							addressComponents["city"] = addComponent.long_name;
						}
						addressComponents["district"] = addComponent.long_name;
						addressComponents["province"] = addComponent.long_name;
					}
					if(checkForType(addComponent.types, ['administrative_area_level_1'])) {
						addressComponents["state"] = addComponent.long_name;
						if(addressComponents["district"]) {
							addressComponents["district"] = addComponent.long_name;
						}
						if(!addressComponents["city"]) {
							addressComponents["city"] = addComponent.long_name;	
							addressComponents["province"] = addComponent.long_name;	
						}
					} 
					if(checkForType(addComponent.types, ['sublocality', 'sublocality_level_1', 'sublocality_level_2'])) {
						addressComponents["area"] = addComponent.long_name;
					} 
					if(checkForType(addComponent.types, ['sublocality_level_1'])) {
						addressComponents["district"] = addComponent.long_name;
					} 
					if(checkForType(addComponent.types, ['sublocality_level_2'])) {
						addressComponents["subDistrict"] = addComponent.long_name;
					}
				}
				if(address.address_components.length > 1) {
					addAddressFun(address.address_components);
				}
				
				return addressComponents;
			}
		})()
		function addAddressFun(address) {
			var addressLine;
			var addressLine_no_admin;
			var addressLine_admin;
			var addressLineBoolean = false;

			var b = 0;
			var c = 0;

			for (var i = 0; i < address.length; i++) {
				
				if(address[i].types[0] == "postal_code") {
					jQuery('#postCode, #zipCode').val(address[i].long_name);
				}else {

					if(address[i].types[0] != "country") {
						if(b == 0) {
							addressLine_admin = address[i].short_name;
						}else {
							addressLine_admin = addressLine_admin + ", " + address[i].short_name;
						}
						b = b + 1;
					}

					if(address[i].types[0] != "country" && address[i].types[0] != "administrative_area_level_2" && address[i].types[0] != "administrative_area_level_1") {
						addressLineBoolean = true;
						if(c == 0) {
							addressLine_no_admin = address[i].short_name;
						}else {
							addressLine_no_admin = addressLine_no_admin + ", " + address[i].short_name;
						}
						c = c + 1;
					}

				}
			}

			if(addressLineBoolean) {
				addressLine = addressLine_no_admin;
			}else {
				addressLine = addressLine_admin;
			}

			jQuery('#addressLine1').val(addressLine);
		}

		var interpreatedAddress = null;
		function selectAddress() {
			var address = jQuery(this).data("address");
			jQuery("#mapaddress").val(address.formatted_address);
			interpreatedAddress = interpreatAddress(address);
			if(interpreatedAddress != null) {
				setValueForAddressField(interpreatedAddress);
				setCordinates(address.geometry.location.lat, address.geometry.location.lng);
			}
			pos = {
				lat: address.geometry.location.lat,
				lng: address.geometry.location.lng
			};
			map.setCenter(pos);		
			jQuery('.address-lists').hide();
			jQuery('#mapErrorDropdown').hide();
			jQuery('#mapError').hide();
		}
		function selectPlace(){
			var place = jQuery(this).data("place");
			jQuery("#mapaddress").val(place.description);
			var geocoder = new google.maps.Geocoder;
			geocoder.geocode({'placeId': place.place_id}, function(results, status) {
				if (status !== 'OK') {
				  window.alert('Geocoder failed due to: ' + status);
				  return;
				}
				var address = results[0];
				interpreatedAddress = interpreatAddress(address);
				if(interpreatedAddress != null) {
					setValueForAddressField(interpreatedAddress);
					setCordinates(address.geometry.location.lat, address.geometry.location.lng);
				}
				pos = {
					lat: address.geometry.location.lat(),
					lng: address.geometry.location.lng()
				};
				if(add_address_map_service != 'autocomplete_only') {
					map.setCenter(pos);
				}
				jQuery('.address-lists').hide();
				jQuery('#mapErrorDropdown').hide();
				jQuery('#mapError').hide();
			});
		}
		var buildAutoFill = (function(){
			return function(addresses, loadAllAddresses){				
				if(loadAllAddresses) {
					jQuery('.address-lists').show().html("");
					for (var i=0;i<addresses.length;i++) {
						var address = addresses[i];
						var tempHtml = "<div class='address-row'><div class='formated-address'>{formatedAddress}</div></div>";
						tempHtml = tempHtml.replace('{formatedAddress}', address.formatted_address);
						var addressRow = jQuery(tempHtml);
						addressRow.on("click", selectAddress);
						addressRow.data("address", address);
						jQuery('.address-lists').append(addressRow);
					}
				} else {
					jQuery('.address-lists').hide().html("");
					jQuery('#mapErrorDropdown').hide();
					jQuery('#mapError').hide();
					if(addresses.length > 0 ) {
						jQuery('#mapaddress').val(addresses[0].formatted_address);
					}
				}
			}
		})();
		
		// Returns a function, that, as long as it continues to be invoked, will not
		// be triggered. The function will be called after it stops being called for
		// N milliseconds. If `immediate` is passed, trigger the function on the
		// leading edge, instead of the trailing.
		function debounce(func, wait, immediate) {
			var timeout;
			return function() {
				var context = this, args = arguments;
				var later = function() {
					timeout = null;
					if (!immediate) func.apply(context, args);
				};
				var callNow = immediate && !timeout;
				clearTimeout(timeout);
				timeout = setTimeout(later, wait);
				if (callNow) func.apply(context, args);
			};
		};
		
		var myEfficientInputFn = debounce(function() {
			address = jQuery("#mapaddress").val();
			if(address != '') {
				var options = {
					input: address,
					region : region,
					componentRestrictions: {country: region},
					language : languageCode
				};
				var service = new google.maps.places.AutocompleteService();
				service.getPlacePredictions(options, function(predictions, status) {
					if (status != google.maps.places.PlacesServiceStatus.OK) {
						return;
					}
					jQuery('.address-lists').show().html("");
					predictions.forEach(function(prediction) {					
						var tempHtml = "<div class='address-row'><div class='formated-address'>{formatedAddress}</div></div>";
						tempHtml = tempHtml.replace('{formatedAddress}', prediction.description);
						var addressRow = jQuery(tempHtml);
						addressRow.on("click", selectPlace);
						addressRow.data("place", prediction);
						jQuery('.address-lists').append(addressRow);
					});
				});
			}
		}, 350);
		
	 	jQuery('#mapaddress').on('input', myEfficientInputFn);
		var setValueForSelector = (function(){
			return function(selector, value){
				if(document.getElementById(selector) != null && value) {
					document.getElementById(selector).value = value;
				}
			}
		})();
	 	jQuery('#btnmapaddress').on('click',function(e){

	 		setTimeout(function() {
	 			jQuery('#btnmapaddress').removeClass('disable-btn');
	 		}, 300);

			if($('.address-lists').length && $('.address-lists').is(":visible")) {
				jQuery('#mapErrorDropdown').show();
				console.log('Please select an address from the drop down');

			}else {
				//alert(jQuery("#mapaddress").val());
				var mapAddress = jQuery('#mapaddress').val();
				if(mapAddress.trim().length > 0) {
					jQuery('#map-section').hide();
					jQuery('#mapError').hide();
					// if(jQuery('#addressLine1').length > 0) {
					// 	console.log('mapAddress');
					// 	console.log(mapAddress);
					// 	jQuery('#addressLine1').val(mapAddress);	
					// } else {
					// 	if(interpreatedAddress != null) {
					// 		setValueForAddressField(interpreatedAddress);
					// 	}
					// }
					jQuery('#formSection').show();
				} else {
					jQuery('#mapError').show();
				}
			}
	 	});
	 	jQuery('#selectAddress').on('click',function(e){
	 		jQuery('#map-section').show();
			jQuery('#formSection').hide();
	 	});
	 	jQuery(".my-location").click(function(){
			getMyGeoLocation()
		});
	 	function setValueForAddressField(address) {
	 		if(jQuery('.check-value-js').length) {
	 			jQuery('.check-value-js').val('');
	 		}
	 		setValueForSelector("postCode", address.postcode);
	 		setValueForSelector("postcode", address.postcode);
			setValueForSelector("postalCode", address.postcode);
			setValueForSelector("buildingName", address.houseNo);
			setValueForSelector("number", address.number);
			setValueForSelector("homeNo", address.houseNo);
			setValueForSelector("officeNo", address.houseNo);
			setValueForSelector("officeBuildingName", address.appartNo);
			setValueForSelector("street", address.street);
			setValueForSelector("streetName", address.street);
			setValueForSelector("streetAddress", address.street);
			setValueForSelector("neighbourhood", address.street);
			setValueForSelector("townCity", address.city);
			setValueForSelector("city", address.city);
			setValueForSelector("province", address.province);
			setValueForSelector("country", address.country);
			setValueForSelector("apartmentNo.", address.appartNo);
			setValueForSelector("apartmentBuildingName", address.houseNo);
			setValueForSelector("directions", address.area);
			setValueForSelector("additionalDirections", address.area);
			setValueForSelector("subDistrict", address.subDistrict);
			setValueForSelector("district", address.district);
			if(jQuery('.check-value-js').length) {
				jQuery('.check-value-js').each(function(){
					var thisInput = jQuery(this);
					var thisVal = thisInput.val();
					if(thisVal.length) {
						thisInput.attr("readonly", true); 
					}else {
						thisInput.attr("readonly", false); 
					}
				});
			}
		}
		var getMyGeoLocation = (function() {
			return function(){
				if (navigator.geolocation && location.protocol === 'https:') {
					navigator.geolocation.getCurrentPosition(function(position) {
						pos = {
							lat: position.coords.latitude,
							lng: position.coords.longitude
						};
						map.setCenter(pos);
						center = new google.maps.LatLng(pos.lat,pos.lng);
						jQuery.get("https://maps.googleapis.com/maps/api/geocode/json?language="+languageCode+"&latlng="+map.getCenter().lat()+","+map.getCenter().lng()+"&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw", function(data, status){
							 if(data.status != 'OVER_QUERY_LIMIT') {
								 	jQuery('#mapaddress').val(data.results[0].formatted_address);
									interpreatedAddress = interpreatAddress(data.results[0]);
									setValueForAddressField(interpreatedAddress);
									setCordinates(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng);
								}
						});
					});
				}
			}
		})();
		function setCordinates(lat, lng) {
			if(typeof lat === "function") {
				setValueForSelector("coordinates", lat() + "," + lng());
			} else {
				setValueForSelector("coordinates", lat+ "," + lng);
			}
			if(jQuery('.check-value-js').length) {
				jQuery('.check-value-js').each(function(){
					var thisInput = jQuery(this);
					var thisVal = thisInput.val();
					if(thisVal.length) {
						thisInput.attr("readonly", true); 
					}else {
						thisInput.attr("readonly", false); 
					}
				});
			}
		}
	    function initMap() { 
			var mapOptions = {
				zoom: 12,
				center: new google.maps.LatLng(52.5498783, 13.425209099999961),
				mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			map = new google.maps.Map(document.getElementById('mapSection'), mapOptions);
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode(jsonDefualtLocationParams, function(results, status) {
			    if (status == google.maps.GeocoderStatus.OK) {
			        map.setCenter(results[0].geometry.location);
			        setCordinates(results[0].geometry.location.lat, results[0].geometry.location.lng);
			    		interpreatedAddress = interpreatAddress(results[0]);
			    }
			});
			
			 jQuery('<div/>').addClass('centerMarker').appendTo(map.getDiv())
	       	.click(function(){
	           	var that=jQuery(this);
				if(!that.data('win')) {
					that.data('win',new google.maps.InfoWindow({content:'Select Location'}));
					that.data('win').bindTo('position',map,'center');
				}
				that.data('win').open(map);
	         });
			 var myEfficientDragFn = debounce(function() {
				 console.log('drag event');
				 jQuery.get("https://maps.googleapis.com/maps/api/geocode/json?language="+languageCode+"&latlng="+map.getCenter().lat()+","+map.getCenter().lng()+"&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw", function(data, status){
					 console.log('data status '+data.status);
					 if (data.status != 'OVER_QUERY_LIMIT') {
		        			buildAutoFill(data.results, false);	
						interpreatedAddress = interpreatAddress(data.results[0]);
		        			setCordinates(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng);
		        			console.log('build data');
		        		} else {
		        			jQuery(".address-lists").hide();
							jQuery('#mapErrorDropdown').hide();
							jQuery('#mapError').hide();
		        			console.log('hide list');
		        		}        		
		            });
	     	}, 350);
	       	google.maps.event.addListener(map, 'drag', myEfficientDragFn)
	        jQuery(".address-lists").hide();
			jQuery('#mapErrorDropdown').hide();
			jQuery('#mapError').hide();
	    }

		google.maps.event.addDomListener(window, 'load', initMap);

	</script>
</c:if>
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
        	setTimeout(function(){
        		jQuery(".address-submit-button-js").removeClass('disable-btn');
        	}, 300);
		})


		jQuery.ajax({
			type: "GET",
			url: 'https://live.ordertiger.com/api/v1/companies/${companyId}',
			success: function(response) {
				console.log('response_popup');
				console.log(response.deliveryZoneSettings);

				var channelNumber = "";
				for (var i = 0; i < response.deliveryZoneSettings.length; i++) {
					var channel = response.deliveryZoneSettings[i].channel;

					if(channel == 'ALL' && channelNumber === "") {
						channelNumber = i;
					}
					if(channel == 'WEB') {
						channelNumber = i;	
					}

				}

				console.log(channelNumber);
				if(channelNumber !== "") {
					console.log('channelNumber');
					var deliveryZoneSettingParams = response.deliveryZoneSettings[channelNumber].deliveryZoneSettingParams;

					for (var i = 0; i < deliveryZoneSettingParams.length; i++) {
						var key = deliveryZoneSettingParams[i].key;

						if(key == 'add_address_map_service') {
							add_address_map_service = deliveryZoneSettingParams[i].value;
						}
						if(key == 'add_address_pin_my_location') {
							add_address_pin_my_location = deliveryZoneSettingParams[i].value;
						}

					}

				}else {
					add_address_map_service = null;
					add_address_pin_my_location = null;
				}

				if(add_address_map_service != 'autocomplete_only' && add_address_map_service != 'zipcode2_no_geo') {
					<c:if test="${(company.deliveryZoneType eq 'POLYGON' or company.deliveryZoneType eq 'CITYPOLYGON' or company.deliveryZoneType eq 'RADIUS_MILES' or company.deliveryZoneType eq 'RADIUS_KILOMETRES')}">
						jQuery('#mapSection').show();
						initMap();
					</c:if>
				}

				if(add_address_pin_my_location == 'no') {
					 jQuery('.my-location').hide();
				}
				jQuery('.modal-content').css('opacity', 1);

				// for test
				//add_address_map_service = "zipcode2_no_geo";
				console.log('add_address_map_service');
				console.log(add_address_map_service);
				console.log(response);

				if(add_address_map_service == "zipcode2_no_geo") {
					jQuery('#selectAddress').hide();
					jQuery('#map-section').hide();
					jQuery('#formSection').show();
					jQuery('#formSection input').removeAttr('readonly');
					jQuery('#submitbutton').hide();
					jQuery('#submitbutton').after('<button type="button" class="btn btn-primary btn-block" id="zipcode2_no_geo_btn">' + jQuery('#submitbutton').text() + '</button>');
					zipcode2_no_geo_fun();
					// jQuery("#coordinates").val(lat + "," + lng);
				}
			},
			error: function (error) {
				jQuery('.modal-content').css('opacity', 1);
			}
		});

		function zipcode2_no_geo_fun() {
			jQuery('#errorDiv').after("<div id=\"errorDiv2\" class=\"alert alert-dismissible alert-danger hidden\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button><strong></strong></div>");
			jQuery('#errorDiv2 .close').click(function(){
				jQuery('#errorDiv2').addClass('hidden');
				return false
			});
			jQuery('#zipcode2_no_geo_btn').click(function(){
				zipcode2_no_geo_Ajax(jQuery("#postCode").val());
				return false
			});
			jQuery('#formSection input').keydown(function(event){
			    if(event.keyCode == 13){
			    	zipcode2_no_geo_Ajax(jQuery("#postCode").val());
			        return false
			    }
			});
		}

		function zipcode2_no_geo_Ajax(value) {
			var dataZip = {
				"companyLocale" : '${company.companyLocale.language}_${company.companyLocale.country}',
				"postCode" : value
			}

			jQuery('#zipcode2_no_geo_btn').addClass('disable-btn');

			jQuery.ajax({
				headers: {
					Accept: "application/json",
					"Content-Type": "application/json"
				},
		    	type: "POST",
		    	data: JSON.stringify(dataZip),
		    	dataType: 'json',
				url: 'https://live.ordertiger.com/rest/postcodeanywhere/is-full-postcode',
				success: function(response) {					
					if(response) {
						jQuery.ajax({
							type: "POST",
							url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + value + '&components=${company.companyLocale.country}:GB&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw',
							success: function(response) {
								console.log('response_google');
								console.log(response.status);
								if(response.status == "ZERO_RESULTS") {
									jQuery('#errorDiv2 strong').html("<fmt:message key='postcode.invalid' />");
									jQuery('#errorDiv2').removeClass('hidden');
								}
								if(response.status == "OK") {
									var results_lat = response.results[0].geometry.location.lat;
									var results_lng = response.results[0].geometry.location.lng;
									console.log(results_lat + "," + results_lng);
									jQuery("#coordinates").val(results_lat + "," + results_lng);
									jQuery('#errorDiv2').addClass('hidden');
									jQuery('#submitbutton').click();
								}
								jQuery('#zipcode2_no_geo_btn').removeClass('disable-btn');
							}
						});
					}else {
						//error 
						jQuery('#errorDiv2 strong').html("<fmt:message key='postcode.invalid.length' />");
						jQuery('#errorDiv2').removeClass('hidden');
						jQuery('#zipcode2_no_geo_btn').removeClass('disable-btn');
					}
				}
			});
		}
	})
</script>