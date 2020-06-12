$(document).ready(function() {
	$('.menu-wrap').click(function(){
		$('html').addClass('open-menu');
		$('.menu-bg').fadeIn(600);
		return false
	});
	$('.menu-close').click(function(){
		$('html').removeClass('open-menu');
		$('.menu-bg').fadeOut(600);
		return false
	});
	$('.slider').slick({
		dots: false,
		infinite: true,
		speed: 300,
		slidesToShow: 1,
		centerMode: true,
		variableWidth: true
	});


	function fuctionMenu() {
		var windowTop = $(window).scrollTop();
		if(windowTop > 10) {
			$('.main-header').addClass('header-fixed');
		}else {
			$('.main-header').removeClass('header-fixed');
		}
	}
	fuctionMenu();

	$(window).scroll(function(){
		fuctionMenu();
	});

});