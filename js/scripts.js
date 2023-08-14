$(function() {
	let div = document.createElement('div');
	div.style.overflowY = 'scroll';
	div.style.width = '50px';
	div.style.height = '50px';
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

	$(document).on("click", "[data-mdl_link]", function (event) {
		var thisModal = $(this).attr('data-mdl_link');
		modal(true, thisModal);
		stopModalFun = true;

	})
	$('.modal-bg, .modal-close-js').click(function(){
		var thisModal = $(this).closest('.modal').attr('data-modal');
		modal(false, thisModal);
		stopModalFun = true;
	})

	$('.link-js').click(function(){
		if($('html').hasClass('open-modal')) {
			var thisModal = $('.modal:visible').attr('data-modal');
			modal(false, thisModal);
		}

		var body = $("html, body");
		var thisId = $(this).attr('href');
		var thisEl = $(thisId);
		console.log(thisEl.offset());
		var scrollPosition = thisEl.offset().top - 70;
		body.scrollTop(scrollPosition);
		return false
	});


});