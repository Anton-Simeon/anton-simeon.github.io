<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="overall-review">
	<h2><label for="overall-message"><fmt:message key="label.reviews.overall" /></label></h2>
	<div class="overall-rating-section">
  		<div class="overall-review"><div id="overAllReview" ></div><span id="overallReviewText" class="review-value"></span></div>
  	</div>
</div>
<div class="review-list">
	<div class="reviews-header">
	  	<h3><span id="totalReviewCount"></span> <fmt:message key='label.reviews.reviewof' /> ${branch.name}</h3>
 	</div>
	<ul id="reviewList" class="ratings">
	</ul>
	<div id="load-reviews-link">
		<div id="loadingDiv" style="display: none;"><img src="/static/images/ajax-loader.gif" width="32" height="32"></div>
	</div>
</div>
<script src="/static/aaa_general/js/ajax_plugin.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/bluebird/latest/bluebird.min.js"></script>
<script type="text/javascript">

	var pagination = {
		offset : 0,
		limit : 30,
		total : 0,
		isReviewRequestIsInProgress : false
	};
	
	// Call this function to reload all reviews
	var loadReviewsList = (function(){
		return function(){
			if(pagination.total > pagination.offset && pagination.isReviewRequestIsInProgress === false) {
				pagination.isReviewRequestIsInProgress = true;
				getReviewsByPagination().then(function(resultHtml){
					if(jQuery(".mobile-show").is(":visible")) {
						jQuery(".mobile-show #reviewList").append(resultHtml)
					} else {
						jQuery("#reviewList").append(resultHtml)
					}
					pagination.offset += pagination.limit;
					formateDateForReviewList();
					pagination.isReviewRequestIsInProgress = false;
				});		
			}				
		}
	})();

	var getTotalReviewCount = (function(){
		return function(){
			return new Promise(function(resolve, reject){	
				sendAjaxRequest("GET", '/review/get-total-reviews-count', resolve, reject);
			});	
		}
	})();
	
	var getOverAllTotalReviews = (function(){
		return function(){
			return new Promise(function(resolve, reject){
				sendAjaxRequest("GET", '/review/get-over-all', resolve, reject);
			});	
		}
	})();
	
	var getReviewsByPagination = (function(){
		return function(){
			return new Promise(function(resolve, reject){
				sendAjaxRequest("GET", '/review/get-reviews', resolve, reject, pagination, {});
			});
		}
	})();
	
	var sendAjaxRequest = (function(){
		return function(requestType, requestUrl, resolve, reject, data){
			if(data === undefined) {
				data = {};
			}
			data["companyId"] = '${companyId}';
			var ajaxOptions = {
		    	type: requestType,
		    	url: requestUrl,
		    	data : data,
		    	success: function(response) {
		    		resolve(response);
		    	},
		    	error: reject,
		    	dataType: 'json'
		    };
			if(data) {
				ajaxOptions["dataType"] = undefined;
			}
			jQuery.ajax(ajaxOptions);
		}
	})();
	
	/** for add more reviews on scroll event*/
	var isOnScreen = function(selector, jqElem) {
		if(jqElem && jqElem.length == 0) {
			return false;
		}
    	var win = jQuery(window);
    	var viewport = {
	        top : win.scrollTop(),
	        left : win.scrollLeft()
	    };
	    viewport.right = viewport.left + win.width();
	    viewport.bottom = viewport.top + win.height();
	    if(jqElem === undefined) {
	    	jqElem = jQuery(selector)
	    }
	    var bounds = jqElem.offset();
	    bounds.right = bounds.left +  jqElem.outerWidth();
	    bounds.bottom = bounds.top +  jqElem.outerHeight();
	    
	    return (!(viewport.right < bounds.left || viewport.left > bounds.right || viewport.bottom < bounds.top || viewport.top > bounds.bottom));
	};
	
	/**
	*to init all request
	*/

	var initReviewPagination = (function(){
		return function(){


			var initPromises = [getTotalReviewCount(), getOverAllTotalReviews()];
			Promise.all(initPromises).then(function(reviewInitData){
				var totalReviewCount = reviewInitData[0].totalReviewCount; //{totalReviewCount : 102}
				var allAverageReview = reviewInitData[1]; // {overAllAverage : 3.5, foodQualityAverage  : 3.5, deliveryServiceAverage: 3.5, valueForMoneyAverage : 3.5}
				pagination.total = totalReviewCount;
				//jQuery("#foodQuality").html(allAverageReview.foodQualityAverage);
				//jQuery("#valueForMoney").html(allAverageReview.valueForMoneyAverage);
				//jQuery("#deliveryService").html(allAverageReview.deliveryServiceAverage);
				var overrALLrattingBar = jQuery("#overAllReview");
				var overAllReviewHeader = jQuery("#overAllReviewHeader");
				var totalReviewCountDiv = jQuery("#totalReviewCount");
				var overallReviewText = jQuery("#overallReviewText");
				var headerTotalReviewCount = jQuery("#headerTotalReviewCount");
				if(jQuery(".mobile-show").is(":visible")) {
					overrALLrattingBar = jQuery(".mobile-show #overAllReview");
					overAllReviewHeader = jQuery(".mobile-show #overAllReviewHeader");
					overAllReviewHeader = jQuery(".mobile-show #overAllReviewHeader");
					headerTotalReviewCount = jQuery(".mobile-show #headerTotalReviewCount");
					
					totalReviewCountDiv = jQuery(".mobile-show #totalReviewCount");
					overallReviewText = jQuery(".mobile-show #overallReviewText");
				}
				
				overallReviewText.html(allAverageReview.overAllAverage +"/5");
				headerTotalReviewCount.html(totalReviewCount);
				if(totalReviewCount == 0 || totalReviewCount == '0') {
					jQuery('#overAllReview').hide();
					jQuery('#overallReviewText').hide();
					jQuery('#overAllReviewHeader').hide();
					jQuery('#headerTotalReviewCount').hide();
				}
				overrALLrattingBar.rateYo({
					rating: allAverageReview.overAllAverage,
					readOnly: true,
					starWidth: "36px"
				});
				
				overAllReviewHeader.rateYo({
					rating: allAverageReview.overAllAverage,
					readOnly: true,
					starWidth: "14px"
				});
				
				totalReviewCountDiv.html(totalReviewCount)
				loadReviewsList(); // to load first 30 reviews				
			});
		}
	})();
	jQuery(document).ready(function(){
		initReviewPagination();	
		var timeout;
		var lastScrollTop = 0;
		var oldLink = "";
		var element = "";
		jQuery(window).scroll(function() {
			var st = jQuery(this).scrollTop();
		   	if (st > lastScrollTop) {
		   		if(jQuery(".mobile-show").is(":visible")) {
					element = jQuery('.mobile-show #reviewList').children('li').last();
				} else {
					element = jQuery('#reviewList').children('li').last();
				}
		   		if (isOnScreen(undefined, element)) {
		    		clearTimeout(timeout);  
			    	timeout = setTimeout(function() {
			    		loadReviewsList();
				   	}, 50);
		    	}
		   }
		   lastScrollTop = st;
		});
	})
	var formateDateForReviewList = (function(){
		return function(){
			jQuery(".order-date-no-done").each(function(){
				var date = jQuery(this).html();
				var orderDate = (date.substring(0, 10)).split("-");
				jQuery(this).html(orderDate[2]+"/"+orderDate[1]+"/"+orderDate[0]);
				jQuery(this).removeClass("order-date-no-done");
			})
		}
	})();
	
	jQuery(document).ready(function() {
		var loading = jQuery("#loadingDiv");
		if(jQuery(".mobile-show").is(":visible")) {
			loading = jQuery(".mobile-show #loadingDiv");
		}
	    jQuery(document).ajaxStart(function () {
	        loading.show();
	    });
	
	    jQuery(document).ajaxStop(function () {
	        loading.hide();
	    });
	});
</script>