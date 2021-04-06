var map, pos = undefined, jsonDefualtLocationParams = [];
var geocoder, interpreatedAddress;
var languageLocale = 'en_GB';
var languageCode = languageLocale.split("_")[0];
var region = 'GB';
var modalautocomplete;

var store_search_map_service, store_search_pin_my_location;
$('.modal-content').css('opacity', 0);
jQuery.ajax({
	type: "GET",
	url: 'https://live.ordertiger.com/api/v1/companies/192',
	success: function(response) {
		console.log('response');
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

				if(key == 'store_search_map_service') {
					store_search_map_service = deliveryZoneSettingParams[i].value;
				}
				if(key == 'store_search_pin_my_location') {
					store_search_pin_my_location = deliveryZoneSettingParams[i].value;
				}

			}

		}else {
			store_search_map_service = null;
			store_search_pin_my_location = null;
		}

		// for test
		// store_search_map_service = "zipcode2_no_geo";
		console.log('store_search_map_service');
		console.log(store_search_map_service);

		if(store_search_map_service == "zipcode2_no_geo") {
			$('#address').attr("placeholder", "Enter full postcode").attr('id', 'zipcode2_no_geo').attr('name', 'zipcode2_no_geo');
			$('#findStores').attr('id', 'zipcode2_no_geo_btn');
			zipcode2_no_geo_fun();
		}
		showAjaxStop();
	},
	error: function (error) {
		showAjaxStop();
	}
});

function showAjaxStop() {
	$('.modal-content').css('opacity', 1);
	// $('#findbranchbypostcodeform').css('opacity', 1);
	$('#address, #modaladdress').on('input', function(){
		if ($(this).val() != '') {
			myEfficientInputFn();
		} else {
			$(visibleAddressList()).hide();
		}
	});
	
	$('.my-location').on('click', function(){
		getMyGeoLocation();
	});

	$('.close.hideme').on('click', function(){
		$(this).parent().addClass("hidden");
	});
}

function zipcode2_no_geo_fun() {
	$('#zipcode2_no_geo_btn').click(function(){
		zipcode2_no_geo_Ajax($("#zipcode2_no_geo").val());
		return false
	});
	$("#zipcode2_no_geo").keydown(function(event){
	    if(event.keyCode == 13){
	        zipcode2_no_geo_Ajax($("#zipcode2_no_geo").val());
	        return false
	    }
	});
}

function zipcode2_no_geo_Ajax(value) {
	var dataZip = {
		"companyLocale" : 'en_GB',
		"postCode" : value
	}

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
					url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + value + '&components=GB:GB&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw',
					success: function(response) {
						console.log('response_google');
						console.log(response.status);
						if(response.status == "ZERO_RESULTS") {
							$('#errorInputDiv').html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>Postcode is invalid</div>");
						}
						if(response.status == "OK") {
							var results_lat = response.results[0].geometry.location.lat;
							var results_lng = response.results[0].geometry.location.lng;
							$('#latitude').val(results_lat);
							$('#longitude').val(results_lng);
							console.log(results_lat);
							console.log(results_lng);
							$('#findbranchbypostcodeform').submit();
						}
					}
				});
			}else {
				//error 
				$('#errorInputDiv').html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>Please enter full Postcode</div>");
			}
		}
	});
}

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
	address = $(visibleAddressInput()).val();
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
			$(visibleAddressList()).show().html("");
			predictions.forEach(function(prediction) {
				var tempHtml = "<div class='address-row'><div class='formated-address'>{formatedAddress}</div></div>";
				tempHtml = tempHtml.replace('{formatedAddress}', prediction.description);
				var addressRow = $(tempHtml);
				addressRow.on("click", function(e){

					if(store_search_map_service == null || store_search_map_service == "") {
						selectPlace($(this).data("place"));
					}
					if(store_search_map_service == 'autocomplete_only') {
						$('#findbranchbypostcodeform').submit();
					}

					if(store_search_pin_my_location == 'no') {
						 $('.my-location').hide();
					}


				});
				addressRow.data("place", prediction);
				$(visibleAddressList()).append(addressRow);
			});
			if (predictions.length !== 0) {
				if(typeof geocoder === 'undefined') {
					geocoder = new google.maps.Geocoder;
				}
				getPlaceFromPlaceId(predictions[0].place_id);
			}
		});
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
		return $('#addressPolygonModal').is(':visible');
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

	$("#modaladdress").val(place.description);
	$("#address").val(place.description);
	
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
		$(visibleAddressList()).hide();
		pos = {
			lat: address.geometry.location.lat(),
			lng: address.geometry.location.lng()
		};
		setCordinates(pos.lat, pos.lng);
		if(!referenceFromModal()) {
			loadAddressPolygonModal();
		} else {
			map.setCenter(pos);
		}
	});
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

$(".search-btn-home").click(function() {	
	if ($(visibleAddressInput()).val().trim() == '') {
		$(visibleAddressInput()).focus();
		return false;
	}
	loadAddressPolygonModal();
	return false;
});

function loadAddressPolygonModal() {
	$(visibleAddressList()).hide();
	$('#addressPolygonModal').modal('show');
	window.dispatchEvent(new Event('resize'));
	$("#mapSection").focus();
	if (typeof pos !== "undefined") {
		map.setCenter(pos);
		setCordinates(pos.lat, pos.lng);
		pos = undefined;
		$("#modaladdress").val($("#address").val());
	}

}

function setCordinates(lat, lng) {
	$("#latitude").val(lat);
	$("#longitude").val(lng);
	setValueForSelector("coordinates", lat + "," + lng);
}

function initMap() {
	var mapOptions = {
		zoom: 16,
		center: new google.maps.LatLng(52.5498783, 13.425209099999961),
	};
	jsonDefualtLocationParams["address"] = 'United Kingdom';
	map = new google.maps.Map(document.getElementById('mapSection'), mapOptions);
	if(typeof geocoder === 'undefined') {
		geocoder = new google.maps.Geocoder;
	}
	geocoder.geocode(jsonDefualtLocationParams, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			console.log(results[0].geometry.location);
			setCordinates(results[0].geometry.location.lat(), results[0].geometry.location.lng());
			interpreatedAddress = interpreatAddress(results[0]);
			if(interpreatedAddress != null) {
				setValueForAddressField(interpreatedAddress);
			}
		}
	});
	
	 $('<div/>').addClass('centerMarker').appendTo(map.getDiv())
	.click(function() {
		var that=$(this);
		if(!that.data('win')) {
			that.data('win',new google.maps.InfoWindow({content:'Select Location'}));
			that.data('win').bindTo('position',map,'center');
		}
		that.data('win').open(map);
	 });
	 
	 var myEfficientDragFn = debounce(function() {
		 jQuery.get("https://maps.googleapis.com/maps/api/geocode/json?language="+languageCode+"&latlng="+map.getCenter().lat()+","+map.getCenter().lng()+"&key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw", function(data, status){
			 console.log('data status '+data.status);
			if(data.status != 'OVER_QUERY_LIMIT' && data.status != 'ZERO_RESULTS') {
				console.log(data.results[0]);
				interpreatedAddress = interpreatAddress(data.results[0]);
				setCordinates(data.results[0].geometry.location.lat, data.results[0].geometry.location.lng);
				if(interpreatedAddress != null) {
					setValueForAddressField(interpreatedAddress);
				}
				$(visibleAddressInput()).val(data.results[0].formatted_address);
			} else {
				$(visibleAddressList()).hide();
			}
		});
	}, 350);
	google.maps.event.addListener(map, 'drag', myEfficientDragFn);
	google.maps.event.trigger(map, "resize");
	$(visibleAddressList()).hide();
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
						$("#modaladdress").val(data.results[0].formatted_address);
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


$(document).ready(function() {
	function googleCheck() {
		if(typeof(google) !== 'undefined') {
			console.log('No wait');
			// initMap();
		}else {
			setTimeout(function(){
				console.log('I wait');
				googleCheck()
			}, 500);
		}
	}
	googleCheck();
	$(document).delegate("#confirmLocation", "click", function() {
		$('#findbranchbypostcodeform').submit()
	});
});