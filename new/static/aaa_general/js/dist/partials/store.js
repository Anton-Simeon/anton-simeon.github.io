

if($('.menu-nav-business-new-js').length){


	function showBusinessSidebar() {
		jQuery('.business-page').removeClass('no-sidebar-business-page');
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


	function menuNavBusinessNewJsClickFun(thisFun) {
		var companyId = jQuery('#companyId').val();
		var longitude = jQuery('#longitude').val();
		var latitude = jQuery('#latitude').val();
		var thisId = thisFun.attr('id');
		jQuery('.menu-nav-business-new-js a').removeClass('click');
		jQuery('.stores-list').html("");
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

	var companyId = $('#companyId').val();
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

					$('.menu-nav-business-new-js li:first-child').removeClass('click').hide();
					$('.menu-nav-business-new-js li:first-child a').removeClass('click');
					$('.menu-nav-business-new-js').append('<li><a href="#" class="click" id=' + response[0].id + '>' + response[0].name + '</a></li>');


					var thisLink = $('.menu-nav-business-new-js > li:nth-child(2) > a');
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
						$('.menu-nav-business-new-js').append('<li><a href="#" id=' + response[i].id + '>' + response[i].name + '</a></li>');

			
					}

				}
			}
			
		},
		error: function (error) {
		    console.log(error);
		},
		dataType: 'json'
	});









	var varClickRestname;




	jQuery('.business-restname-js').on('input',function(e){
		clearTimeout(varClickRestname);
		var thisInput = $(this);
		varClickRestname = setTimeout(function(){ 
			clickRestname(thisInput);
		}, 800);
	});


	function clickRestname(thisInput) {

		jQuery(".radio-option").each(function(i) {
			jQuery(this).removeClass('click');	
		});
		var restaurantName = thisInput.val();
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


	jQuery(document).on("scroll", onScrollAjax);

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


	function onScrollAjax() {


		console.log('assds');

		var st = jQuery(this).scrollTop();
	   	if (st > lastScrollTop && jQuery('#load-restaurant-link').length > 0){

	    	if (jQuery('#load-restaurant-link').isOnScreen() == true) {

	    		clearTimeout(timeout);  
	    		timeout = setTimeout(function() {
	    			oldLiCol = jQuery('.stores-list > li').length;

	    			if(oldLiCol != oldLiColNew) {
	    				oldLiColNew = jQuery('.stores-list > li').length;
		    			scrollAjax(oldLiCol);
		    		}
			   	}, 50);
			   	
	    	}
	   } else {
	   }
	   lastScrollTop = st;
	}


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


					var ratingText = '<div class="rating-section"><span><span class="branch-rate" id="branchRating-' + response[i].id + '" data-rate="' + averageReviewScore + '"></span></span> <span>' + reviewCount + '</span></div>';

					if(response[i].hasReviews == false) {
						ratingText = "";
					}


		    		varStore = varStore + '<li id="' + response[i].id + '" onclick="location.href=\'' + '/store/' + response[i].urlPath + '\';"><a href="' + '/store/' + response[i].urlPath + '" class="one-store"><div class="store-img-wrap-main"><div class="store-img-wrap"><div style="background-image: url(' + response[i].locationWebLogoUrl + ');"></div></div><span class="status-menu ' + openTextClass + '">' + openText + '</span></div><h2 class="store-title">' + response[i].name + '</h2>' + ratingText + '</a></li>';




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


	function pageBusinessFilter(pageBusinessFilterURL) {
		jQuery('.stores-list').html('');
		loadResuts(pageBusinessFilterURL);
	}

	
	jQuery('.business-search-button-close').click(function(){
		jQuery('.business-search-list').hide();
		jQuery('.business-search-button-close').hide();
		jQuery('.business-restname-js').val('');
		return false
	});







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



}
