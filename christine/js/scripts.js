$(function() {
	
	function modal(option) {
		if(option) {
			$('html').addClass('open-modal');
			setTimeout(function() {
				$('html').addClass('animate-modal');
			}, 200);
		}else {
			$('html').removeClass('animate-modal');
			setTimeout(function() {
				$('html').removeClass('open-modal');
			}, 1200);

		}
		return false;
	};
	$('.modal-link').click(function(){
		modal(true);	
	})
	$('.modal-bg, .modal-close').click(function(){
		modal(false);	
	})
	// modal(true);
	// modal(false);
});