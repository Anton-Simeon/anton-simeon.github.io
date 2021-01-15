jQuery(document).ready(function(){
	function winScrollFun() {
		var winScroll = jQuery(window).scrollTop();
		if(winScroll > 100) {
			jQuery('#home_logo img').width('63%');
		}else {
			jQuery('#home_logo img').width('100%');
		}
	}
	if(jQuery('.menu-page').length) {
		winScrollFun();
		jQuery(window).scroll(function(){
			winScrollFun();
		});
	}
});