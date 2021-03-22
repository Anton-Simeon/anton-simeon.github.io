<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	var map, pos, center;
	var jsonDefualtLocationParams = {};
	var selectedCity = '${city}';
	var selectedArea = '${area}';
	var paramLat = '${latitude}';//13.758691 100.499460
	var paramLng = '${longitude}';
	var companyCounty = '${company.country.country}';
	if (selectedCity != '') {
		if (selectedArea != '') {
			jsonDefualtLocationParams["address"] = selectedArea;
		} else {
			jsonDefualtLocationParams = {
				componentRestrictions : {
					locality : selectedCity,
				}
			};
		} 
	} else if (paramLat != '' &&  paramLng != '') {
		var latlng = {lat: parseFloat(paramLat), lng: parseFloat(paramLng)};
		jsonDefualtLocationParams['location'] = latlng;
	}
	var languageLocale = '${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}';
	var languageCode = languageLocale.split("_")[0];
	var region = '${company.companyLocale.country}';
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
			return addressComponents;
		}
	})()
	
	function setLatitudeLongitude(lat, lng) {
		if(typeof lat === "function") {
			jQuery("#coordinates").val(lat() + "," + lng());
			jQuery("#latitude").val(lat());
			jQuery("#longitude").val(lng());
		} else {
			jQuery("#latitude").val(lat);
			jQuery("#longitude").val(lng);
			jQuery("#coordinates").val(lat + "," + lng);
		}
	}
	
	var interpreatedAddress = null;
	function selectAddress() {
		var address = jQuery(this).data("address");
		jQuery("#mapaddress").val(address.formatted_address);
		interpreatedAddress = interpreatAddress(address);
		if(interpreatedAddress != null) {
			setValueForAddressField(interpreatedAddress);
			setLatitudeLongitude(address.geometry.location.lat, address.geometry.location.lng);
		}
		pos = {
			lat: address.geometry.location.lat,
			lng: address.geometry.location.lng
		};
		map.setCenter(pos);		
		jQuery('.address-lists').hide();
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
				setLatitudeLongitude(address.geometry.location.lat, address.geometry.location.lng);
			}
			pos = {
					lat: address.geometry.location.lat(),
					lng: address.geometry.location.lng()
				};
			map.setCenter(pos);		
			jQuery('.address-lists').hide();
		});
	}
	
	function setValueForAddressField(address) {
		setValueForSelector("postalCode", address.postcode);
		setValueForSelector("buildingName", address.houseNo);
		setValueForSelector("number", address.number);
		setValueForSelector("homeNo", address.houseNo);
		setValueForSelector("officeNo", address.houseNo);
		setValueForSelector("officeBuildingName", address.appartNo);
		setValueForSelector("street", address.street);
		setValueForSelector("province", address.province);
		setValueForSelector("country", address.country);
		setValueForSelector("apartmentNo.", address.appartNo);
		setValueForSelector("apartmentBuildingName", address.houseNo);
		setValueForSelector("additionalDirections", address.area);
		setValueForSelector("subDistrict", address.subDistrict);
		setValueForSelector("district", address.district);
	}

	var buildAutoFill = (function(){
		return function(addresses){		
			if(addresses.length == 0) return;
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
	
	var setValueForSelector = (function(){
		return function(selector, value){
			if(document.getElementById(selector) != null && value) {
				document.getElementById(selector).value = value;
			} else if (document.getElementById(selector) != null) {
				document.getElementById(selector).value = '';
			}
		}
	})();




	jQuery('#btnmapaddress').on('click',function(e){
		var mapAddress = jQuery('#mapaddress').val();
		if(mapAddress.trim().length > 0) {
			jQuery('#map-section').hide();
			jQuery('#mapError').hide();
			if(jQuery('#addressLine1').length > 0) {
				jQuery('#addressLine1').val(mapAddress);	
			} else {
				if(interpreatedAddress != null) {
					setValueForAddressField(interpreatedAddress);
				}
			}
			jQuery('#formSection').show();
		} else {
			jQuery('#mapError').show();
		}
	});
	
	jQuery('#selectAddress').on('click',function(e){
		jQuery('#map-section').show();
		jQuery('#formSection').hide();
	});
	
	var getMyGeoLocation = (function() {
		return function(){
			if (navigator.geolocation && location.protocol === 'https:') {
				navigator.geolocation.getCurrentPosition(function(position) {
					pos = {
						lat: position.coords.latitude,
						lng: position.coords.longitude
					};
					setLatitudeLongitude(pos.lat, pos.lng);
					map.setCenter(pos);
					center = new google.maps.LatLng(pos.lat,pos.lng);
					jQuery.get("https://maps.googleapis.com/maps/api/geocode/json?language="+languageCode+"&latlng="+map.getCenter().lat()+","+map.getCenter().lng()+"&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw", function(data, status){
					 	if(data.status != 'OVER_QUERY_LIMIT') {
							interpreatedAddress = interpreatAddress(data.results[0]);
							setValueForAddressField(interpreatedAddress);
						}
					});
				});
			}
		}
	})();
	
	function initMap() {		 
		var mapOptions = {
			zoom: 12,
			center: new google.maps.LatLng(52.5498783, 13.425209099999961),
		};
		map = new google.maps.Map(document.getElementById('mapSection'), mapOptions);
		var geocoder = new google.maps.Geocoder();
		geocoder.geocode(jsonDefualtLocationParams, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				map.setCenter(results[0].geometry.location);
				interpreatedAddress = interpreatAddress(results[0]);
				if(interpreatedAddress != null) {
					setValueForAddressField(interpreatedAddress);
					setLatitudeLongitude(results[0].geometry.location.lat, results[0].geometry.location.lng);
				}
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
			 jQuery("#formSection").removeClass("hidden");
			 jQuery.get("https://maps.googleapis.com/maps/api/geocode/json?language="+languageCode+"&latlng="+map.getCenter().lat()+","+map.getCenter().lng()+"&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw", function(data, status){
				 console.log('data status '+data.status);
				if(data.status != 'OVER_QUERY_LIMIT') {
					interpreatedAddress = interpreatAddress(data.results[0]);
					if(interpreatedAddress != null) {
						setValueForAddressField(interpreatedAddress);
						setLatitudeLongitude(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng);
					}
				} else {
					jQuery(".address-lists").hide();
				}
			});
		}, 350);
		google.maps.event.addListener(map, 'drag', myEfficientDragFn)
		jQuery(".address-lists").hide();
	}

	jQuery(document).ready(function(){
		google.maps.event.addDomListener(window, 'load', initMap);		
	});
</script>
<script type="text/javascript">
	jQuery(document).ready(function(){
		initMap();

		jQuery('.my-location').on('click', function(){
			jQuery("#formSection").removeClass("hidden");
			getMyGeoLocation();
		});

		jQuery('#mapaddress').on('input', function(){
			if (jQuery(this).val() != '') {
				jQuery("#formSection").removeClass("hidden");
				if (!jQuery("#btnmapaddress").hasClass("map-btn-active")) {
					jQuery("#btnmapaddress").addClass("map-btn-active");
				}
			} else {
				jQuery("#btnmapaddress").removeClass("map-btn-active");
				jQuery(".address-lists").hide();
			}
			myEfficientInputFn();
		});
	})
</script>