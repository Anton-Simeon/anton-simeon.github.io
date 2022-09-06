$(function() {
	$( window ).scroll(function() {
	  var scrollPosition = $( window ).scrollTop();
	  var windowHeight = $( window ).height();
	  var maxOffset = 250;

	  var marginTop =  (maxOffset / windowHeight) * scrollPosition - 40;
	 $('.hero-img > div').css('margin-top', marginTop);

	});
});