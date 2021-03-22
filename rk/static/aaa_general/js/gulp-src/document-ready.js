$(function() {
$(".dropdown-language .dropdown-item").click(function(){
	setCookie("languageCookie", jQuery(this).attr('data-language'), 365);
	location.reload();
})
$(".clickable-row").click(function() {
	window.document.location = $(this).data("href");
});
if($('.lazyload').length) {
	lazyload();
}
$("[data-modal-ajax]").on('show.bs.modal', function (e) {

	// login, register, forgot password
	const modalsAuthorization = ['loginModal', 'forgotloginModal', 'registerModal'];
	let thisModalId = $(this).attr('id');
	for (var i = 0; i < modalsAuthorization.length; i++) {
		if(thisModalId == modalsAuthorization[i]) {
			if($('body').hasClass('modal-open')){
				$('.modal').modal('hide');
			}
		}
	}

	// ajax modal
	let link = $(e.relatedTarget);
	let thisModal = $(this);
	thisModal.addClass('spinner-active');


	if(link.length) {
		thisModal.find(".modal-content").load(link.attr("data-modal-href"), function(responseText, textStatus, XMLHttpRequest) {
			console.log('XMLHttpRequest.responseText');
			// console.log(XMLHttpRequest.responseText);
			thisModal.removeClass('spinner-active');
		});
	}

});

$("[data-modal-ajax]").on('hide.bs.modal', function (e) {
	$(this).find('.modal-content').html('');
	$(this).addClass('spinner-active');
});



});
