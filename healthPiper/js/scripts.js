$(document).ready(function() {
	$('.header-btn').click(function(){
		$('body').toggleClass('active-menu');
	});
	$('.footer-top').click(function(){
		$("html, body").animate({ scrollTop: 0 }, 100);
	});
});