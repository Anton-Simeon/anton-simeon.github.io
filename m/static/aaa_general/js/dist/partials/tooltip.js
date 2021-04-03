$("#desktop_cart").on({
    mouseenter: function () {	
		let thisPositionTooltip = $(this).offset();
		let contentTooltip = $(this).attr('data-info');
		$('body').append('<div class="tooltip-content" style="left: ' + thisPositionTooltip.left + 'px; top: ' + thisPositionTooltip.top + 'px;">' + contentTooltip + '</div>');
    },
    mouseleave: function () {
        $('.tooltip-content').remove();
    }
},'.info-tooltip');