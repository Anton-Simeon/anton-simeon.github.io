$('.menu-button-wrap').click(function(){
	$('html').toggleClass('menu-open');
});
function scrollHeader(){
	if($(document).scrollTop() > 20) {
		$('body').addClass('header-fixed');
	}else {
		$('body').removeClass('header-fixed');
	}
}
scrollHeader();
$(window).scroll(function(){
	scrollHeader();
});