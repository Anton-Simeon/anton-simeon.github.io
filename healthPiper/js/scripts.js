$(document).ready(function() {
	$('.header-btn').click(function(){
		$('body').toggleClass('active-menu');
	});
	$('.footer-top').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 100);
	});
	$(window).scroll(function(){
		console.log('asdsa');
		if($(window).scrollTop() > $(window).height() ) {
			$('.footer-top').fadeIn();
		}else {
			$('.footer-top').fadeOut();
		}
	});
});