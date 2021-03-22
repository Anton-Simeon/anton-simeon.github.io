<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
	function cartTopNew() {
		if($('.col-basket').length) {
			var colBasket = $('.shooping-panel .cart-bottom .value-js').text();
			if(colBasket == 0) {
				colBasket = '£0';
			}
			$('.col-basket span').text(colBasket);
	    	if($('.loader-style').length) {
				setTimeout(function() {
					loaderHide();
				}, 500);
			}
		}

		if($('.cart-header').length) {
			var colBasket = $('.shooping-panel .cart-top > *').length;
			if(colBasket == 0) {
				colBasket = '0';
			}
			$('.cart-header span').text(colBasket);
		}
	}



	function driverTip(driverTipVal) {
		console.log('driverTip1');
		if(driverTipVal != undefined) {

			var orderType =$('.menu-type-tabs .active').attr('data-order-type');
			if(orderType == "DELIVERY" || orderType == "CATERING") {
				$('.driver-tip-js').addClass('driver-tip-active');
			}

			var symbol = $('.symbol-js').text();
			$('.driver-tip-symbol').text(symbol);
			var valProductPrice = driverTipVal;
			var valProductPrice10 = valProductPrice * 0.1;
			var valProductPrice15 = valProductPrice * 0.15;
			var valProductPrice20 = valProductPrice * 0.2;
			var valProductPrice25 = valProductPrice * 0.25;

			$('.driver-tip-value-js10').text(valProductPrice10.toFixed(2));
			$('.driver-tip-value-js15').text(valProductPrice15.toFixed(2));
			$('.driver-tip-value-js20').text(valProductPrice20.toFixed(2));
			$('.driver-tip-value-js25').text(valProductPrice25.toFixed(2));

			var tipVal = $('#menu-cart-content .driver-tip-link-active .driver-tip-value-js').text();
			if(tipVal == "") {
				tipVal = $('#menu-cart-content .driver-tip-link-active .driver-tip-value-jsEdit').text();
			}

			tipVal = +tipVal;
			driverTipVal = +driverTipVal;
			$('.driverTip-js').val(tipVal);

			var productPriceNew = driverTipVal + tipVal;

		console.log(driverTipVal);
		console.log(tipVal);
		console.log(productPriceNew);

			productPriceNew = productPriceNew.toFixed(2);


			$('.value-js').text(symbol + productPriceNew);
			$('.value-js-mobile').text(symbol + productPriceNew);

		}else {
			$('.driver-tip-js').removeClass('driver-tip-active');
		}
	}

	function updateShoppingCart() {
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxupdatecartresponsive',
	    	data: {
				menuId: ${menu.id}, 
				companyId: ${companyId}, 
				clearcartflag: 'false'
			},
			headers: {
				Accept: "application/json",
			},
	    	success: function(response) {
	    		console.log("updateShoppingCart");
	    		console.log(response);

	    		
	    		$("#desktop_cart").html(response.contentShoppingCart);
				$("#mobile_cart").html(response.contentShoppingCartMob);

	    		if( $('.driver-tip-js').length ) {
					driverTip($(response.contentShoppingCart).find('#product-price-js').val());
				}


				var mobileCartValue = $("#mobile_cart .cart-bottom .value-js").text();
				var mobileCartCol = $("#mobile_cart .cart-top > *").length;	
				$('.footer-bottom1.mobile-show .col-mobile-basket-js').text(mobileCartCol);
				$('.footer-bottom1.mobile-show .price').text(mobileCartValue);
				if(mobileCartValue) {
					$('.footer-bottom1.mobile-show').show();
				}else {
					$('.footer-bottom1.mobile-show').hide();
				}

				cartTopNew();
			},
			error: function (jqXHR, exception) {
			        var msg = '';
			        if (jqXHR.status === 0) {
			            msg = 'Not connect.\n Verify Network.';
			        } else if (jqXHR.status == 404) {
			            msg = 'Requested page not found. [404]';
			        } else if (jqXHR.status == 500) {
			            msg = 'Internal Server Error [500].';
			        } else if (exception === 'parsererror') {
			            msg = 'Requested JSON parse failed.';
			        } else if (exception === 'timeout') {
			            msg = 'Time out error.';
			        } else if (exception === 'abort') {
			            msg = 'Ajax request aborted.';
			        } else {
			            msg = 'Uncaught Error.\n' + jqXHR.responseText;
			        }
			        console.log('erorrName: ' + msg);
			    },
	    	dataType: 'json'
	    });
	}

	
	function addItem() {
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxadditem',
	    	data: $('#submenuform').serialize(),
	    	success: function(response) {
	    		if (response.status == 'failure') {
	    			$("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
	    			$('#addMenuItemModal').scrollTop(0);
		       	} else {
	    			$('#addMenuItemModal').modal('toggle');
	    		    updateShoppingCart();
	    		}
	    	},
	    	dataType: 'json'
	    });
		return false;
	};
	
	function formsubmit() {
		$("#submenuform").submit();
	}
	
	function nestedOptionGroupRadio(optionGroupId, optionId, element) {
		jQuery.ajax({
			type: "POST",
			url: "/ajaxnestedoptiongroup",
			data: ({companyId: ${companyId}, optionId : optionId}),
			success: function(responseText) {
			if (element.checked) {
					$('#nested_'+ optionGroupId).html(responseText);   	
				} else {
					$('#nested_'+ optionGroupId).html("");
				}
			},
			dataType: "html"
		});	
	}

	function nestedOptionGroupSelectBox(optionGroupId, element) {
		jQuery.ajax({
			type: "POST",
			url: "/ajaxnestedoptiongroup",
			data: ({companyId: ${companyId}, optionId : element.value}),
			success: function(responseText) {
				        if (element.value!="") {
				        	$('#nested_'+ optionGroupId).html(responseText);  	
				        } else {
				        	$('#nested_'+ optionGroupId).html("");
				        }
					},
			dataType: "html"
		});	
	}

	function nestedOptionGroupCheckBox(optionGroupId, optionId, element) {
		jQuery.ajax({
			type: "POST",
			url: "/ajaxnestedoptiongroup",
			data: ({companyId: ${companyId}, optionId : optionId}),
			success: function(responseText) {
				        if (element.checked) {
				        	$('#nested_'+ optionGroupId + "_" + optionId).html(responseText);
				        } else {
				        	$('#nested_'+ optionGroupId + "_" + optionId).html("");
				        }
					},
			dataType: "html"
		});	
	}

	function nestedOptionGroupRadioMobile(optionGroupId, optionId, element) {
		jQuery.ajax({
			type: "POST",
			url: "/ajaxnestedoptiongroupmobile",
			data: ({companyId: ${companyId}, optionId : optionId}),
			success: function(responseText) {
				        if (element.checked) {
				        	$('#nested_'+ optionGroupId).html(responseText);
				        } else {
				        	$('#nested_'+ optionGroupId).html("");
				        }
					},
			dataType: "html"
		});	
	}

	function nestedOptionGroupCheckBoxMobile(optionGroupId, optionId, element) {
		jQuery.ajax({
			type: "POST",
			url: "/ajaxnestedoptiongroupmobile",
			data: ({companyId: ${companyId}, optionId : optionId}),
			success: function(responseText) {
				        if (element.checked) {
				        	$('#nested_'+ optionGroupId + "_" + optionId).html(responseText);
				        } else {
				        	$('#nested_'+ optionGroupId + "_" + optionId).html("");
				        }
					},
			dataType: "html"
		});	
	}
</script>