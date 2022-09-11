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
	function modal(option) {
		if(stopModalFun == false) {
			if(option) {
				$('html').addClass('open-modal');
				setTimeout(function() {
					$('html').addClass('animate-modal');
				}, 200);
			}else {
				$('html').removeClass('animate-modal');
				setTimeout(function() {
					$('html').removeClass('open-modal');
				}, 900);

			}
			setTimeout(function() {
				stopModalFun = false;
			}, 800);
		}
		return false;
	};
	$('.modal-link').click(function(){
		modal(true);
		stopModalFun = true;
	})
	$('.modal-bg, .modal-close').click(function(){
		modal(false);
		stopModalFun = true;
	})
	// modal(true);
	// modal(false);
});