function incrementdecrementShoppingCart(menuId, categoryId, orderItemId, decremetOrIncrement) {
	jQuery.ajax({
    	type: "POST",
    	url: '/ajaxincrementdecrementshoppingcart',
    	data: {
    			menuId: menuId,
    			categoryId: categoryId,
    			orderItemId: orderItemId,
    			decremetOrIncrement: decremetOrIncrement
    		  },
    	success: function(response) {
   					$(".shoppingcart_table").html(response.contentShoppingCart);
    			},
    	dataType: 'json'
    });
}

function clearShoppingCart() {
	jQuery.ajax({
    	type: "POST",
    	url: '/ajaxclearshoppingcart',
    	success: function(response) {
   					$(".shoppingcart_table").html(response.contentShoppingCart);
    			},
    	dataType: 'json'
    });
}

function changeOrderType(orderType) {
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdatepaymentmethods",
		data: ({orderType:orderType}),
		success: function(responseText){
			$('#paymentmethod').html(responseText);
		},
		dataType: "html"
	});	
	
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdateordertime",
		data: ({orderType:orderType}),
		success: function(responseText){
			$('#ordertime').html(responseText);
		},
		dataType: "html"
	});		
}

function hide(id) {
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'none';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'none';
		}
		else { // IE 4
			document.all.id.style.display = 'none';
		}
	}
}

function show(id) {
	if (document.getElementById) { // DOM3 = IE5, NS6
		document.getElementById(id).style.display = 'block';
	}
	else {
		if (document.layers) { // Netscape 4
			document.id.display = 'block';
		}
		else { // IE 4
			document.all.id.style.display = 'block';
		}
	}
}

function MM_jumpMenu(target, selObj, restore) {
    eval(target+".location='"+selObj.options[selObj.selectedIndex].value+"'");
    if (restore) selObj.selectedIndex = 0;
}

function nestedOptionGroupRadio(optionGroupId, optionId, element) {
		
	jQuery.ajax({
		type: "POST",
		url: "/ajaxnestedoptiongroup",
		data: ({optionId : optionId}),
		success: function(responseText) {
			        if (element.checked) {
			        	$('#nested_'+ optionGroupId).html(responseText);
						$(".fancybox-inner").css("height", $('#submenu-submenu').outerHeight(true));     	
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
		data: ({optionId : optionId}),
		success: function(responseText) {
			        if (element.checked) {
			        	$('#nested_'+ optionGroupId + "_" + optionId).html(responseText);
			        	$(".fancybox-inner").css("height", $('#submenu-submenu').outerHeight(true)); 
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
		data: ({optionId : optionId}),
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
		data: ({optionId : optionId}),
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

function populateNestedDiv() {
	var values = {};
	$.each($('#submenuform').serializeArray(), function(i, field) {
	    values[field.name] = field.value;
	    if (isNumber(field.name)) {
	    	
	    }
	});	
}

function isNumber(n) {
	 return !isNaN(parseFloat(n)) && isFinite(n);
}

$('.accordion').accordion({
    defaultOpen: 'section1',
    cookieName: 'accordion_nav',
    speed: 100
});