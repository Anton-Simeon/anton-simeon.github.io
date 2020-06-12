jQuery(document).ready(function(){




	if(jQuery("#carousel").length) {
		var carousel = jQuery("#carousel").waterwheelCarousel({
			flankingItems: 1,
			startingItem: 1,
			autoPlay:5000,
			speed: 600,
			movedToCenter: function($newCenterItem) {
		      	var colNumber = $newCenterItem.prevAll().length + 1;
		      	jQuery('.carousel-nav li').removeClass('active');
		      	jQuery('.carousel-nav li:nth-child(' + colNumber + ')').addClass('active');
	    	}	
		});

		jQuery('.carousel-nav li').click(function(){
			var positionLiActive = jQuery('.carousel-nav li.active').prevAll().length;
			jQuery('.carousel-nav li').removeClass('active');
			jQuery(this).addClass('active');
			var positionLi = jQuery(this).prevAll().length + 1;
			carousel.reload({
				flankingItems: 1,
				speed: 600,
				autoPlay:5000,
				startingItem: positionLi,
				movedToCenter: function($newCenterItem) {
			      	var colNumber = $newCenterItem.prevAll().length + 1;
			      	jQuery('.carousel-nav li').removeClass('active');
			      	jQuery('.carousel-nav li:nth-child(' + colNumber + ')').addClass('active');
		    	}	
			});
		});
	}



	jQuery('.contatus-email-form label').each(function(){
		var labelText = jQuery(this).text();
		jQuery(this).next().attr('placeholder', labelText);
	})
	
	jQuery('.order-for-delivery').click(function(){
		jQuery(this).parent().hide();
		jQuery(this).parent().prev().show();
		return false
	});

	
	jQuery('.order-for-delivery2').click(function(){
		jQuery('.top-section-search-index').show();
		jQuery('.top-section-search-index').next().hide();
		jQuery('html, body').animate({scrollTop:0}, '500');
		return false
	});

	if( jQuery('.block1 .alert:not(.hidden)').length ) {
		jQuery('.block1').show();
		jQuery('.block2').hide();


	}

})