$(document).ready(function(){  
    jQuery(window).scroll(function(){
		var window_top = jQuery(window).scrollTop() + 100; // the "12" should equal the margin-top value for nav.stick
		var div_top = $('#nav-anchor').offset().top;
		if (window_top > div_top) {
			$('#sidebar').addClass('stick');
		} else {
			$('#sidebar').removeClass('stick');
		}
		var categoryheight = 0;
		if($('#sidebar').offset().top + $('#sidebar').height() >= $('#footer').offset().top - 10) {
			categoryheight = $('#footer').offset().top - jQuery(window).scrollTop() - 110;
		} else {
			categoryheight = window.innerHeight - 120;
		}
		
		$('#sidebar').css('height', categoryheight+'px');
		
	});
		
	jQuery(window).scroll(function(){
		var window_top = jQuery(window).scrollTop() + 100; // the "12" should equal the margin-top value for nav.stick
		var div_top1 = $('#nav-anchor1').offset().top;
		if (window_top > div_top1) {
			$('#info_inner').addClass('stick1');
			$('#cartdivposition').removeClass('my-position');
		} else {
			$('#info_inner').removeClass('stick1');
			$('#cartdivposition').addClass('my-position');
		}
		
		var cartheight = 0;
		if($('#info_inner').offset().top + $('#info_inner').height() >= $('#footer').offset().top - 10) {
			cartheight = $('#footer').offset().top - jQuery(window).scrollTop() - 110;
			$('#info_inner').css('height', cartheight+'px');
		} else {
			//cartheight = window.innerHeight - 120;
			$('#info_inner').css('height', '400px');
		}
		
		
    });      
});

$(document).ready(function () {
	var orderType = $('#ordertype').val();
	if(orderType == 'DELIVERY') {
	    $('#addressbookdiv').show(); 
    } else {
        $('#addressbookdiv').hide(); 
    }
	
	$('#categoryselect').change( function () {
        var targetPosition = $($(this).val()).offset().top;
        $('html,body').animate({ scrollTop: targetPosition}, 'slow');
    });
	
	//Tooltip
	$('[rel="tooltip"]').tooltip({trigger:"hover"});
	$('[data-toggle="tooltip"]').tooltip();
	
	//Ball animation
	$(".ball").mouseenter(function(){
		$(this).closest(".ball-step").parent().find(".arrow").css("opacity", "1");
		$(this).closest(".ball-step").find(".shadow_img").css("opacity", "0.70");
	});
	$(".ball").mouseleave(function(){
		$(this).closest(".ball-step").parent().find(".arrow").css("opacity", "0");
		$(this).closest(".ball-step").find(".shadow_img").css("opacity", "1");
	});
	
	//show and hide the my order and menu list
    $(".restaurant-menu-list-dropdown-toggle").click(function(){    	
        $(".restaurant-menu-list").toggle();
    });
    $(".restaurant-menu-myorder-dropdown-toggle").click(function(){    	
        $(".myorderForm").toggle();
    });
    
    //opening times popover
    $('[data-toggle="popover"]').popover({
        html : true, 
        content: function() {
        	return $("#"+$(this).data("contentId")).html();
        },
        trigger: "hover"	// for hover effect
    });
   
    // menu page : sidebars scrolling between header & footer
    jQuery(window).on("scroll", function (){
		var minHeight = $("#footer").offset().top - $(".myorderForm").height() - 70;
    	myOrderAndMenuListScroll(300, minHeight);
    });	
    
    $('#addMenuItemModal').on('hidden.bs.modal', function () {
    	$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});

	$('#orderDetailModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	
	$('#addressBookModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	$('#loginModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	
	$('#forgotloginModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	
	$('#registerModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	
	$('#addressModal').on('hidden.bs.modal', function () {
		$(this).removeData('bs.modal').find(".modal-content").html('<h2>Loading...</h2>');
	});
	
	// This just makes all bootstrap native .modals jive together
	$('.modal').on("hidden.bs.modal", function (e) {
	    if($('.modal:visible').length)
	    {
	        $('.modal-backdrop').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) - 10);
	        $('body').addClass('modal-open');
	    }
	}).on("show.bs.modal", function (e) {
	    if($('.modal:visible').length)
	    {
	        $('.modal-backdrop.in').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) + 10);
	        $(this).css('z-index', parseInt($('.modal-backdrop.in').first().css('z-index')) + 10);
	    }
	});
	
	
	//sticky header
	var window = jQuery(window);
    var fixedElement = $("nav");
    var elementOffset = fixedElement.offset().top;
	window.scroll(function() {
		if (elementOffset < window.scrollTop()) {
			fixedElement.addClass("fixed");
		} else {
			fixedElement.removeClass("fixed");
		}
	});
});

//myorder and menu list scrolling effect 
function myOrderAndMenuListScroll(top,left) {
	 if ((top <= jQuery(window).scrollTop()) && (left >= jQuery(window).scrollTop()) ) {
         // if so, add the fixed class
         $(".myorderForm-scrolling").addClass("fixed-myorderForm");
         $(".restaurant-menu-list").addClass("fixed-restaurant-menu-list");
         $(".restaurant-menu-card").addClass("fixed-restaurant-menu-card")
     } else {
         // otherwise remove it
         $(".myorderForm-scrolling").removeClass("fixed-myorderForm");
         $(".restaurant-menu-list").removeClass("fixed-restaurant-menu-list");
         $(".restaurant-menu-card").removeClass("fixed-restaurant-menu-card")
     }
 }
function changeOrderType(orderType) {
	if(orderType == 'DELIVERY') {
		$('#addressbookdiv').show(); 
    } else {
    	$('#addressbookdiv').hide(); 
    }
	
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