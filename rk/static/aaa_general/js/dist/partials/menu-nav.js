// position menu
function menuNavFun() {
	let menuNavTop = $('.menu-nav-static-js').offset().top;
	let headerHeight = $('.main-header').outerHeight();
	let windowTop = $(window).scrollTop();
	let menuNavTopMain = menuNavTop - headerHeight;
	let widthMenuSub = $('.menu-nav-static-js').width();
	if(menuNavTopMain < windowTop ) {
		$('.menu-nav-wrap').css({
			'top': headerHeight, 
			'position': 'fixed',
			'width': widthMenuSub
		});
	}else {
		$('.menu-nav-wrap').css({
			'top': '0', 
			'position': 'relative',
			'width': 'auto'
		});
	}
}
$(window).resize(function() {
	if($('.menu-nav-static-js').length) {
		menuNavFun();
	}
});

if($('.menu-nav-static-js').length) {
	menuNavFun();
	$(window).scroll(function(){
		menuNavFun();
	});
}
// END position menu




//START menu scroll


$('.menu-nav li').on('click', function (e) {
	menuFunction($(this));
	e.preventDefault();
});


function menuFunction(thisLi) {

	$('#productname').val('');
	let target = thisLi.attr('data-target'),
		menu = target;
	$target = $('.section-menu[data-idproduct="' + target + '"]');

	let topScroll = $('.main-header').outerHeight() + $('.menu-nav-static-js').outerHeight() + 30;
	let sectionMenuPosition = $target.offset().top;

	console.log(sectionMenuPosition);
	console.log(topScroll);
	console.log(sectionMenuPosition - topScroll);

	$('html, body').stop().animate({
		'scrollTop': sectionMenuPosition - topScroll
	}, 500, 'swing', function () {
		window.location.hash = target;
		onScroll();
	});

}

function scrollHorizontalMenu(item) {
	let itemPosition = item.position().left;
	$('.menu-scroll').scrollLeft(itemPosition);
}


function onScroll(event){
	let scrollPos = $(window).scrollTop();
	let topScroll = $('.main-header').outerHeight() + $('.menu-nav-static-js').outerHeight() - $('.menu-img-top').outerHeight() + 30;
	$('.menu-nav li').each(function () {
		let currLink = $(this);
		let target = currLink.attr("data-target");
		let refElement = $('.section-menu[data-idproduct="' + target + '"]');
		let scrollPositon = refElement.position().top - topScroll;
		
		if (scrollPositon <= scrollPos) {
			if(currLink.hasClass('active')) {

			}else {
				$('.menu-nav li').removeClass("active");
				currLink.addClass("active");
				scrollHorizontalMenu(currLink);
			}
		}
		else{
			currLink.removeClass("active");
		}
		if($('.menu-nav li.active').length == 0) {
			$('.menu-nav li:first-child').addClass("active");
		}
	});
}


$(window).on("scroll", onScroll);

//END menu scroll
