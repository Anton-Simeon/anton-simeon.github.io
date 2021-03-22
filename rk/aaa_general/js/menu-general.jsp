<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
	function cartTop() {
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
	function loaderShow() {
		$('.loader-style').show();
	}
	function loaderHide() {
		$('.loader-style').hide();
	}
	$(document).ready(function(){
		cartTop();
	});


	function driverTip(driverTipVal) {
		console.log('driverTip2');
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


	function incrementdecrementShoppingCart(menuId, categoryId, orderItemId, decremetOrIncrement) {
		jQuery.ajax({
			type: "POST",
		   	url: '/ajaxincdeccartresponsive',
		   	data: {
				menuId: menuId,
				categoryId: categoryId,
				orderItemId: orderItemId,
				decremetOrIncrement: decremetOrIncrement,
				clearcartflag: 'false',
    				companyId: ${companyId}
		  	},
		    success: function(response) {

				console.log("incrementdecrementShoppingCart");
				console.log(response);

		    	
		   	 	$("#desktop_cart").html(response.contentCart);
		    	$("#mobile_cart").html(response.contentCartMob);

				if( $('.driver-tip-js').length ) {
					driverTip($(response.contentCart).find('#product-price-js').val());
				}
				
		    	var mobileCartValue = $("#mobile_cart .cart-bottom .value-js").text();
				var mobileCartCol = $("#mobile_cart .cart-top > *").length;	
				$('.footer-bottom1.mobile-show .col-mobile-basket-js').text(mobileCartCol);
				$('.footer-bottom1.mobile-show .price').text(mobileCartValue);
				if(mobileCartValue) {
					$('.footer-bottom1.mobile-show').show();
				}else {
					$('.footer-bottom1.mobile-show').hide();
					$('#myCartModal').hide();
				}

		    	cartTop();
		   	},
		    dataType: 'json'
		});
	}

	function clearShoppingCart() {
		jQuery.ajax({
			type: "POST",
		    url: '/ajaxclearshoppingcart',
		    data: {
    			companyId: ${companyId}
    		  },
		    success: function(response) {
		   		$(".shoppingcart_table").html(response.contentShoppingCart);
		   		cartTop();
		    },
		    dataType: 'json'
		});
	}

	function addItemCartNext(categoryId,productId,productCategoryId) {
		if($('.loader-style').length) {
			loaderShow();
		}
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxcheckoptionadditem',
	    	data : {
			categoryId : categoryId,
			productId : productId,
			productquantity : 1, 
   			companyId: ${companyId}
		},
	    	success: function(response) {
	    		if (response.status == 'failure') {
	    			$('#addMenuItemModal').removeData('bs.modal').find(".modal-header").html('<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>');
	    			$('#addMenuItemModal').removeData('bs.modal').find(".modal-body").html('<div class=\"alert alert-dismissible alert-danger\"><strong>'+response.errorMessage+'</strong></div>');
					$('#addMenuItemModal').removeData('bs.modal').find(".modal-footer").html('');


	    			$('#addMenuItemModal').modal('show');
	    		} else {
	    			// updateItemShoppingCart();
	    			$('#addMenuItemModal').modal('show').find('.modal-content').load('/ajaxadditem?companyId='+${companyId}+'&categoryId='+categoryId+'&productCategoryId='+productCategoryId+'&productId='+productId, function(responseText, textStatus, XMLHttpRequest) {
							console.log('XMLHttpRequest.responseText2');
							// console.log(XMLHttpRequest.responseText);
							$('#addMenuItemModal').removeClass('spinner-active');
					});
	    		}
	    		cartTop();
	    	},
	    	dataType: 'json'
	    });
	}
	
	function addItemCart(categoryId,productId,productCategoryId) {

		
		var ifModalOption = "${journeyState == null and company.deliveryZoneType == 'CITYPOLYGON'}";
		var valOrderType = $('.menu-type-tabs .active').attr('data-order-type');
		var minDeliveryAmountVal = 0;
		if($('#minDeliveryAmount').length) {
			minDeliveryAmountVal = $('#minDeliveryAmount').val().length;
		}

		if( (minDeliveryAmountVal == 0) && ifModalOption && (valOrderType == "DELIVERY" || valOrderType == "CATERING") ){
			if($('#addressPolygonModal').length) {

				$('#var_categoryId').val(categoryId);
				$('#var_productId').val(productId);
				$('#var_productCategoryId').val(productCategoryId);

				$('#addressPolygonModal').modal('show');
				$('#addressPolygonModal').attr('date-tab', valOrderType);
			}else {
				addItemCartNext(categoryId,productId,productCategoryId);
			}
			return false
		}
		addItemCartNext(categoryId,productId,productCategoryId);



		return false;

	};
	
	function updateItemShoppingCart() {
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxupdatecartresponsive',
			headers: {
				"cache-control": "no-cache"
			},	    	
	    	data: {
    			menuId: ${menu.id}, 
    			companyId: ${companyId}, 
    			clearcartflag: 'false'
	    	},
	    	success: function(response) {
	    		$("#menu-cart-content").html(response.contentShoppingCart);			
				cartTop();
	    	},
	    	done:function() {
	    		setTimeout(function() {
	    			cartTop();
			}, 200);
	    	},
	    	dataType: 'json'
	    });
	}
</script>
<script type="text/javascript">

	var city = "${branch.city}";	
	var citypolygon = "${citypolygon}";
	var deliveryZoneType = "${company.deliveryZoneType}";

	$(document).ready(function() {
        
        $('.mainWrapp').on('click', '#orderBtn', function (e){
            e.preventDefault();
            var $this = $(this);
            $('#myCartModal').show();
        });

        $('.mainWrapp').on('click', '.closeCartModal', function (e){
        	e.preventDefault();
            $(this).parents('.panel-fullscreen').hide();
        });

        $('.custom-page-header a').click(function() {

            $('.custom-page-header .active').removeClass('active');
            $('.info-tab').hide();
            $('.menu-tab').hide();
            $('.review-tab').hide();
            $(this).parent().addClass('active');
            $($(this).data('target')).show();

            // if(deliveryZoneType == citypolygon) {
	            if($('#map').length) {
	            	if($(this).data('target') === '.info-tab') {
	            		initMap(city);
		            }
	            }
			// }
        });

        $('#info-modal').on('shown.bs.modal', function () {
        	if(city.length) {
            	initMap(city);
        	}
        });


    	function scrollSidebar() {

	        var windowScroll = $(window).scrollTop();
	        var windowHeight = $(window).outerHeight();

	        var footerHeight;
	        if( $('.mainWrapp + .footer').length ) {
	        	if($('.mainWrapp + .footer').css('margin-top') == "0px") {
	        		footerHeight = 100;
	        	}else {
	        		footerHeight = $('#footer').outerHeight();
	        	}
	        }else {
	        	footerHeight = $('#footer').outerHeight();
	        }
	        


	        var cartHeight = windowHeight - $('#menu-cart-content').outerHeight();

	        var mainWrapHeight = $('.mainWrapp').outerHeight() - windowHeight - footerHeight + cartHeight - $('.header').outerHeight();
	        var positionTop = $('.mainWrapp').outerHeight() - windowHeight - footerHeight + cartHeight;

	        // if(mainWrapHeight < windowScroll) {
	        // 	$('.cart-wrap-sidebar').css({
	        // 		'top': positionTop,
	        // 		'position': 'absolute'
	        // 	});
	        // }else {
	        // 	$('.cart-wrap-sidebar').css({
	        // 		'top': $('.header').outerHeight() + 10,
	        // 		'position': 'fixed'
	        // 	});
	        // }
        }
    	
        $(window).scroll(function(){
        	scrollSidebar();
	    });
	    scrollSidebar();

        setInterval(function() {
		    var outerHeightSidebar = $('.shooping-panel').outerHeight() + 200;
		    $('.menu-tab').css('min-height', outerHeightSidebar);
		}, 300);
        
        $("body").tooltip({
		    selector: '[data-toggle="tooltip"]'
		});
        
        var showChar = 150;
	    	var ellipsestext = "...";
	    	var moretext = "more";
	    	var lesstext = "less";
	    	$('.more').each(function() {
	    		var content = $(this).html();
	
	    		if(content.length > showChar) {
	
	    			var c = content.substr(0, showChar);
	    			var h = content.substr(showChar-1, content.length - showChar);
	
	    			var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
	
	    			$(this).html(html);
	    		}
	
	    	});

	    	$(".morelink").click(function(){
	    		if($(this).hasClass("less")) {
	    			$(this).removeClass("less");
	    			$(this).html(moretext);
	    		} else {
	    			$(this).addClass("less");
	    			$(this).html(lesstext);
	    		}
	    		$(this).parent().prev().toggle();
	    		$(this).prev().toggle();
	    		return false;
	    	});
	});
</script>