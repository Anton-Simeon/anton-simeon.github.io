$(".dropdown-language .dropdown-item").click(function(){
	setCookie("languageCookie", jQuery(this).attr('data-language'), 365);
	location.reload();
})