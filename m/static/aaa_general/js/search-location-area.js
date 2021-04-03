var getAreaFromSelectedCity;
$(document).ready(function() {
	var getAllArea;
	var _cityAreas = {};
	var getAreaByCity = (function(){
		return function(cityId, callback, errorCallback){
			if(cityId == undefined) {
				callback(null);
			}
			if(_cityAreas[cityId]) {
				callback(_cityAreas[cityId]);
			} else {
				jQuery.ajax({
				    url : "/getAreas",
				    data : {cityId : cityId, companyId : $("#companyId").val()},
				    dataType : "json",
				    type : "GET",
				    success : function(data){
				    	_cityAreas[cityId] = data;
				    	callback(data);
				    }, 
				    error : errorCallback
				});
			}
		}
	})();

	if($("#cityarea" ).attr("type") != 'text') {		
		getAllArea = (function() {
			var cityID;
			return function(callback){
				cityID = $('#citylist').val();
				if(cityID != null) {
					getAreaByCity(cityID, function(){
						var selectCityArea = _cityAreas[cityID];
						if(selectCityArea) {
							var htmlForList = '';
							for(var i=0;i<selectCityArea.length;i++) {
								htmlForList += '<option data-area-id="'+selectCityArea[i].id+'"><a class="area-item" data-area-id="'+selectCityArea[i].id+'">'+selectCityArea[i].area+'</a></option>';
							}
							$('#cityarea').empty().append(htmlForList);
							if(callback) callback(selectCityArea[0]);			
						} else {
							$('#listOfAreas').hide().html("");
						}
					})	
				}				
			}
		})();
		$('#cityarea').change(function(){
			$("#areaID").val($(this).find(":selected").data("areaId"));
			$("#area").val(this.options[this.selectedIndex].text);
		});
		getAllArea(function(area){
			$("#areaID").val(area.id);	
			$("#area").val(area.area);
		});		
		getAreaFromSelectedCity = getAllArea;
	} else {
		$('#citylist').change(function(){
			$('#cityarea').val("");				
		})
		
		$('#cityarea').blur(function(){
			setTimeout(function(){
		   		 if($('.form-dd-menu-js').length){
			    	$('.form-dd-menu-js').hide();
			    }else {
			    	$('#listOfAreas').hide();
			    }
			}, 500);
		});
		$('#cityarea').focus(function(){
			if($('.form-dd-menu-js').length){

			}else {
				var cityID = $('#citylist').val(); 
				if (cityID != null && cityID != '' && cityID != undefined) {
					getAreaByCity(cityID, function(){
						$('#listOfAreas').show().html("");
						var selectCityArea = _cityAreas[cityID];
						if(selectCityArea) {
							var htmlForList = '<ul class="city-area-list">';
							for(var i=0;i<selectCityArea.length;i++) {
								htmlForList += '<li ><a class="area-item" data-area-id="'+selectCityArea[i].id+'">'+selectCityArea[i].area+'</a></li>';
							}
							htmlForList += '</ul>';
							$('#listOfAreas').append(htmlForList);
						} else {
							$('#listOfAreas').hide().html("");
						}
					})
				} else {
					$('#listOfAreas').hide().html("");
				}
			}	
		})

		var formDdTitleJs = $('.form-dd-title-js').text();
		$('#citylist').change(function(){
			if($('.form-dd-menu-js').length){
				$('.form-dd-title-js').text(formDdTitleJs);
				var cityID = $('#citylist').val(); 
				if (cityID != null && cityID != '' && cityID != undefined) {
					getAreaByCity(cityID, function(){
						$('#listOfAreas').show().html("");
						var selectCityArea = _cityAreas[cityID];
						if(selectCityArea) {
							var htmlForList = '<ul class="city-area-list">';
							for(var i=0;i<selectCityArea.length;i++) {
								htmlForList += '<li><a class="area-item" data-area-id="'+selectCityArea[i].id+'">'+selectCityArea[i].area+'</a></li>';
							}
							htmlForList += '</ul>';
							$('#listOfAreas').append(htmlForList);
						} else {
							$('#listOfAreas').hide().html("");
						}
					})
				} else {
					$('#listOfAreas').hide().html("");
				}
			}	
		});
		if($('.form-dd-menu-js').length){
			var cityID = $('#citylist').val(); 
			if (cityID != null && cityID != '' && cityID != undefined) {
				getAreaByCity(cityID, function(){
					$('#listOfAreas').show().html("");
					var selectCityArea = _cityAreas[cityID];
					if(selectCityArea) {
						var htmlForList = '<ul class="city-area-list">';
						for(var i=0;i<selectCityArea.length;i++) {
							htmlForList += '<li ><a class="area-item" data-area-id="'+selectCityArea[i].id+'">'+selectCityArea[i].area+'</a></li>';
						}
						htmlForList += '</ul>';
						$('#listOfAreas').append(htmlForList);
					} else {
						$('#listOfAreas').hide().html("");
					}
				})
			} else {
				$('#listOfAreas').hide().html("");
			}			
		}
		$("#listOfAreas").delegate(".city-area-list > li", "click" , function() {  
		    $('#cityarea').prop("value", $(this).find('a').html());
		    $('#areaID').prop("value", $(this).find('a').data("areaId"));

		    if($('.form-dd-menu-js').length){
		    	$('.form-dd-title-js').text($(this).find('a').html());
		    	$('.form-dd-menu-js').hide();
		    }else {
		    	$('#listOfAreas').hide();
		    }
		});	
		$('.form-dd-title-js').click(function(){
			$(".form-dd-menu-js").fadeToggle(100);
		})
		$('#cityinput').focus(function(){
			$("#listOfCities").show();
		})
		$("#listOfCities").delegate(".city-area-list.city-list > li", "click" , function() {  
		    $('#cityinput').prop("value", $(this).find('a').html());
		    $('#citylist').prop("value", $(this).data("cityId"));
			$('#cityarea').val('');
		    $("#listOfCities").hide();
		});	
		var filterAreas = (function(){
			return function(cityID, area){
				var cityID = $('#citylist').val();
				var selectedCityAreas = _cityAreas[parseInt(cityID)];
				var filteredArea = [];
				for (var i=0; i<selectedCityAreas.length;i++) {
					if(selectedCityAreas[i].area.search(new RegExp(area, "i")) > -1) {
						filteredArea.push(selectedCityAreas[i]);
					}
				} 
				return filteredArea;
			}
		})();
		$('#cityinput').keyup(function() {
			var citySearchText = $(this).val();
			$('#cityarea').val('');
			$("#listOfCities ul li").each(function(){
				if($(this).find("a").text().toLowerCase().indexOf(citySearchText.toLowerCase()) == -1) {
					$(this).hide();
				} else {
					$(this).show();
				}
			})
		});
		
		$('#cityarea').keyup(function() {
			var cityID = $('#citylist').val();
			var selectCityArea = filterAreas(cityID, $('#cityarea').val());
			$('#listOfAreas').show().html("");
			if(selectCityArea) {
				var htmlForList = '<ul class="city-area-list">';
				for(var i=0; i<selectCityArea.length; i++) {
					htmlForList += '<li ><a class="area-item" data-area-id="'+selectCityArea[i].id+'">'+selectCityArea[i].area+'</a></li>';	
				}
				htmlForList += '</ul>';	
				$('#listOfAreas').append(htmlForList);	
			} else {
				$('#listOfAreas').hide().html("");
			}
		});
		
		if($("#areaID").val().length == 0) {
			$('#cityarea').val("");
		} 
	}	
	
});