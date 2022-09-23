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

	$(document).on("click", "[data-mdl_link]", function (event) {
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
		// body.stop().animate({scrollTop:scrollPosition}, {duration: 0, easing:"linear" } );
		return false
	});


	$("#feedback").on('submit', function (e) {
		e.preventDefault();
		var datastring = $("#feedback").serialize();

		$.ajax({
			type: "POST",
			url: "form.php",
			data: datastring,
			success: function(data) {
				console.log(data);
				$('.form-style').addClass("form-sent");
				$('.form-style').prepend('<div class="form-text"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="css-1ah67su"><path fill="currentColor" fill-rule="evenodd" d="M12 2c5.5 0 10 4.5 10 10s-4.5 10-10 10S2 17.5 2 12 6.5 2 12 2zm0 2c-4.4 0-8 3.6-8 8s3.6 8 8 8 8-3.6 8-8-3.6-8-8-8zm4.3 4.3c.4-.4 1-.4 1.4 0 .4.4.4 1 0 1.4l-6 6c-.2.2-.5.3-.7.3-.2 0-.5-.1-.7-.3l-3-3c-.4-.4-.4-1 0-1.4.4-.4 1-.4 1.4 0l2.3 2.3z"></path></svg>Ihre Nachricht wurde erfolgreich gesendet</div>');
			},
			error: function() {
				console.log('error handling here');
			}
		});

		return false
	});


});