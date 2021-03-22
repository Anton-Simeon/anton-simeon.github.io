<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div id="addressPolygonModal" class="modal" role="dialog" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3><fmt:message key='store.address.verification' /></h3>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
			</div>
			<div class="modal-body">
				<div class="map-address-wrap">
					<input type="text" class="form-control" id="modaladdress" autocomplete="off">
					<div class="address-lists address-polygon-map-list-modal"></div>
				</div>
				<div class="addressPolygonModalError" style="display: none;">
					<div class="alert alert-dismissible alert-danger" style="margin-top: 10px;">
						<strong><fmt:message key='store.no.delivery.customer.location' /></strong>
					</div>
				</div>
			
				<input type="hidden" id="minDeliveryAmount" value="${journeyState.minDeliveryAmount}">
				<input type="hidden" id="deliveryFee" value="${journeyState.deliveryFee}">

				<input type="hidden" id="var_categoryId">
				<input type="hidden" id="var_productId">
				<input type="hidden" id="var_productCategoryId">

				<div class="text-center mt-3"><button type="button" id="confirmLocationModal" class="btn btn-primary"><fmt:message key="label.button.confirmlocation" /></button></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var map, pos = undefined, jsonDefualtLocationParams = [];
	var geocoder, interpreatedAddress;
	var languageLocale = '${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}';
	var languageCode = languageLocale.split("_")[0];
	var region = '${company.companyLocale.country}';
	var modalautocomplete;
	var isIsraelCountry = "${company.companyLocale.country eq 'il' || company.companyLocale.country eq 'IL'}";
	var branchId = "${branch.getId()}";
	var branchId_journeyState = "${defaultLocale}";
	var branchId_journeyState2 = "${journeyState.minDeliveryAmount}";
	
	
	jQuery(document).ready(function() {
		jQuery('#modaladdress').on('input', function(){
			if (jQuery(this).val() != '') {
				myEfficientInputFn();
			} else {
				jQuery(visibleAddressList()).hide();
			}
		});
		jQuery('.my-location').on('click', function(){
			getMyGeoLocation();
		});
		jQuery('.close.hideme').on('click', function(){
			jQuery(this).parent().addClass("hidden");
		});
	});
	
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
	
	var setValueForSelector = (function(){
		return function(selector, value){
			if(document.getElementById(selector) != null && value) {
				document.getElementById(selector).value = value;
			} else if (document.getElementById(selector) != null) {
				document.getElementById(selector).value = '';
			}
		}
	})();
	
	var myEfficientInputFn = debounce(function() {
		address = jQuery(visibleAddressInput()).val();
		if(isIsraelCountry !== "true") {
			if (address != '') {
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
					jQuery(visibleAddressList()).show().html("");
					predictions.forEach(function(prediction) {
						var tempHtml = "<div class='address-row'><div class='formated-address'>{formatedAddress}</div></div>";
						tempHtml = tempHtml.replace('{formatedAddress}', prediction.description);
						var addressRow = jQuery(tempHtml);
						addressRow.on("click", function(e){
							selectPlace(jQuery(this).data("place"));
						});
						addressRow.data("place", prediction);
						jQuery(visibleAddressList()).append(addressRow);
					});
					if (predictions.length !== 0) {
						if(typeof geocoder === 'undefined') {
							geocoder = new google.maps.Geocoder;
						}
						getPlaceFromPlaceId(predictions[0].place_id);
					}
				});
			}
		}
	}, 350);

	function getPlaceFromPlaceId(placeId) {
		geocoder.geocode({'placeId': placeId}, function(results, status) {
			if (status !== 'OK') {
			  window.alert('Geocoder failed due to: ' + status);
			  return;
			}
			var address = results[0];
			pos = {
				lat: address.geometry.location.lat(),
				lng: address.geometry.location.lng()
			};


			interpreatedAddress = interpreatAddress(address);
			if(interpreatedAddress != null) {
				setValueForAddressField(interpreatedAddress);
			}
			setCordinates(pos.lat, pos.lng);
		});
	}
	var referenceFromModal = function() {
		return function () {
			return jQuery('#addressPolygonModal').is(':visible');
		}
	}();
	
	
	var visibleAddressInput = function() {
		return function (){
			return referenceFromModal() ? "#modaladdress" : "#address" ; 
		}
	}();
	
	
	var visibleAddressList = function() {
		return function (){ 
			return referenceFromModal() ? ".address-polygon-map-list-modal" : ".address-polygon-map-list" ; 
		}
	}();
	
	function selectPlace(place) {
		if(isIsraelCountry !== "true") {
			jQuery("#modaladdress").val(place.description);
			jQuery("#address").val(place.description);
		} else {
			jQuery("#modaladdress").val(place.formatted_address);
			jQuery("#address").val(place.formatted_address);
		}
		
		geocoder.geocode({'placeId': place.place_id}, function(results, status) {

			if (status !== 'OK') {
			  window.alert('Geocoder failed due to: ' + status);
			  return;
			}
			var address = results[0];
			/* 
			interpreatedAddress = interpreatAddress(address);
			if(interpreatedAddress != null) {
				setValueForAddressField(interpreatedAddress);
				setLatitudeLongitude(address.geometry.location.lat, address.geometry.location.lng);
			} 	*/
			interpreatedAddress = interpreatAddress(address);
			if(interpreatedAddress != null) {
				setValueForAddressField(interpreatedAddress);
			}
			jQuery(visibleAddressList()).hide();
			pos = {
				lat: address.geometry.location.lat(),
				lng: address.geometry.location.lng()
			};
			setCordinates(pos.lat, pos.lng);

			// console.log(branchId);
			// console.log(pos.lat);
			// console.log(pos.lng);

			var objectData =
			{
				"city": "",
				"area": "",
				"zipCode": "",
				"ZipCode2": "",
				"latitude": pos.lat,
				"longitude": pos.lng,
				"minDeliveryAmount": "",
				"deliveryFee": "",
				"branchId": branchId
			};

			var objectDataString = JSON.stringify(objectData);
			jQuery.ajax({
				headers: {
					Accept: "application/json",
					"Content-Type": "application/json"
				},
				type: "POST",
				url: "/journeystates?companyId=${companyId}",
				dataType: 'json',
				data: objectDataString,
				success: function (data) {
					console.log('Success');
					console.log(data);
					
					var symbol = jQuery('.symbol-js').text();
					if(symbol == "€") {
						symbol = "€ ";
					}
					jQuery('#deliveryFee').val(symbol + data.deliveryFee + ".00");
					jQuery('#minDeliveryAmount').val(symbol + data.minDeliveryAmount + ".00");
					jQuery('.addressPolygonModalError').hide();
				},
				error: function (data) {
					console.log('error');
				}
			});
			

		});
	}
	function confirmLocationModal() {

		if(jQuery('#minDeliveryAmount').val().length) {
			var var_categoryId = jQuery('#var_categoryId').val();
			var var_productId = jQuery('#var_productId').val();
			var var_productCategoryId = jQuery('#var_productCategoryId').val();
			var dateVal = jQuery('#addressPolygonModal').attr('date-tab');
			jQuery('#addressPolygonModal').modal('hide');

			if(var_categoryId.length) {
				addItemCartNext(var_categoryId,var_productId,var_productCategoryId);
			}else {
				funOrderTypeTabs(jQuery('.menu-type-tabs > *[data-order-type="' + dateVal + '"]'));
				console.log('funOrderTypeTabs');
			}
			var varDeliveryFee = jQuery('#deliveryFee').val();
			var varMinDeliveryAmount = jQuery('#minDeliveryAmount').val();
			confirmLocationValue(varDeliveryFee, varMinDeliveryAmount);
		}else {
			jQuery('.addressPolygonModalError').show();
		}
	}

	// возвращает cookie с именем name, если есть, если нет, то undefined
	function getCookie(name) {
		var matches = document.cookie.match(new RegExp(
		"(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
		));
		return matches ? decodeURIComponent(matches[1]) : undefined;
	}

	jQuery(document).ready(function(){
		jQuery('#confirmLocationModal').click(function(){
			confirmLocationModal();
			return false
		});
	});

	function confirmLocationValue(varDeliveryFee, varMinDeliveryAmount){
		jQuery('html').addClass("delivery-charge-menu-active2");
		jQuery('.jsMinDeliveryAmount').text(varMinDeliveryAmount);
		jQuery('.delivery-charge-menu .value').text(varDeliveryFee);
	}

	
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
	
	function setCordinates(lat, lng) {
		jQuery("#latitude").val(lat);
		jQuery("#longitude").val(lng);
		setValueForSelector("coordinates", lat + "," + lng);
	}
	
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
				if(checkForType(addComponent.types, ['route', 'street', 'intersection', 'ward', 'park', 'colloquial_area'])) {
					addressComponents["street"] = addComponent.long_name;
				}
				if(checkForType(addComponent.types, ['neighborhood'])) {
					addressComponents["neighborhood"] = addComponent.long_name;
				}
				if(addressComponents["neighborhood"] == undefined) {
					addressComponents["neighborhood"] = addressComponents["street"];
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
			return addressComponents;
		}
	})()

	function setValueForAddressField(address) {

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
		if(address.neighborhood) {
			setValueForSelector("neighbourhood", address.neighborhood);	
		} else {
			setValueForSelector("neighbourhood", address.street);
		}
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
							jQuery("#modaladdress").val(data.results[0].formatted_address);
							setCordinates(results[0].geometry.location.lat(), results[0].geometry.location.lng());
							interpreatedAddress = interpreatAddress(data.results[0]);
							if(interpreatedAddress != null) {
								setValueForAddressField(interpreatedAddress);
							}
						}
					});
				});
			}
		}
	})();
</script>