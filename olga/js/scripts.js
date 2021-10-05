$(document).ready(function () {
	$('.menu-btn').click(function () {
		$('html').addClass('open-menu');
		return false
	});

	$('.close-main-nav-mobile').click(function () {
		$('html').removeClass('open-menu');
		return false
	});

	function headerFun(scrollPos) {
		if (scrollPos > 10) {
			$('html').addClass('header-active');
		} else {
			$('html').removeClass('header-active');
		}
	}

	headerFun($(window).scrollTop());
	$(window).scroll(function () {
		headerFun($(window).scrollTop());
	});


	$('.slider').slick({
		dots: false,
		infinite: true,
		speed: 300,
		slidesToShow: 1,
		slidesToScroll: 1
	});


	function formPlaceholder(thisForm) {
		var thisValFormOpacity = thisForm.val();
		if (thisValFormOpacity == ' ') {
			thisValFormOpacity = thisForm.val('');
		}

		if (thisValFormOpacity != '') {
			thisForm.addClass('form-opacity-active');
		} else {
			thisForm.removeClass('form-opacity-active');
		}
	}

	$(window).on('load', function () {
		$('.input-style').each(function () {
			formPlaceholder($(this));
		});
	});
	$(document).on('blur', '.input-style', function () {
		formPlaceholder($(this));
	});
	$('.input-style').change(function () {
		formPlaceholder($(this));
	});


	$('.sort-item a').click(function () {
		$('.title-sort').text($(this).text());
		$('.sort-item').fadeOut(100);
		return false
	});
	$('.sort-style').click(function () {
		$('.sort-item').fadeToggle(100);
		return false
	});


	$(document).mouseup(function (e) {
		var div = $(".sort-wrap");
		if (!div.is(e.target)
			&& div.has(e.target).length === 0) {
			$('.sort-item').fadeOut(100);
		}
	});


})