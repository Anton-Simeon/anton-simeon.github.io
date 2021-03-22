<%@ page language="java" pageEncoding="UTF-8" %>
<script type="text/javascript">
	// $.fn.isOnScreen = function(){
	//     var win = jQuery(window);
	    
	//     var viewport = {
	//         top : win.scrollTop(),
	//         left : win.scrollLeft()
	//     };
	//     viewport.right = viewport.left + win.width();
	//     viewport.bottom = viewport.top + win.height();
	    
	//     var bounds = this.offset();
	//     bounds.right = bounds.left + this.outerWidth();
	//     bounds.bottom = bounds.top + this.outerHeight();
	    
	//     return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
	// };

	// var timeout;
	// var lastScrollTop = 0;
	// var oldLink = "";
	// jQuery(window).scroll(function() {
	// 	var st = jQuery(this).scrollTop();
	//    	if (st > lastScrollTop && jQuery('#load-restaurant-link').length > 0){

	//     	if (jQuery('#load-restaurant-link').isOnScreen() == true) {


	//     		clearTimeout(timeout);  
	// 	    	timeout = setTimeout(function() {

	// 	    		if (oldLink != document.getElementById("nextURL").value) {
	// 	    			oldLink = document.getElementById("nextURL").value;
	// 		    		var loadResutsValue = document.getElementById("nextURL").value;


	// 		    		console.log(loadResuts);
	// 		    		console.log(loadResutsValue);
	// 		    		loadResuts(loadResutsValue);
	// 	    		}
	// 		   	}, 50);
	//     	}
	//    } else {
	//    }
	//    lastScrollTop = st;
	// });

	// jQuery(document).ready(function() {
	// 	var loading = jQuery("#loadingDiv");
 //        jQuery(document).ajaxStart(function () {
 //            loading.show();
 //        });

 //        jQuery(document).ajaxStop(function () {
 //            loading.hide();
 //        });
 //    });












	// function loadResuts(pageURL){



	// 	// var pageURLfilter = "http://www.zoom-food.co.uk:8080/branches?latitude=52.7095254&longitude=-2.7584416&offset=0&limit=10&companyId=519&businessCategoryID=16&businessSubCategoryID=22,146";
	// 	// var pageURLfilter = "http://www.zoom-food.co.uk:8080/branches?latitude=52.7095254&longitude=-2.7584416&offset=0&limit=10&companyId=519";

	// 	var pageURLfilter;


	// 	var thisId = jQuery('.menu-nav-business-new-js > li > .click').attr('id');

	// 	var businessSubCategoryIDs = "";
	// 	jQuery('.menu-nav-business-new-js > li > .click + ul .click').each(function(){
	// 		var businessSubCategoryID = jQuery(this).attr('id');
	// 		businessSubCategoryIDs = businessSubCategoryIDs + businessSubCategoryID + ',';
	// 	});

	// 	if (thisId == 'all') {
	// 		pageBusinessFilterURL = "/branches?latitude=52.7095254&longitude=-2.7584416&offset=0&limit=30&companyId=" + companyId;
	// 	}else {
	// 		if(businessSubCategoryIDs.length) {
	// 			businessSubCategoryIDs = businessSubCategoryIDs.substring(0, businessSubCategoryIDs.length - 1);
	// 			pageBusinessFilterURL = "/branches?latitude=52.7095254&longitude=-2.7584416&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId + "&businessSubCategoryID=" + businessSubCategoryIDs;
	// 		}else {
	// 			pageBusinessFilterURL = "/branches?latitude=52.7095254&longitude=-2.7584416&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
	// 		}
	// 	}




	// 	jQuery.ajax({
	//     	type: "GET",
	//     	url: pageURLfilter,
	//     	// url: pageURL,
	//     	success: function(response) {
	//     		console.log(response);


	//     		var varStore;
	//     		for (var i = 0; response.length > i; i++) {
	//     			console.log(i);
	    	
	// 	    		var openText = 'Close'
	// 	    		if(response[i].offline == false) {
	// 	    			openText = 'Open'
	// 	    		}

	// 	    		varStore = varStore + '<li id="1890" onclick="location.href=\'' + '/stores/' + response[i].urlPath + '\';"><a href="' + '/stores/' + response[i].urlPath + '" class="one-product2"><div class="product-img-wrap-main"><div class="product-img-wrap"><div style="background-image: url(' + response[i].locationWebLogoUrl + ');"></div></div><span class="status-menu">' + response[i].offline + '</span></div><h2 class="product-title">' + response[i].name + '</h2><div class="clearfix"><div class="clearfix rating-wrap"><div class="rating-section"><span class="pull-left"><span class="branch-rate" id="branchRating-' + response[i].id + '" data-rate="' + response[i].locationMetaDatas[1].paramValue + '"></span></span><span class="pull-left">' + response[i].locationMetaDatas[0].paramValue + '</span></div></div></div></a></li>';




	//     		}		
	// 	    	jQuery("#load-restaurant-list ul").append(varStore);
	    		
	    // 		if (response.status == 'failure') {

	    // 		} else {
	    // 			jQuery("#load-restaurant-list ul").append(response.branchHTML);


					// if (jQuery('.menu-nav-wrap-main-js').length || jQuery('.business-page').length) {

					// 	jQuery("#load-restaurant-list ul li").each(function(){
					// 		if(!jQuery(this).children().hasClass('one-product')) {

					// 			var imgSrc = jQuery(this).find('.rest-logo').find('img').attr('src');


					// 			 var contentStatus = 0;

					// 			 if(jQuery(this).find('.store-open-text').length) {
					// 				jQuery(this).find('.store-open-text').addClass('status-menu');
					// 			 	contentStatus = jQuery(this).find('.store-open-text');
					// 			 }
					// 			 if(jQuery(this).find('.store-close-text').length) {
					// 				jQuery(this).find('.store-close-text').addClass('status-menu').addClass('status-menu-close');
					// 			 	contentStatus = jQuery(this).find('.store-close-text');
					// 			 }
					// 			 if(jQuery(this).find('.pre-orderbutton').length) {
					// 			 	contentStatus = jQuery(this).find('.pre-orderbutton');
					// 			 }
					// 			if(jQuery(this).find('.store-preorder-text').length) {
					// 			 	jQuery(this).find('.store-preorder-text').addClass('status-menu').addClass('status-menu-pre');
					// 			 	contentStatus = jQuery(this).find('.store-preorder-text');
					// 			 }

					// 			jQuery(this).find('.rest-logo').append('<div class="product-img-wrap"><div style="background-image: url(' + imgSrc + ');"></div></div>');
					// 			jQuery(this).find('.rest-logo').append(contentStatus);
					// 			jQuery(this).find('.rest-logo a').remove();

					// 			var subdescHtml = jQuery(this).find('.subdesc').text().replace("/\,/g","<span class='dot-style'></span>");
					// 			jQuery(this).find('.subdesc').html(subdescHtml);

					// 			jQuery(this).find('.social').hide();
					// 			jQuery(this).find('.desc').hide();
					// 			jQuery(this).find('.rest-logo').addClass('product-img-wrap-main').removeClass('rest-logo');
					// 			jQuery(this).find('.title').addClass('product-title').removeClass('title');


					// 			jQuery(this).find('.discount').wrapAll('<div class="clearfix">').wrapAll('<div class="process-menu-icn restaurant-menu-icn">').wrapAll('<div class="delivery-tooltip">');


					// 			if(jQuery(this).find('.rating-section').length) {
					// 				jQuery(this).find('.rating-section').wrapAll('<div class="clearfix rating-wrap">');
					// 				jQuery(this).find('.subdesc').after(jQuery(this).find('.rating-wrap'));
					// 			}
					// 			// else {
					// 			// 	jQuery(this).find('.subdesc').after('<div class="clearfix rating-wrap"> <div class="rating-section"><span class="pull-left"><span class="branch-rate" data-rate="0"></span></span><span class="pull-left">0</span></div></div>');
					// 			// 	jQuery(".branch-rate").each(function(){
					// 			// 		var that = this;
					// 			// 		var raingVar = 0;
					// 			// 		if(parseInt(jQuery(that).data("rate"))) {
					// 			// 			raingVar = parseInt(jQuery(that).data("rate"));
					// 			// 		}else {
					// 			// 			jQuery(this).parent().next().html('0');
					// 			// 		}
					// 			// 		jQuery(that).rateYo({rating : raingVar, readOnly : true, starWidth : '14px'})	
					// 			// 	});
					// 			// }


								
					// 			// if(imgSrc == undefined) {
					// 			// 	jQuery(this).find('.product-img-wrap').hide();
					// 			// }
							

					// 			jQuery(this).find('.rating-wrap').wrapAll('<div class="clearfix">');

					// 			jQuery(this).find('.restaurant-menu-icn').parent().append(jQuery(this).find('.rating-wrap'));

					// 			if(jQuery(this).children().hasClass('one-product2')) {

					// 			}else {
					// 				jQuery(this).children().wrapAll('<a href="#" class="one-product2"></a>');
					// 			}

					// 			// clearfix rating-wrap
					// 		}

					// 	});
					// }

					// if(response.firstBranchId != 0) {
		   //  			// jQuery('html, body').animate({scrollTop: jQuery("#"+response.firstBranchId).offset().top - 60}, 2000);
		   //  			if (response.nextLink != null) {
		   //  				document.getElementById("nextURL").value = response.nextLink;
		   //  			} else {
		   //  			}
	    // 			}
	    // 		}
	//     	},
	//     	dataType: 'json'
	//     });
	// }
</script>
<script type='text/javascript'>
	jQuery(document).ready(function(){
		jQuery(".branch-rate").each(function(){
			var that = this;
			var raingVar = 0;
			if(parseInt(jQuery(that).data("rate"))) {
				raingVar = parseInt(jQuery(that).data("rate"));
			}else {
				jQuery(this).parent().next().html('0');
			}
			jQuery(that).rateYo({rating : raingVar, readOnly : true, starWidth : '14px'})	
		})
	})
</script>