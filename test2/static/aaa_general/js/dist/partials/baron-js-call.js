window.onload = function() 
{	
	
	if($('.wrap-table-scroll').length) {
 		baron({
			root: $('.wrap-table-scroll')[0],
			scroller: '.table-scroll',
			bar: '.table-scroll__bar',
			direction: 'h'
		}).autoUpdate();
	}

	if($('.wrap-menu-scroll').length) {
 		baron({
			root: $('.wrap-menu-scroll')[0],
			scroller: '.menu-scroll',
			bar: '.menu-scroll__bar',
			direction: 'h'
		}).autoUpdate();
	}

};

