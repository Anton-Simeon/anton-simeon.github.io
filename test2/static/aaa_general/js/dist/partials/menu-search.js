if(typeof titlesProducts != "undefined") {
	

	jQuery('#productname').keyup(function(event){

		var thisVal = jQuery(this).val();
		thisVal = thisVal.toUpperCase();
		jQuery('.products-list li').hide();
		jQuery('.menu-nav li').removeClass('active');

		jQuery('.section-menu').hide();

		for (var i = 0; i < titlesProducts.length; i++) {
			var str = titlesProducts[i][1];
			str = str.toUpperCase();

			if (~str.indexOf(thisVal)) {
				var b = i;
				jQuery('.products-list li')[b].style.display="block";
				jQuery('.products-list li')[b].parentElement.parentElement.parentElement.style.display="block";
			}
		}


		
	});
}