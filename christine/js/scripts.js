$(function() {

	let div = document.createElement('div');

	div.style.overflowY = 'scroll';
	div.style.width = '50px';
	div.style.height = '50px';

	// мы должны вставить элемент в документ, иначе размеры будут равны 0
	document.body.append(div);
	let scrollWidth = div.offsetWidth - div.clientWidth;

	div.remove();
	$('html').attr('style', '--scroll:' + scrollWidth + 'px');


	var stopModalFun = false;
	function modal(option, thisModal) {
		if(stopModalFun == false) {
			if(option) {
				$('html').addClass('open-modal');
				$("[data-modal=" + thisModal + "]").show();
				setTimeout(function() {
					$('html').addClass('animate-modal');
				}, 200);
			}else {
				$('html').removeClass('animate-modal');
				setTimeout(function() {
					$('html').removeClass('open-modal');
					$("[data-modal=" + thisModal + "]").hide();
				}, 900);

			}
			setTimeout(function() {
				stopModalFun = false;
			}, 800);
		}
		return false;
	};
	$('[data-mdl_link]').click(function(){
		var thisModal = $(this).attr('data-mdl_link');
		modal(true, thisModal);
		stopModalFun = true;
	})
	$('.modal-bg, .modal-close').click(function(){
		var thisModal = $(this).closest('.modal').attr('data-modal');
		modal(false, thisModal);
		stopModalFun = true;
	})

	$('.link-js').click(function(){
		var body = $("html, body");
		var thisId = $(this).attr('href');
		var thisEl = $(thisId);
		console.log(thisEl.offset());
		var scrollPosition = thisEl.offset().top - 70;
		body.scrollTop(scrollPosition);
		// body.stop().animate({scrollTop:scrollPosition}, {duration: 0, easing:"linear" } );
		return false
	});
});