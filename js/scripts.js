$(document).ready(function() {


	 function functionLine() {
	 	var lineHeight = $('.line-bg-js').parent().outerHeight();
	 	var lineTop = $('.line-bg-js').css('top');
	 	lineTop = lineTop.substring(1, lineTop.length -2)
	 	lineTop = +lineTop;

	 	var newTop = 0 - lineTop - lineHeight;
		$('.line-bg-js2').css('top', newTop + "px");
	 }


	 $(window).on('load', function(){
	 	functionLine();
	});
	 $(window).on('resize', function(){
	 	functionLine();
	});










	$('.mouse').click(function(){

		var body = $("html, body");
		var heightBody = $('.section-hero').height() - 80;
		body.stop().animate({scrollTop: heightBody}, 500, 'swing', function() { 
		   // alert("Finished animating");
		});

		return false
	});

	$('.menu-btn').click(function(){
		$('html').addClass('open-menu');
		return false
	});

	$('.close-main-nav-mobile').click(function(){
		$('html').removeClass('open-menu');
		return false
	});

	function headerFun(scrollPos) {
		if(scrollPos > 10) {
			$('html').addClass('header-active');
		}else {
			$('html').removeClass('header-active');
		}
	}
	headerFun($(window).scrollTop());
	$(window).scroll(function(){
		headerFun($(window).scrollTop());
	});




	$('.hero-slider').slick({
	  dots: true,
	  arrows: false,
	  infinite: true,
	  speed: 300,
	  slidesToShow: 1,
	  slidesToScroll: 1
	});



	$('.slider-articles').slick({
	  dots: false,
	  infinite: true,
	  speed: 300,
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  responsive: [
	    {
	      breakpoint: 1200,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 1,
	        infinite: true,
	        dots: true
	      }
	    },
	    {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
	    // You can unslick at a given breakpoint now by adding:
	    // settings: "unslick"
	    // instead of a settings object
	  ]
	});



	$('.slider-partners').slick({
		dots: false,
		infinite: true,
		speed: 800,
		autoplay: true,
		autoplaySpeed: 1000,
		slidesToShow: 1,
		centerMode: true,
		variableWidth: true
	});





    function formPlaceholder(thisForm) {
        var thisValFormOpacity = thisForm.val();
        if(thisValFormOpacity == ' ') {
            thisValFormOpacity = thisForm.val('');
        }

        if(thisValFormOpacity != '') {
            thisForm.addClass('form-opacity-active');
        }else {
            thisForm.removeClass('form-opacity-active');
        }
    }
    $(window).on('load', function(){
        $('.input-style').each(function(){
            formPlaceholder($(this));
        });
    });
    $(document).on('blur', '.input-style', function (){
        formPlaceholder($(this));
    });
    $('.input-style').change(function(){
        formPlaceholder($(this));
    });


    $('.sort-item a').click(function() {
    	$('.title-sort').text($(this).text());
    	$('.sort-item').fadeOut(100);
    	return false
    });
    $('.sort-style').click(function() {
    	$('.sort-item').fadeToggle(100);
    	return false
    });


    $(document).mouseup(function (e){
		var div = $(".sort-wrap");
		if (!div.is(e.target)
		    && div.has(e.target).length === 0) {
			$('.sort-item').fadeOut(100);
		}
	});




})