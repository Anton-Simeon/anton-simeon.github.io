$(document).ready(function() {
	$('.slider-center').slick({
	  centerMode: true,
	  centerPadding: '110px',
	  slidesToShow: 1,
	  responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        arrows: true,
	        centerMode: true,
	        centerPadding: '68px',
	        slidesToShow: 1
	      }
	    },
	    {
	      breakpoint: 991,
	      settings: {
	        arrows: true,
	        centerMode: true,
	        centerPadding: '40px',
	        slidesToShow: 1
	      }
	    },
	    {
	      breakpoint: 575,
	      settings: {
	        arrows: true,
	        centerMode: true,
	        centerPadding: '0',
	        slidesToShow: 1
	      }
	    }
	  ]
	});

	$('.responsive').slick({
	  dots: false,
	  infinite: false,
	  speed: 300,
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        slidesToShow: 3,
	        slidesToScroll: 1,
	        infinite: true,
	        dots: false
	      }
	    },
	    {
	      breakpoint: 575,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 1
	      }
	    }
	    // You can unslick at a given breakpoint now by adding:
	    // settings: "unslick"
	    // instead of a settings object
	  ]
	});

	// window.onload = function() 
	// {	
	// 	$('.baron').each(function() {
	//  		baron({
	// 			root: $(this)[0],
	// 			scroller: '.baron__scroller',
	// 			bar: '.baron__bar'
	// 		}).autoUpdate();
	// 	})
	// };


	// popup
	$('[data-popup-title]').click(function(){
		var hrefPopup = $(this).attr('href');
		$(hrefPopup).show();
	});

	$('.close-popup').click(function(){
		$('[data-popup-content]').hide();
	});

	$('.popup-bg').click(function(){
		$('[data-popup-content]').hide();
	});
	$(document).keyup(function(e) {
		if (e.key === "Escape") { // escape key maps to keycode `27`
			$('[data-popup-content]').hide();
		}
	});




	$('.accordeon-title').click(function(){
		$(this).parent().toggleClass('open');
	});
	





	// function onScroll(event){
	// 	var scrollPos = jQuery('.baron-wrap .baron__scroller').scrollTop();
	// 	jQuery('#top-menu a').each(function () {
	// 		var currLink = jQuery(this);
	// 		var target = currLink.attr("data-target");
	// 		var refElement = jQuery('[data-idproduct="' + target + '"]');
			


	// 		var scrollPositon = refElement[0].offsetTop - 80;
	// 		// var scrollPositon = refElement.position().top;
	// 		console.log(scrollPositon);

	// 		if (scrollPositon <= scrollPos) {
	// 		// if(scrollPositon <= scrollPos ) {
	// 			jQuery('#top-menu li').removeClass("active");
	// 			jQuery('[data-idproduct]').removeClass("active");

	// 			refElement.addClass("active");
	// 			currLink.parent().addClass("active");

	// 			if(target > 5) {
	// 				$('.baron-wrap').outerWidth($('.box-content-basket').outerWidth() + 15);
	// 				$('.header-configuration-fixed').hide();
	// 			}else {
	// 				// $('.baron-wrap').outerWidth($('.box-content:not(.box-content-basket)').outerWidth() + 15);
	// 				$('.baron-wrap').attr('style', '');
	// 				$('.header-configuration-fixed').show();
	// 			}
	// 		}


	// 		if(jQuery('#top-menu li.active').length == 0) {
	// 			jQuery('#top-menu li:first-child').addClass("active");
	// 		}

	// 		jQuery('.menu-nav-dropdown li').removeClass('active');
	// 		var attrActive = jQuery('#top-menu li.active a').attr("data-target");
	// 		jQuery('.menu-nav-dropdown li a[data-target=' + attrActive + ']').parent().addClass('active');


	// 		if( jQuery('#top-menu li.active').position().top ) {
	// 			jQuery('.scroll-text').text(jQuery('#top-menu li.active').text());
	// 			jQuery('.menu-nav-more').addClass('scroll-text-active');
	// 		}else {
	// 			jQuery('.scroll-text').text("");
	// 			jQuery('.menu-nav-more').removeClass('scroll-text-active');
	// 		}


	// 	});
	// }

	// jQuery('.baron-wrap .baron__scroller').on("scroll", onScroll);



	// $('.header-configuration-fixed').click(function(){
	// 	$("[data-target='7']").click();
	// });
})