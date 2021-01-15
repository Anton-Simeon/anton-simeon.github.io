var $ = jQuery;
if(jQuery('.lazyload').length) {
	lazyload();
}

jQuery('.login-register-wrap-disable').removeClass('login-register-wrap-disable');

function MenuNavMoreShow() {
	if( jQuery('.menu-nav-wrap-main .dropdown-select li').length < 2 ) {
		jQuery('.menu-nav-wrap-main .dropdown-select').hide();

		jQuery('html:not([dir="rtl"]) .menu-nav-wrap-main').css('padding-left', '0');
		jQuery('html[dir="rtl"] .menu-nav-wrap-main').css('padding-right', '0');
	}
	
	if( jQuery('.menu-nav').height() > 66 ) {
		jQuery('.menu-nav-more').css('opacity', 1);
	}else {
		jQuery('.menu-nav-more').css('opacity', 0);
	}
}




function menuNavFun(selectorName) {
	var menuNavWrapMain_top = jQuery('.menu-nav-wrap-main-js')[0].offsetTop;
	var menuNavWrapMain_topNew = jQuery('.header').outerHeight();
	var menuNavWrapMain_top2 = menuNavWrapMain_top - menuNavWrapMain_topNew;
	var widthMenuSub = jQuery('.menu-nav-wrap-main-js').width();

	if(menuNavWrapMain_top2 < selectorName.scrollTop() ) {
		jQuery('.menu-nav-wrap-main').css({
			'top': menuNavWrapMain_topNew, 
			'position': 'fixed',
			'width': widthMenuSub
		});
	}else {
		jQuery('.menu-nav-wrap-main').css({
			'top': '0', 
			'position': 'relative',
			'width': 'auto'
		});
	}
}




const containers = jQuery('.product-text');
containers.each(function(){
	var p = jQuery(this).find('p:first-child');
	var pText;
	var divh = jQuery(this).height();
	if (p.height() > divh) { // Check if the paragraph's height is taller than the container's height. If it is:



		pText = p.text().trim();


		var textContentSplit = pText.split(' ', 15);
		console.log(textContentSplit);

		var textContentVar = "";
		for (var i = 0; i < textContentSplit.length; i++) {
			textContentVar = textContentVar + ' ' + textContentSplit[i];
		}

		p.text(textContentVar + ' ...');

		// p.textContent = p.textContent.substr(0, 5) + '...'; 
		// console.log(p.textContent);




		// var textP = p.text();
		// console.log(textP);
		// console.log(textP.substr(0, 5));
		// p.text(textP.substr(0, 5) + '...');
		// p.text(textP.replace(/\W*\s(\S)*$/, '..'));
	}
})


jQuery(window).resize(function() {
	MenuNavMoreShow();
	if(jQuery('.menu-nav-wrap').length) {
		var selectorName = jQuery(window);
		if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
			selectorName = jQuery('.mainWrapp_scroll');
		}
		menuNavFun(selectorName);
	}
});
function newDesignMenu() {



	jQuery("#load-restaurant-list ul li").each(function(){

		if(!jQuery(this).children().hasClass('one-product')) {

			var imgSrc = jQuery(this).find('.rest-logo').find('img').attr('src');


			 var contentStatus = 0;

			 if(jQuery(this).find('.store-open-text').length) {
				jQuery(this).find('.store-open-text').addClass('status-menu');
				contentStatus = jQuery(this).find('.store-open-text');
			 }
			 if(jQuery(this).find('.store-close-text').length) {
				jQuery(this).find('.store-close-text').addClass('status-menu').addClass('status-menu-close');
				contentStatus = jQuery(this).find('.store-close-text');
			 }
			 if(jQuery(this).find('.pre-orderbutton').length) {
				contentStatus = jQuery(this).find('.pre-orderbutton');
			 }
			if(jQuery(this).find('.store-preorder-text').length) {
				jQuery(this).find('.store-preorder-text').addClass('status-menu').addClass('status-menu-pre');
				contentStatus = jQuery(this).find('.store-preorder-text');
			 }
			

			jQuery(this).find('.rest-logo').append('<div class="product-img-wrap"><div style="background-image: url(' + imgSrc + ');"></div></div>');
			jQuery(this).find('.rest-logo').append(contentStatus);
			jQuery(this).find('.rest-logo a').remove();

			var subdescHtml = jQuery(this).find('.subdesc').text().replace("/\,/g","<span class='dot-style'></span>");
			jQuery(this).find('.subdesc').html(subdescHtml);

			jQuery(this).find('.social').hide();
			jQuery(this).find('.desc').hide();
			jQuery(this).find('.rest-logo').addClass('product-img-wrap-main').removeClass('rest-logo');
			jQuery(this).find('.title').addClass('product-title').removeClass('title');


			jQuery(this).find('.discount').wrapAll('<div class="clearfix">').wrapAll('<div class="process-menu-icn restaurant-menu-icn">').wrapAll('<div class="delivery-tooltip">');


			if(jQuery(this).find('.rating-section').length) {
				var ratingNumber = jQuery(this).find('.rating-section > .pull-left:last-child').text();

				// if(ratingNumber == 0 ) {
				// 	jQuery(this).find('.rating-section').css('opacity', 0);
				// }

				jQuery(this).find('.rating-section').wrapAll('<div class="clearfix rating-wrap">');
				jQuery(this).find('.subdesc').after(jQuery(this).find('.rating-wrap'));
			}
			// else {
				// jQuery(this).find('.subdesc').after('<div class="clearfix rating-wrap"> <div class="rating-section"><span class="pull-left"><span class="branch-rate" data-rate="0"></span></span><span class="pull-left">0</span></div></div>');
				// jQuery(".branch-rate").each(function(){
				// 	var that = this;
				// 	var raingVar = 0;
				// 	if(parseInt(jQuery(that).data("rate"))) {
				// 		raingVar = parseInt(jQuery(that).data("rate"));
				// 	}else {
				// 		jQuery(this).parent().next().html('0');
				// 	}
				// 	jQuery(that).rateYo({rating : raingVar, readOnly : true, starWidth : '14px'})	
				// });
			// }


			
			if(imgSrc == undefined) {
				// jQuery(this).find('.product-img-wrap > div').hide();
			}
		

			jQuery(this).find('.rating-wrap').wrapAll('<div class="clearfix">');

			jQuery(this).find('.restaurant-menu-icn').parent().append(jQuery(this).find('.rating-wrap'));

			jQuery(this).children().wrapAll('<a href="#" class="one-product2"></a>');


			// clearfix rating-wrap
		}

	});


}


function loaderBtn(thisparam){
	thisparam.addClass('disable-btn');
}

jQuery(document).ready(function(){

	function cartdivBtn() {
		if( jQuery('#cartdiv').length ) {
			var selectDayVal = jQuery('.pre-order-section-new select[name="selectDay"]').val();
			if(selectDayVal == '-1' || selectDayVal == undefined) {
				jQuery('.checkOutForm .btn').attr('disabled', 'disabled');
			}else {
				jQuery('.checkOutForm .btn').prop('disabled', false);
			}
		}
	}
	cartdivBtn();

	jQuery(document).ajaxStop(function(){
		cartdivBtn();
	});

	jQuery('body').on('click', '.order-type-tabs > *', function (){
		cartdivBtn();
	});


	// order-type-tabs

	function scrollHeader() {
		if(jQuery(window).scrollTop() > 10) {
			jQuery('.header').addClass('active');
		}else {
			jQuery('.header').removeClass('active');
		}
	}
	jQuery(window).scroll(function(){
	scrollHeader();
	});
	scrollHeader();
	
	jQuery('body').on('click','.register-button', function(){
		loaderBtn(jQuery(this));
	});
	jQuery('body').on('click','.login-button', function(){
		loaderBtn(jQuery(this));
	});
	jQuery('body').on('click','.btn:not(.search-button):not(#orderBtn):not(.item):not(.btn-primary-menu):not(.btn-primary-caret)', function(){
		loaderBtn(jQuery(this));
	});


	jQuery(document).ajaxStop(
	  function(){
		jQuery('.modal').removeClass('spinner-active');
		jQuery('.register-button').removeClass('disable-btn');
		jQuery('.login-button').removeClass('disable-btn');
		jQuery('.btn:not(.ajax-btn)').removeClass('disable-btn');
	  }
	);


	if(jQuery('.menu-nav-wrap').length) {
		var selectorName = jQuery(window);
		if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
			selectorName = jQuery('.mainWrapp_scroll');
		}
		menuNavFun(selectorName);
		jQuery(window).scroll(function(){
			var selectorName = jQuery(window);
			if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
				selectorName = jQuery('.mainWrapp_scroll');
			}
			menuNavFun(selectorName);
		});
		jQuery('.mainWrapp_scroll').scroll(function(){

			var selectorName = jQuery(window);
			if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
				selectorName = jQuery('.mainWrapp_scroll');
			}
			menuNavFun(selectorName);
			
		});
	}


	MenuNavMoreShow();


	function colLi() {
		var colLi = 0;
		jQuery('.menu-nav-more-js li').each(function(){
			var thisPosition = jQuery(this).position();
			if(thisPosition.top < 10) {
				colLi++;
			}
		});
		var menuDropdown = jQuery('.menu-nav-more-js li:nth-child(' + colLi + ')').nextAll().clone();
		jQuery('.menu-nav-dropdown ul').html('');
		jQuery('.menu-nav-dropdown ul').append(menuDropdown);

		if(menuDropdown.length == 0) {
			jQuery('.menu-nav-dropdown').removeClass('open');
			jQuery('.menu-nav-more').removeClass('open');
		}
	}

	jQuery('.menu-nav-more').click(function(){
		if( jQuery(this).hasClass('open') ){
			jQuery(this).removeClass('open');
			jQuery('.menu-nav-dropdown').removeClass('open');
		}else {
			jQuery(this).addClass('open');
			jQuery('.menu-nav-dropdown').addClass('open');
			colLi();
		}
		return false
	});

	jQuery(window).resize(function(){
		colLi();
	});


	function menuNavBusinessJsClickFun(thisFun) {



		var companyId = jQuery('#companyId').val();
		var thisId = thisFun.attr('id');
		jQuery('.menu-nav-business-js a').removeClass('click');
		jQuery('.products-list2').html("");
		thisFun.addClass('click');
		var pageBusinessFilterURL;
		if (thisId == 'all') {
			pageBusinessFilterURL = "/stores/all/filter?companyId=" + companyId;
		}else {
			pageBusinessFilterURL = "/stores/all/filter?companyId=" + companyId + "&businessCategoryID=" + thisId;
		}

		jQuery.ajax({
			type: "GET",
			url: pageBusinessFilterURL,
			success: function(response) {
				jQuery('.products-list2').html(response.branchHTML);
				newDesignMenu();


				if (response.nextLink != null) {
					oldLink = "";
					document.getElementById("nextURL").value = response.nextLink;
				} else {
					oldLink = "";
					document.getElementById("nextURL").value = "";
				}					
			},
			dataType: 'json'
		});

	}
	jQuery('body').on('click','.menu-nav-business-js a', function(){
		menuNavBusinessJsClickFun(jQuery(this));
		return false
	});





	if(jQuery('.menu-nav-business-new-js').length){
		var companyId = jQuery('#companyId').val();
		var longitude_var = $('#longitude').val();
		var latitude_var = $('#latitude').val();
		var pageBusinessURL;


		if(longitude_var && latitude_var ) {
			pageBusinessURL = "/businesscategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId;
		}else {
			pageBusinessURL = "/businesscategories?companyId=" + companyId;
		}

		jQuery.ajax({
			type: "GET",
			url: pageBusinessURL,
			success: function(response) {

				if(response.length) {
					if(response.length < 2) {

						jQuery('.menu-nav-business-new-js li:first-child').removeClass('click').hide();
						jQuery('.menu-nav-business-new-js li:first-child a').removeClass('click');
						jQuery('.menu-nav-business-new-js').append('<li><a href="#" class="click" id=' + response[0].id + '>' + response[0].name + '</a></li>');


						var thisLink = jQuery('.menu-nav-business-new-js > li:nth-child(2) > a');
						var businessCategoryID = response[0].id;
						var businesssubCategoriesUrl;

						if(longitude_var && latitude_var ) {
							businesssubCategoriesUrl = "/businesssubcategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
						}else {
							businesssubCategoriesUrl = "/businesssubcategories?companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
						}


						jQuery.ajax({
							type: "GET",
							url: businesssubCategoriesUrl,
							success: function(response) {
								var htmlUl = "";
								for (var i = 0; i < response.length; i++) {
									if ( (response[i].name != 'Any') && (response[i].name != thisLink.text()) ){
										htmlUl = htmlUl + '<li><a href="#" id=' + response[i].id + ' data-businessCategoryId="' + response[i].businessCategoryId + '">' + response[i].name + '</a></li>';
									}
								}
								if(htmlUl != "") {
									thisLink.parent().append('<ul>' + htmlUl + '</ul>');

									showBusinessSidebar();
								}
							},
							dataType: 'json'
						});

					}else {

						showBusinessSidebar();

						for (var i = 0; i < response.length; i++) {
							jQuery('.menu-nav-business-new-js').append('<li><a href="#" id=' + response[i].id + '>' + response[i].name + '</a></li>');

							setTimeout(function(){
								MenuNavMoreShow();
							}, 400);
						}

					}
				}
				
			},
			error: function (error) {
			    console.log(error);
			},
			dataType: 'json'
		});

	}



	$.fn.isOnScreen = function(){
	    var win = jQuery(window);
	    
	    var viewport = {
	        top : win.scrollTop(),
	        left : win.scrollLeft()
	    };
	    viewport.right = viewport.left + win.width();
	    viewport.bottom = viewport.top + win.height();
	    
	    var bounds = this.offset();
	    bounds.right = bounds.left + this.outerWidth();
	    bounds.bottom = bounds.top + this.outerHeight();
	    
	    return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
	};

	var timeout;
	var lastScrollTop = 0;
	var oldLink = "";
	var oldLiCol = 30;
	var oldLiColNew = 0;

	jQuery(window).scroll(function() {
		var st = jQuery(this).scrollTop();
	   	if (st > lastScrollTop && jQuery('#load-restaurant-link').length > 0){

	    	if (jQuery('#load-restaurant-link').isOnScreen() == true) {


	    		clearTimeout(timeout);  
		    	timeout = setTimeout(function() {


		    		// $( jQuery('.products-list2 > li').length ) {

		    		// }


		    		// if (oldLink != document.getElementById("nextURL").value) {
		    			oldLiCol = jQuery('.products-list2 > li').length;

		    			if(oldLiCol != oldLiColNew) {
		    				oldLiColNew = jQuery('.products-list2 > li').length;
			    			scrollAjax(oldLiCol);
			    		}

		    		// }
			   	}, 50);
	    	}
	   } else {
	   }
	   lastScrollTop = st;
	});

	jQuery(document).ready(function() {
		var loading = jQuery("#loadingDiv");
        jQuery(document).ajaxStart(function () {
            loading.show();
        });

        jQuery(document).ajaxStop(function () {
            loading.hide();
        });
    });



	function scrollAjax(oldLi) {


		var pageURLfilter;
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();


		var thisId = jQuery('.menu-nav-business-new-js > li > .click').attr('id');

		var businessSubCategoryIDs = "";
		jQuery('.menu-nav-business-new-js > li > .click + ul .click').each(function(){
			var businessSubCategoryID = jQuery(this).attr('id');
			businessSubCategoryIDs = businessSubCategoryIDs + businessSubCategoryID + ',';
		});


		latitude

		if (thisId == 'all') {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId;
		}else {
			if(businessSubCategoryIDs.length) {
				businessSubCategoryIDs = businessSubCategoryIDs.substring(0, businessSubCategoryIDs.length - 1);
				pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId + "&businessSubCategoryID=" + businessSubCategoryIDs;
			}else {
				pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=" + oldLi + "&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
			}
		}



		console.log(oldLi);

		loadResuts(pageBusinessFilterURL);
	}



	// if(jQuery('.business-page').length) {
	// 	scrollAjax();
	// }







	function loadResuts(pageURL){
		// console.log(pageURL);
		jQuery.ajax({
	    	type: "GET",
	    	url: pageURL,
	    	success: function(response) {
	    		console.log(response);


	    		var varStore = "";
	    		for (var i = 0; response.length > i; i++) {
	    	

		    		var openText = '';
		    		var openTextClass = '';
		    		var reviewCount = 0;
					var nowBranchOpenForASAP, branchOnlineForASAP, nowBranchOpenForPreOrdering, branchOnlineForPreOrdering, nowBranchOpenForASAP, nowBranchOpenForPreOrdering;

		    		
		    		

		    		var averageReviewScore = 0;
		    		for (var b = 0; response[i].locationMetaDatas.length > b; b++) {
		    			if(response[i].locationMetaDatas[b].paramName == "reviewCount" ) {
		    				reviewCount = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "averageReviewScore" ) {
		    				averageReviewScore = response[i].locationMetaDatas[b].paramValue;
		    			}

		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForASAP" ) {
							nowBranchOpenForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "branchOnlineForASAP" ) {
							branchOnlineForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}


		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForPreOrdering" ) {
							nowBranchOpenForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "branchOnlineForPreOrdering" ) {
							branchOnlineForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}


		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForASAP" ) {
							nowBranchOpenForASAP = response[i].locationMetaDatas[b].paramValue;
		    			}
		    			if(response[i].locationMetaDatas[b].paramName == "nowBranchOpenForPreOrdering" ) {
							nowBranchOpenForPreOrdering = response[i].locationMetaDatas[b].paramValue;
		    			}


		    		}


					if(nowBranchOpenForASAP == "true" && branchOnlineForASAP == "true") {
						openText = jQuery('#labelStoreOpen').val();
						openTextClass = "status-menu-open";
					}else if(nowBranchOpenForPreOrdering == "true" && branchOnlineForPreOrdering == "true") {
						openText = jQuery('#labelStoreOrderforlater').val();
						openTextClass = "status-menu-pre";
					}else if(nowBranchOpenForASAP != "true" && nowBranchOpenForPreOrdering != "true") {
						openText = jQuery('#labelStoreClose').val();
						openTextClass = "status-menu-close";
					}else {
						// offline
						openText = jQuery('#labelStoreOffline').val();
						openTextClass = "status-menu-offline";
					}


					var ratingText = '<div class="rating-section"><span class="pull-left"><span class="branch-rate" id="branchRating-' + response[i].id + '" data-rate="' + averageReviewScore + '"></span></span><span class="pull-left">' + reviewCount + '</span></div>';

					if(response[i].hasReviews == false) {
						ratingText = "";
					}


		    		varStore = varStore + '<li id="' + response[i].id + '" onclick="location.href=\'' + '/store/' + response[i].urlPath + '\';"><a href="' + '/store/' + response[i].urlPath + '" class="one-product2"><div class="product-img-wrap-main"><div class="product-img-wrap"><div style="background-image: url(' + response[i].locationWebLogoUrl + ');"></div></div><span class="status-menu ' + openTextClass + '">' + openText + '</span></div><h2 class="product-title">' + response[i].name + '</h2><div class="clearfix"><div class="clearfix rating-wrap">' + ratingText + '</div></div></a></li>';




	    		}		
		    	jQuery("#load-restaurant-list ul").append(varStore);


		    	jQuery(".branch-rate").each(function(){
					var that = this;
					var raingVar = 0;
					if(parseInt(jQuery(that).data("rate"))) {
						raingVar = parseInt(jQuery(that).data("rate"));
					}else {
						jQuery(this).parent().next().html('0');
					}
					jQuery(that).rateYo({rating : raingVar, readOnly : true, starWidth : '14px'})	
				});

	    	},
	    	dataType: 'json'
	    });
	}










	function showBusinessSidebar() {
		jQuery('.business-page').removeClass('no-sidebar-business-page');
	}


	function menuNavBusinessNewJsClickFun(thisFun) {
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();
		var thisId = thisFun.attr('id');
		jQuery('.menu-nav-business-new-js a').removeClass('click');
		jQuery('.products-list2').html("");
		thisFun.addClass('click');
		var businessFilterLink;

		var pageBusinessFilterURL;
		if (thisId == 'all') {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId;
		}else {
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
		}

		console.log('main pageBusinessFilter');
		pageBusinessFilter(pageBusinessFilterURL);

	}
	var companyId = jQuery('#companyId').val();
	var longitude = jQuery('#longitude').val();
	var latitude = jQuery('#latitude').val();



	if(jQuery('.business-page').length) {
		// pageBusinessFilter("/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId);
	}




	function menuNavBusinessNewJsClickFunSub() {
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();
		jQuery('.products-list2').html("");
		var thisId = jQuery('.menu-nav-business-new-js > li > .click').attr('id');

		var businessSubCategoryIDs = "";
		jQuery('.menu-nav-business-new-js > li > .click + ul .click').each(function(){
			var businessSubCategoryID = jQuery(this).attr('id');
			businessSubCategoryIDs = businessSubCategoryIDs + businessSubCategoryID + ',';

		});

		var pageBusinessFilterURL;

		if(businessSubCategoryIDs.length) {
			businessSubCategoryIDs = businessSubCategoryIDs.substring(0, businessSubCategoryIDs.length - 1);
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId + "&businessSubCategoryID=" + businessSubCategoryIDs;

		}else {

			console.log('businessSubCategoryIDs false ');
			pageBusinessFilterURL = "/branches?latitude=" + latitude + "&longitude=" + longitude + "&offset=0&limit=30&companyId=" + companyId + "&businessCategoryID=" + thisId;
		}

		pageBusinessFilter(pageBusinessFilterURL);

	}










	function pageBusinessFilter(pageBusinessFilterURL) {
		jQuery('.products-list2').html('');
		loadResuts(pageBusinessFilterURL);
	}

	jQuery('body').on('click','.menu-nav-business-new-js > li ul a', function(){
		jQuery(this).toggleClass('click');
		menuNavBusinessNewJsClickFunSub();
	});


	jQuery('body').on('click','.menu-nav-business-new-js > li >  a', function(){
		$('.menu-nav-business-new-js > li ul').remove();
		menuNavBusinessNewJsClickFun(jQuery(this));
		var thisLink = jQuery(this);
		var businessCategoryID = jQuery(this).attr('id');
		var companyId = jQuery('#companyId').val();
		var longitude_var = $('#longitude').val();
		var latitude_var = $('#latitude').val();

		if(businessCategoryID != 'all') {

			var businesssubCategoriesUrl;

			if(longitude_var && latitude_var ) {
				businesssubCategoriesUrl = "/businesssubcategories?latitude=" + latitude_var + "&longitude=" + longitude_var + "&companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
			}else {
				businesssubCategoriesUrl = "/businesssubcategories?companyId=" + companyId + "&businessCategoryID=" + businessCategoryID;
			}


			jQuery.ajax({
				type: "GET",
				url: businesssubCategoriesUrl,
				success: function(response) {
					var htmlUl = "";
					for (var i = 0; i < response.length; i++) {
						if ( (response[i].name != 'Any') && (response[i].name != thisLink.text()) ){
							htmlUl = htmlUl + '<li><a href="#" id=' + response[i].id + ' data-businessCategoryId="' + response[i].businessCategoryId + '">' + response[i].name + '</a></li>';
						}
					}
					if(htmlUl != "") {
						thisLink.parent().append('<ul>' + htmlUl + '</ul>');
					}
				},
				dataType: 'json'
			});
		}
		return false
	});




	if (jQuery('.business-page').length) {

		function filterScrollFun() {
			var scrollThis = jQuery(window).scrollTop() + jQuery(window).outerHeight();
			var businessPageHeight = jQuery('.business-page .mainWrapp').outerHeight();

			var topScrollHeight = scrollThis - businessPageHeight;
			if ( topScrollHeight > 0 ) {
				jQuery('.sidebar-filter').css('bottom', topScrollHeight + 'px');
			}else {
				jQuery('.sidebar-filter').css('bottom', 0);
			}
		}

		filterScrollFun();

		jQuery(window).scroll(function(){
			filterScrollFun();
		});



	}
	

	jQuery('body').on('click','.filter-button-sidebar a', function(){
		jQuery('.wrap-sidebar-filter').show();
		setTimeout(function(){
			jQuery('html').addClass('sidebar-filter-active');
		}, 100);
		setTimeout(function(){
			jQuery('.filter-button-sidebar a').removeClass('disable-btn');
		}, 300);
		return false 
	});
	jQuery('body').on('click','.close-sidebar-filter', function(){
		jQuery('html').removeClass('sidebar-filter-active');
		jQuery('.wrap-sidebar-filter').hide();
		return false 
	});






	jQuery('body').on('click','.menu-nav-dropdown-business-js a', function(){
		menuNavBusinessJsClickFun(jQuery(this));
		jQuery('.menu-nav-more').click();
		return false 
	});


	if(jQuery('.menu-nav-business-js').length){
		var companyId = jQuery('#companyId').val();
		var pageBusinessURL = "/businesscategories?companyId=" + companyId;
		jQuery.ajax({
			type: "GET",
			url: pageBusinessURL,
			success: function(response) {
				for (var i = 0; i < response.length; i++) {
					jQuery('.menu-nav-business-js').append('<li><a href="#" id=' + response[i].id + '>' + response[i].name + '</a></li>');

					setTimeout(function(){
						MenuNavMoreShow();
					}, 400);
				}
			},
			dataType: 'json'
		});
	}








	jQuery('body').on('keypress', '.modal .submenuform input', function (e){
		if(e.which == 10 || e.which == 13) {
			jQuery(this).closest('.modal').find('.login-btn-center button').click();
		}
	});

	jQuery('#restname').on('input',function(e){
		jQuery(".radio-option").each(function(i) {
			jQuery(this).removeClass('click');	
		});
		var restaurantName = document.getElementById("restname").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (restaurantName != '') {
			if (filterURL.indexOf("?") >= 0) {
				filterURL = filterURL + "&name="+restaurantName;
			} else {
				filterURL = filterURL + "?name="+restaurantName;
			}
		}
		jQuery("#load-restaurant-list ul").html("");
		
		// queue up an ajax request
		jQuery.ajaxQueue({
			url: filterURL,
			type: 'GET',
			success: function(response) {
				if (response.status == 'failure') {
					//alert("Failed to Delete");
				} else {
					jQuery(".total-restaurants").html(response.totalBranches);
					if (response.firstBranchId != '0') {
						jQuery("#load-restaurant-list ul").html(response.branchHTML);
						jQuery('html, body').animate({
							scrollTop: jQuery("#"+response.firstBranchId).offset().top-110}, 2000);
						if (response.nextLink != null) {
							oldLink = "";
							document.getElementById("nextURL").value = response.nextLink;
						} else {
							oldLink = "";
							document.getElementById("nextURL").value = "";
						}
					} else {
						jQuery("#load-restaurant-list ul").html("");
						document.getElementById("nextURL").value = "";
					}
				}
				if (jQuery('.menu-nav-wrap-main-js').length || jQuery('.business-page').length) {
					newDesignMenu();
				}
			},
			dataType: 'json'
		});
	});



	var varClickRestname;




	jQuery('#business-restname').on('input',function(e){
		clearTimeout(varClickRestname);
		varClickRestname = setTimeout(function(){ 
			clickRestname();
		}, 800);
	});


	function clickRestname() {


		jQuery(".radio-option").each(function(i) {
			jQuery(this).removeClass('click');	
		});
		var restaurantName = document.getElementById("business-restname").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (restaurantName != '') {
			if (filterURL.indexOf("?") >= 0) {
				filterURL = filterURL + "&name="+restaurantName;
				jQuery('.business-search-list').show();
				jQuery('.business-search-button-close').show();
				
			} else {
				filterURL = filterURL + "?name="+restaurantName;
			}
		}else {
			jQuery('.business-search-list').hide();
			jQuery('.business-search-button-close').hide();
		}
		jQuery(".business-search-list").html("");
		
		// queue up an ajax request
		jQuery.ajaxQueue({
			url: filterURL,
			type: 'GET',
			success: function(response) {
				if (response.status == 'failure') {
					//alert("Failed to Delete");
				} else {
					if (response.firstBranchId != '0') {
						jQuery(".business-search-list").html(response.branchHTML);
					} else {

						jQuery(".business-search-list").html("<div class='no-result-filter'>No Results</div>");
					}
				}
			},
			dataType: 'json'
		});

	}







	
	jQuery('.business-search-button-close').click(function(){
		jQuery('.business-search-list').hide();
		jQuery('.business-search-button-close').hide();
		jQuery('#business-restname').val('');
		return false
	});










	
	jQuery('#restnamemob').on('input',function(e){
		jQuery(".radio-option-mob").each(function(i) {
			jQuery(this).removeClass('click');	
		});
		var restaurantName = document.getElementById("restnamemob").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (restaurantName != '') {
			if (filterURL.indexOf("?") >= 0) {
				filterURL = filterURL + "&name="+restaurantName;
			} else {
				filterURL = filterURL + "?name="+restaurantName;
			}
		}
		jQuery("#load-restaurant-list ul").html("");
		
		// queue up an ajax request
		jQuery.ajaxQueue({
			url: filterURL,
			type: 'GET',
			success: function(response) {
				if (response.status == 'failure') {
					//alert("Failed to Delete");
				} else {
					jQuery(".total-restaurants").html(response.totalBranches);
					if (response.firstBranchId != '0') {
						jQuery("#load-restaurant-list ul").html(response.branchHTML);





						jQuery('html, body').animate({
							scrollTop: jQuery("#"+response.firstBranchId).offset().top-110}, 2000);
						if (response.nextLink != null) {
							oldLink = "";
							document.getElementById("nextURL").value = response.nextLink;
						} else {
							oldLink = "";
							document.getElementById("nextURL").value = "";
						}
					} else {
						jQuery("#load-restaurant-list ul").html("");
						document.getElementById("nextURL").value = "";
					}
				}
			},
			dataType: 'json'
		});
	});
	
	jQuery(document).on('click', '.radio-option', function(){
		
		jQuery(".radio-option").each(function(i) {
			jQuery(this).removeClass("click");
		});

		jQuery('.menu-nav-dropdown').removeClass('open');
		jQuery('.menu-nav-more').removeClass('open');
			
		jQuery(this).not(this).removeClass('click');
		jQuery(this).toggleClass("click");
		
		var listCuisines = "";
		jQuery(".radio-option").each(function(i) {
			if (jQuery(this).hasClass("click")) {
				listCuisines += encodeURIComponent(jQuery(this).attr('id'))+",";
			}
		});
		if (listCuisines != '') {
			jQuery("#listcuisines").val(listCuisines);
		}
		var restaurantName = document.getElementById("restname").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (filterURL.indexOf("?") >= 0) {
			if (restaurantName != '') {
				filterURL = filterURL + "&name="+restaurantName;
			}
			if (listCuisines != '') {
				filterURL = filterURL + "&listCuisines="+listCuisines;
			}
		} else {
			if (restaurantName != '') {
				filterURL = filterURL + "?name="+restaurantName;
			}
			if (listCuisines != '') {
				if (filterURL.indexOf("?") >= 0) {
					filterURL = filterURL + "&listCuisines="+listCuisines;
				} else {
					filterURL = filterURL + "?listCuisines="+listCuisines;
				}
			}
		}
		//alert("filterURL is 3 : " + filterURL);
		jQuery("#load-restaurant-list ul").html("");
		
		loadRestaurantsByFilter(filterURL);
		return false
	});
	
	jQuery('.radio-option-mob').click(function () {
		
		jQuery(".radio-option-mob").each(function(i) {
			jQuery(this).removeClass("click");
		});
		
		jQuery(this).not(this).removeClass('click');
		jQuery(this).toggleClass("click");
		
		var listCuisines = "";
		jQuery(".radio-option-mob").each(function(i) {
			if (jQuery(this).hasClass("click")) {
				listCuisines += encodeURIComponent(jQuery(this).attr('id'))+",";
			}
		});
		if (listCuisines != '') {
			jQuery("#listcuisines").val(listCuisines);
		}
		var restaurantName = document.getElementById("restnamemob").value;
		var filterURL = document.getElementById("filterURL").value;
		if (filterURL.indexOf("&listCuisines=") >= 0) {
			filterURL = filterURL.substr(0, filterURL.indexOf("&listCuisines="));
		}
		
		if (filterURL.indexOf("?") >= 0) {
			if (restaurantName != '') {
				filterURL = filterURL + "&name="+restaurantName;
			}
			if (listCuisines != '') {
				filterURL = filterURL + "&listCuisines="+listCuisines;
			}
		} else {
			if (restaurantName != '') {
				filterURL = filterURL + "?name="+restaurantName;
			}
			if (listCuisines != '') {
				if (filterURL.indexOf("?") >= 0) {
					filterURL = filterURL + "&listCuisines="+listCuisines;
				} else {
					filterURL = filterURL + "?listCuisines="+listCuisines;
				}
			}
		}
		//alert("filterURL is : " + filterURL);
		jQuery("#load-restaurant-list ul").html("");
		
		loadRestaurantsByFilter(filterURL);
	});



	
	function loadRestaurantsByFilter(pageURL){
		jQuery.ajax({
			type: "GET",
			url: pageURL,
			success: function(response) {
				if (response.status == 'failure') {
					//alert("Failed to Delete");
				} else {
					jQuery(".total-restaurants").html(response.totalBranches);
					if (response.firstBranchId != '0') {
						jQuery("#load-restaurant-list ul").append(response.branchHTML);
			
						if (jQuery('.menu-nav-wrap-main-js').length || jQuery('.business-page').length) {
							newDesignMenu();
						}




						jQuery('html, body').animate({
							scrollTop: jQuery("#"+response.firstBranchId).offset().top-180}, 2000);
						if (response.nextLink != null) {
							oldLink = "";
							document.getElementById("nextURL").value = response.nextLink;
						} else {
							oldLink = "";
							document.getElementById("nextURL").value = "";
						}
					} else {
						jQuery("#load-restaurant-list ul").html("");
						document.getElementById("nextURL").value = "";
					}
				}
			},
			dataType: 'json'
		});
	}
});

jQuery(document).ready(function(){
	
	
		
	
	jQuery('.modal').on('hidden.bs.modal', function () {
		jQuery('.modal').addClass('spinner-active');
		jQuery('.btn').removeClass('disable-btn');
	});
	jQuery('.modal').on('show.bs.modal', function () {
		jQuery('.modal:not(.spinner-not)').addClass('spinner-active');
		jQuery('.btn').removeClass('disable-btn');
	});


	jQuery('#addMenuItemModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
		jQuery(this).removeData('bs.modal').find(".modal-header").html('');
		jQuery(this).removeData('bs.modal').find(".modal-body").html('');
		jQuery(this).removeData('bs.modal').find(".modal-footer").html('');
	});

	jQuery('#orderDetailModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#addressBookModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#loginModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#forgotloginModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#registerModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#addressModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	jQuery('#reorderConfirmModal').on('hidden.bs.modal', function () {
		jQuery(this).removeData('bs.modal').find(".modal-content").html('');
	});
	
	// This just makes all bootstrap native .modals jive together
	jQuery('.modal').on("hidden.bs.modal", function (e) {
		if(jQuery('.modal:visible').length)
		{
			jQuery('.modal-backdrop').first().css('z-index', parseInt(jQuery('.modal:visible').last().css('z-index')) - 10);
			jQuery('body').addClass('modal-open');
		}
	}).on("show.bs.modal", function (e) {
		if(jQuery('.modal:visible').length)
		{
			jQuery('.modal-backdrop.in').first().css('z-index', parseInt(jQuery('.modal:visible').last().css('z-index')) + 10);
			jQuery(this).css('z-index', parseInt(jQuery('.modal-backdrop.in').first().css('z-index')) + 10);
		}
	});
	
	jQuery('[data-toggle="tooltip"]').tooltip();   
	
	jQuery('.profile-dropdown').on('click', function(){
		 jQuery(this).children('.dropdown-menu').toggle();
	}); 
	
	jQuery('.choosesizes').on('click', function(){ 
		jQuery('.selectsecondstep').slideDown('slow');	
	});
	
	jQuery('.choosecrust').on('click', function(){ 
		jQuery('.selectthirdstep').slideDown('slow');	
	});
	
	jQuery(".clickable-row").click(function() {
		window.document.location = jQuery(this).data("href");
	});
});

function changeOrderType(orderType) {
	if(orderType == 'DELIVERY') {
		jQuery('#addressbookdiv').show(); 
		jQuery('.delivery-charge', '.sub-total').show();
	} else {
		jQuery('#addressbookdiv').hide(); 
		jQuery('.delivery-charge', '.sub-total').hide();
	}
	
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdatepaymentmethods",
		data: ({orderType:orderType}),
		success: function(responseText){
			jQuery('#paymentmethod').html(responseText);
		},
		dataType: "html"
	});	
	
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdateordertime",
		data: ({orderType:orderType}),
		success: function(responseText){
			jQuery('#ordertime').html(responseText);
		},
		dataType: "html"
	});		
}

var selectedAddresId = null;

function setSelectedAddresId(_selectedAddresId){
	selectedAddresId = _selectedAddresId;
	updateDeliveryChanges();
}
function getAddressData() { 
	var orderType= jQuery("#orderType").val();
	var companyId = selectedCompanyId;
	var addressId = selectedAddresId;
	return {
			"orderType" : orderType,
			"companyId" : companyId,
			"addressId" : addressId
	}
}

var updateDeliveryChanges = (function() {
	return function(){
		setTimeout(function(){
			var orderData = getAddressData();
			changeAddress(orderData.orderType, orderData.companyId, orderData.addressId);
		}, 200);
	}
})();

jQuery('.address-field-name').click(updateDeliveryChanges);

jQuery('input:radio[name=addressId]').change(updateDeliveryChanges);

function changeAddress(orderType, companyId, addressId) {
	jQuery.ajax({			
		type: "POST",
		url: "/ajaxchangeAddress",
		data: ({orderType: orderType,companyId: companyId, addressId: addressId}),
		success: function(responseText){
			jQuery("#shoppingcartCommon").html(responseText)
		}, 
		dataType: "html"
	});	
}

function changeOrderType(orderType,companyId) {
	if(orderType == 'DELIVERY') {
		jQuery('#addressbookdiv').show(); 
		jQuery('.sub-total').show();
		jQuery('.delivery-charge').show();
		jQuery.ajax({
			type: "POST",
			url: "/ajaxchangeordertype",
			success: function(responseText){
				jQuery('#paymentmethod').html('');
			},
			dataType: "json"
		});	
	} else {
		jQuery('#addressbookdiv').hide(); 
		jQuery('.sub-total').hide();
		jQuery('.delivery-charge').hide();
		jQuery(".food-content td").css("border-bottom", "none", "important");
	}
	
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdatepaymentmethods",
		data: ({orderType:orderType,companyId: companyId}),
		success: function(responseText){
			jQuery('#paymentmethod').html(responseText);
		},
		dataType: "html"
	});	
	
	jQuery.ajax({
		type: "POST",
		url: "/ajaxupdateordertime",
		data: ({orderType:orderType,companyId: companyId}),
		success: function(responseText){
			jQuery('#ordertime').html(responseText);
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
	$.each(jQuery('#submenuform').serializeArray(), function(i, field) {
		values[field.name] = field.value;
		if (isNumber(field.name)) {
			
		}
	});	
}

function isNumber(n) {
	 return !isNaN(parseFloat(n)) && isFinite(n);
}

/*------------------------------------
	   Detecting Browser
------------------------------------*/
var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
// Opera 8.0+ (UA detection to detect Blink/v8-powered Opera)
var isFirefox = typeof InstallTrigger !== 'undefined';   // Firefox 1.0+
var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
// At least Safari 3+: "[object HTMLElementConstructor]"
var isChrome = !!window.chrome && !isOpera;// Chrome 1+
var isIE = /* @cc_on!@ */false || !!document.documentMode;// Chrome 1+ // At least
														// IE6 //
jQuery(document).ready(function(){
	if (isOpera) {
		jQuery(".mainWrapp").addClass("ophlClass");
	} else if (isFirefox) {
		jQuery(".mainWrapp").addClass("ffhlClass");
	} else if (isSafari) {
		jQuery(".mainWrapp").addClass("sfhlClass");
	} else if (isChrome) {
		jQuery(".mainWrapp").addClass("chhlCass");
	} else if (isIE) {
		jQuery(".mainWrapp").addClass("exhlClass");
	}
});


jQuery(document).ready(function(){

	jQuery('.menu-button-wrap').click(function(){
		jQuery('html').toggleClass('menu-open');
	});
	jQuery('.bg-mobile').click(function(){
		jQuery('html').removeClass('menu-open');
	});


		//checkCartHeight();
	jQuery("div.on-hover-content").hide();

	if(jQuery("*:not(.modal-content) > .movable-div").length) {

		var $scrollingDiv = jQuery("*:not(.modal-content) > .movable-div");

		function scrollingDivWidth() {
			if(jQuery(window).width() > 1024) {

				jQuery("*:not(.modal-content) > .movable-div").each(function(){
					var $scrollingDivWidth = jQuery(this).parent().width();
					jQuery(this).outerWidth($scrollingDivWidth);
				});
					
			}else {
				$scrollingDiv.outerWidth('auto');
			}
		}

		
		scrollingDivWidth();
		jQuery(window).resize(function(){
			scrollingDivWidth();
			scrollMovableDiv($scrollingDivPositionStart, $scrollingDiv);			
		});
		

		var headerTop = 0;
		if (jQuery('.custom-page-header.mobile-hide').css('position') == 'fixed' ) {
			var customPageHeight = jQuery('.custom-page-header.mobile-hide').outerHeight();	
			headerTop = jQuery('#header').outerHeight() + customPageHeight;
		}else {
			headerTop = jQuery('#header').outerHeight();
		}
			
		var $scrollingDivPositionStart = jQuery("*:not(.modal-content) > .movable-div").offset().top - headerTop - 22;
		var $scrollingDivPositionStartBottom =  1;

	

		function scrollMovableDiv($scrollingDivPositionStart, $scrollingDiv, $scrollingDivPositionStartBottom) {
			var windowScrollTop = jQuery(window).scrollTop();

			if ($scrollingDivPositionStart < windowScrollTop) {
				$scrollingDiv.addClass('fixed-movable-div');
			}else {
				$scrollingDiv.removeClass('fixed-movable-div');
			}


		}


		if(jQuery(window).width() > 1024) {
			scrollMovableDiv($scrollingDivPositionStart, $scrollingDiv);
		}

		jQuery(window).scroll(function(){
			if(jQuery(window).width() > 1024) {
				scrollMovableDiv($scrollingDivPositionStart, $scrollingDiv);			
			}
		});


	}




	if(jQuery(window).width() < 768) {
		jQuery('.panel-heading a').click();
	} else {
		jQuery(".event-list > li > img").hover(function(){
			jQuery(this).siblings("div.on-hover-content").stop().fadeIn( "fast", "linear" );
		}, function(){
			jQuery(this).siblings("div.on-hover-content").stop().fadeOut( "fast", "linear" );
		});
	}
	
	jQuery('.mainWrapp').on('click', '#orderBtn', function (e){
		e.preventDefault();
		var $this = jQuery(this);
		jQuery('#myCartModal').show();
	});

	jQuery('.mainWrapp').on('click', '.closeCartModal', function (e){
		e.preventDefault();
		jQuery(this).parents('.panel-fullscreen').hide();
	});

	jQuery('.custom-page-header a').click(function() {
		jQuery('.custom-page-header .active').removeClass('active');
		jQuery('.info-tab').hide();
		jQuery('.menu-tab').hide();
		jQuery('.review-tab').hide();
		jQuery(this).parent().addClass('active');
		jQuery(jQuery(this).data('target')).show();
	});
	var setStart;
	var setStart2;
	var setStart3;

	if( jQuery('.sidebar-menu-no-scroll').length ) {

	}else {
		jQuery('#menu-content li > a').click(function() {
			var el = jQuery(jQuery(this).parent().data('target'));
			var elId = el.attr('id');
			jQuery('#menu-content .active').removeClass('active');
			jQuery('#' + elId + 'ab').collapse('show');
			jQuery(this).parent().addClass('active');

			clearInterval(setStart);
			clearInterval(setStart2);
			clearInterval(setStart3);

			setStart =setTimeout(function(){
				jQuery('html,body').stop().animate({
				  scrollTop: el.offset().top - 180},
				  '500'
				);
				
			}, 100);

			setStart2 =setTimeout(function(){
				jQuery('html,body').stop().animate({
				  scrollTop: el.offset().top - 180},
				  '20'
				);
				
			}, 600);

			setStart3 =setTimeout(function(){
				jQuery('html,body').stop().animate({
				  scrollTop: el.offset().top - 180},
				  '20'
				);
				
			}, 900);


			

			return false
		});
	}
	
	jQuery("body").tooltip({
		selector: '[data-toggle="tooltip"]'
	});
	
	var showChar = 150;
	var ellipsestext = "...";
	var moretext = "more";
	var lesstext = "less";
	jQuery('.more').each(function() {
		var content = jQuery(this).html();

		if(content.length > showChar) {

			var c = content.substr(0, showChar);
			var h = content.substr(showChar-1, content.length - showChar);

			var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

			jQuery(this).html(html);
		}

	});

	jQuery(".morelink").click(function(){
		if(jQuery(this).hasClass("less")) {
			jQuery(this).removeClass("less");
			jQuery(this).html(moretext);
		} else {
			jQuery(this).addClass("less");
			jQuery(this).html(lesstext);
		}
		jQuery(this).parent().prev().toggle();
		jQuery(this).prev().toggle();
		return false;

	});



	if(typeof titlesProducts != "undefined") {
		

		jQuery('#productname').keyup(function(event){

			var thisVal = jQuery(this).val();
			thisVal = thisVal.toUpperCase();
			jQuery('.products-list li').hide();
			jQuery('.menu-nav li').removeClass('active');

			jQuery('.section-menu').hide();

			for (var i = 0; i < titlesProducts.length; i++) {
				var str = titlesProducts[i][1];
				str = str.toUpperCase();

				if (~str.indexOf(thisVal)) {
					var b = i;
					jQuery('.products-list li')[b].style.display="inline-block";

					jQuery('.products-list li')[b].parentElement.parentElement.parentElement.style.display="block";
				}
			}


			
		});
	}


	jQuery('.section-allergy-title').click(function(){
		jQuery(this).parent().toggleClass('active');
		jQuery(this).next().slideToggle();
	});





	//START menu scroll


	if(jQuery('.menu-page-no-scroll').length) {

	}else {
		if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
			jQuery('.mainWrapp_scroll').on("scroll", onScroll);
		}else {
			jQuery(document).on("scroll", onScroll);
		}
	}
	
	//smoothscroll
	jQuery('body').on('click', '.menu-nav-dropdown a', function (e) {
		e.preventDefault();
		if(jQuery('.menu-page-no-scroll').length) {
			menuFunctionNoScroll(jQuery(this));
		}else {
			menuFunction(jQuery(this));
		}
		
		jQuery('.menu-nav-dropdown').removeClass('open');
		jQuery('.menu-nav-more').removeClass('open');
	});
	jQuery('#top-menu a').on('click', function (e) {

		e.preventDefault();
		if(jQuery('.menu-page-no-scroll').length) {
			menuFunctionNoScroll(jQuery(this));
		}else {
			menuFunction(jQuery(this));
		}


	});


	function menuFunctionNoScroll(thisLi) {
		jQuery('.menu-nav li').removeClass('active');
		jQuery('.menu-nav-dropdown li').removeClass('active');
		thisLi.parent().addClass('active');
		var thisLiAttr = thisLi.attr('data-target');
		jQuery('.section-menu').hide();
		jQuery('.section-menu[data-idproduct="' + thisLiAttr + '"]').show();
		var menuTabPosition = jQuery('.menu-tab').offset().top - 150;
		if(menuTabPosition < jQuery(window).scrollTop()) {
			jQuery(window).scrollTop(menuTabPosition);
		}
	}



	function menuFunction(thisLi) {

		jQuery('.section-menu').show();
		jQuery('.products-list li').show();
		jQuery('#productname').val('');

		// jQuery('.menu-nav-dropdown li').removeClass('active');
		// jQuery('#top-menu li').removeClass('active');
		// thisLi.parent().addClass('active');
		var target = thisLi.attr('data-target'),
			menu = target;
		$target = jQuery('.section-menu[data-idproduct="' + target + '"]');


		var selectorName = jQuery('html, body');
		if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
			selectorName = jQuery('.mainWrapp_scroll');
		}

		var topScroll = jQuery('.header').outerHeight() + jQuery('.menu-nav-wrap-main').outerHeight() + 30;
		
		selectorName.stop().animate({
			'scrollTop': $target[0].offsetTop - topScroll
		}, 500, 'swing', function () {
			window.location.hash = target;


			if( jQuery('.mainWrapp_scroll').length && jQuery('.mainWrapp_scroll').width() < 1024 ) {
				jQuery('.mainWrapp_scroll').on("scroll", onScroll);
			}else {
				jQuery(document).on("scroll", onScroll);
			}


		});

	}

	function scrollHorizontalMenu(item) {
		var itemPosition = item.position().left;
		$('.menu-nav-wrap .baron__scroller').scrollLeft(itemPosition);

	}


	function onScroll(event){
		var scrollPos = jQuery(document).scrollTop();
		jQuery('#top-menu a').each(function () {




			var currLink = jQuery(this);
			var target = currLink.attr("data-target");
			var refElement = jQuery('.section-menu[data-idproduct="' + target + '"]');
			







			var topScroll = jQuery('.header').outerHeight() + jQuery('.menu-nav-wrap-main').outerHeight() + 40;

			var scrollPositon = refElement.position().top - topScroll;


			if (scrollPositon <= scrollPos && scrollPositon + refElement.outerHeight() > scrollPos) {
				if(currLink.parent().hasClass('active')) {

				}else {
					jQuery('#top-menu li').removeClass("active");
					currLink.parent().addClass("active");
					scrollHorizontalMenu(currLink.parent());
				}
			}
			else{
				currLink.parent().removeClass("active");
			}


			if(jQuery('#top-menu li.active').length == 0) {
				jQuery('#top-menu li:first-child').addClass("active");
			}

			jQuery('.menu-nav-dropdown li').removeClass('active');
			var attrActive = jQuery('#top-menu li.active a').attr("data-target");
			jQuery('.menu-nav-dropdown li a[data-target=' + attrActive + ']').parent().addClass('active');


			if( jQuery('#top-menu li.active').position().top ) {
				jQuery('.scroll-text').text(jQuery('#top-menu li.active').text());
				jQuery('.menu-nav-more').addClass('scroll-text-active');
			}else {
				jQuery('.scroll-text').text("");
				jQuery('.menu-nav-more').removeClass('scroll-text-active');
			}






		});
	}

	//END menu scroll


});


