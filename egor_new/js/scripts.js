$(function() {
	$('.lazy').lazy();
	$('.header-slider').slick({
		dots: true,
		infinite: true,
		speed: 500,
		fade: true,
		autoplay: true,
		autoplaySpeed: 3000,
		cssEase: 'linear'
	});




	$('.countdown').each(function(){
		let counter = $(this);
		var day = +counter.find(".days").text();
		var hour = +counter.find(".hours").text();
		var minute = +counter.find(".minutes").text();
		var sec = +counter.find(".seconds").text();
		console.log(sec);
		var timeInterval = setInterval(function() {
			if(sec == 0 && minute == 0 && hour == 0 && day == 0) {
				clearInterval(timeInterval);
			}
			if(day > 9) {
				counter.find(".days").html(day);
			}else {
				counter.find(".days").html('0' + day);
			}

			if(hour > 9) {
				counter.find(".hours").html(hour);
			}else {
				counter.find(".hours").html('0' + hour);
			}

			if(minute > 9) {
				counter.find(".minutes").html(minute);
			}else {
				counter.find(".minutes").html('0' + minute);
			}


			if(sec > 9) {
				counter.find(".seconds").html(sec);
			}else {
				counter.find(".seconds").html('0' + sec);
			}

			sec--;
			if (sec == -1) {
				minute --;
				sec = 59;
				if (minute == -1) {
					hour --;
					minute = 59;
					if (hour == -1) {
						day --;
						hour = 23;
						if (day == -1) {
							day == 0;
						}
					}
				}
			}


		}, 1000);
	});



});