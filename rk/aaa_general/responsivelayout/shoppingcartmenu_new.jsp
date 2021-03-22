<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<c:set var="checkOutUrl"><fmt:message key='url.path.checkout' /></c:set>

<div id="menu-cart" class="menu-cart">
	<div class="pre-order-js" style="display: none;">
	</div>
	<div class="now-order-js" style="display: none;">
	</div>
	<c:choose>
		<c:when test="${company.companySetting != null and company.companySetting.enableDriverTip == true}">
			<c:choose>
				<c:when test="${not empty shoppingcart.items}">
					<div class="driver-tip-js driver-tip-active" id="menu-cart-content">
				</c:when>
				<c:otherwise>
					<div class="driver-tip-js" id="menu-cart-content">
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<div id="menu-cart-content">
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${not empty shoppingcart.items}">
			<c:if test="${category == null}">
				<c:set var="thisCategoryId" value="${param.categoryId}" />
			</c:if>
			<c:if test="${category != null}">
				<c:set var="thisCategoryId" value="${category.id}" />
			</c:if>
			<c:set var="orderItems" value="${shoppingcart.items}" />
			<div id="pre-order-section">
				<div class="menu-type-tabs"></div>
				<ul class="radio-cart-wrap" style="display: none;">
					<li class="order-wrap-now-js" style="display: none;"><input type="radio" name="radio-cart" value="order-for-now" class="order-for-now-js"><label><fmt:message key='order.now' /></label></li>
					<li class="order-wrap-later-js" style="display: none;"><input type="radio" name="radio-cart" value="order-for-later" class="order-for-later-js"><label><fmt:message key='order.later' /></label></li>
				</ul>
				<div class="pre-order-section-new"></div>
			</div>
			<div id="desktop_cart">
				<div class="cart-top">
					<c:forEach var="thisOrderItem" items="${orderItems}">
						<plastocart:getcartmenuitemsresponsive orderItem="${thisOrderItem}" menu="${menu}" categoryId="${thisCategoryId}" />
					</c:forEach>
				</div>	
				<div class="cart-bottom">
					<input type="hidden" id="product-price-js" value="${shoppingcart.value}">
					<div class="row cart-bottom-order">
						<div class="col">
							<div class="cart-order-total"><fmt:message key='label.ordertotal' /></div>
						</div>
						<div class="col-auto">
							<div class="cart-value value-js">
								<plastocart:fmcn locale="${defaultLocale}" value="${shoppingcart.value}" />
							</div>
						</div>
					</div>
					<form action="/${checkOutUrl}" method="post" class="checkOutForm" id="checkOutForm" >
						<input type="hidden" name="checkout" value="yes" /> 
						<input type="hidden" name="orderDate" id="orderDate"/>
						<input type="hidden" name="orderTime" id="orderTime" />
						<input type="hidden" name="orderType" id="orderType"/>
						<input type="hidden" class="orderForNow-input-js" name="orderForNow" value="false" />
						<input type="hidden" class="orderForLater-input-js" name="orderForLater" value="false" />
						<input type="hidden" name="companyId" id="companyId" value="${companyId}">
						<input type="hidden" name="driverTip" class="driverTipVal" value="0.00" />
						<div class="d-grid">
							<button onclick="validateData(this);" type="button" class="btn btn-primary">
								<div class="cart-btn-img"></div><fmt:message key='label.button.checkout.responsive' />
							</button>
						</div>
					</form>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div id="pre-order-section">
				<div class="menu-type-tabs"></div>
				<ul class="radio-cart-wrap" style="display: none;">
					<li class="order-wrap-now-js" style="display: none;"><input type="radio" name="radio-cart" value="order-for-now" class="order-for-now-js"><label><fmt:message key='order.now' /></label></li>
					<li class="order-wrap-later-js" style="display: none;"><input type="radio" name="radio-cart" value="order-for-later" class="order-for-later-js"><label><fmt:message key='order.later' /></label></li>
				</ul>
				<div class="pre-order-section-new"></div>
			</div>
			<div id="desktop_cart">
				<div class="cart-empty">
					<div class="cart-empty-img"></div>
					<p><fmt:message key='label.cartempty' /></p>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	<div class="driver-tip-wrap">
		<div class="driver-tip-text">
			<h5><fmt:message key='label.tipdriver' /></h5>
		</div>
		<div class="driver-tip-links">
			<input type="hidden" name="driverTip" class="driverTip-js" value="${customerorder.driverTip}" />
			<div>
				<div class="driver-tip-link" data-tip="1">
					<div class="driver-tip-percent">10%</div>
					<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js10"></span></div>
				</div>
			</div>
			<div>
				<div class="driver-tip-link" data-tip="2">
					<div class="driver-tip-percent">15%</div>
					<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js15"></span></div>
				</div>
			</div>
			<div>
				<div class="driver-tip-link" data-tip="3">
					<div class="driver-tip-percent">20%</div>
					<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js20"></span></div>
				</div>
			</div>
			<div>
				<div class="driver-tip-link" data-tip="4">
					<div class="driver-tip-percent">25%</div>
					<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-js driver-tip-value-js25"></span></div>
				</div>
			</div>
			<div>
				<a href="#driver-tip-edit" data-tip="5" class="driver-tip-link driver-tip-edit-link" data-bs-toggle="modal" data-bs-target="#driver-tip-edit">
					<div class="driver-tip-edit"><fmt:message key='label.tipdriver.edit' /></div>
					<div class="driver-tip-percent"><fmt:message key='label.tipdriver.edit' /></div>
					<div class="driver-tip-value"><span class="driver-tip-symbol"></span> <span class="driver-tip-value-jsEdit"></span></div>
				</a>
			</div>
		</div>
	</div>
</div>


<script>


	function validateData(btnObject) {
		var that = $(btnObject).parents("form");
		$(that).find("#orderType").val($('.menu-type-tabs').find('.active').data('orderType'));
		$(that).find("#orderDate").val($("#selectDay").val());
		$(that).find("#orderTime").val($("#selectOrderTime").val());
		$(that).find(".driverTipVal").val($(".driverTip-js").val());
		if($("#menu-cart .order-for-now-js:checked").length) {
			$(that).find(".orderForNow-input-js").val('true');
		}else {
			$(that).find(".orderForNow-input-js").val('false');
		}
		if($("#menu-cart .order-for-later-js:checked").length) {
			$(that).find(".orderForLater-input-js").val('true');
		}else {
			$(that).find(".orderForLater-input-js").val('false');
		}
		return that.submit();
	}

	var ifModalOption = "${journeyState == null and company.deliveryZoneType == 'CITYPOLYGON'}";
	var customerorderOrderType = '${customerorder.orderType}';
	var customerorderOrderDate = '${customerorder.orderDate}';
	var customerorderOrderTime = '${customerorder.orderTime}';
	var customerorderOrderForNow = '${journeyState.orderForNow}';
	var customerorderOrderForLater = '${journeyState.orderForLater}';
	console.log('customerorderOrderForNow');
	console.log(customerorderOrderForNow);
	console.log('customerorderOrderForLater');
	console.log(customerorderOrderForLater);



	var labelClosed = "<fmt:message key='label.closed.CAPITAL' />";
	var selectClose = '<select id="selectDay" class="form-select" name="selectDay"><option value="-1">' + labelClosed + '</option></select>';
	var labelOffline = "<fmt:message key='label.store.offline' />";
	var selectOffline = '<select id="selectDay" class="form-select" name="selectDay"><option value="-1">' + labelOffline + '</option></select>';
	var responsiveText, nowBranchOpenForASAP, nowBranchOpenForPreOrdering, nowDeliveryOpenForASAP, nowDeliveryOpenForPreOrdering, nowCollectionOpenForASAP, nowCollectionOpenForPreOrdering, nowCurbSideOpenForASAP, nowCurbSideOpenForPreOrdering, nowCateringOpenForASAP, nowCateringOpenForPreOrdering, branchOnlineForASAP, branchOnlineForPreOrdering, deliveryOnlineForASAP, deliveryOnlineForPreOrdering, collectionOnlineForASAP, collectionOnlineForPreOrdering, curbSideOnlineForASAP, curbSideOnlineForPreOrdering, cateringOnlineForASAP, cateringOnlineForPreOrdering;


	var d = new Date();
	var mm = d.getMonth() + 1;
	var dd = d.getDate();
	var yy = d.getFullYear();

	if(mm < 10) {
		mm = "0" + mm;
	}
	if(dd < 10) {
		dd = "0" + dd;
	}

	var myDateString = yy + '-' + mm + '-' + dd;
	var responseAjaxPreorder = [];



	function funOrderTypeTabs(thisTab) {
		console.log('funOrderTypeTabs');
		$('.menu-type-tabs > *').removeClass('active');
		var dataOrderType = thisTab.attr('data-order-type');
		$('.menu-type-tabs > *[data-order-type="' + dataOrderType + '"]').addClass('active');
		var dataOrderType = thisTab.attr('data-order-type').toLowerCase();


		if($('.cart-empty').length) {
			$('.driver-tip-js').removeClass('driver-tip-active');
		}else {
			if(dataOrderType == "delivery" || dataOrderType == "catering") {
				$('.driver-tip-js').addClass('driver-tip-active');
			}else {
				$('.driver-tip-js').removeClass('driver-tip-active');

				var symbol = $('.symbol-js').text();
				var valProductPrice = $('#product-price-js').val();

				$('.driverTip-js').val(0);
				$('.driver-tip-link').removeClass('driver-tip-link-active');
				$('.value-js').text(symbol + valProductPrice);
				$('.value-js-mobile').text(symbol + valProductPrice);
			}
		}

		radioCartShow();
		var attrValRadio = thisTab.parent().next().find('input:checked').val();
		// if($('.radio-cart-wrap').is(':visible')){
			if(attrValRadio == 'order-for-now') {
				$('.pre-order-section-new').html($('.now-order-js .order-now-' + dataOrderType + ' .selectDay').clone().attr('id', 'selectDay'));
				$('.pre-order-section-new').append($('.now-order-js .order-now-' + dataOrderType + ' .selectOrderTime').clone().attr('id', 'selectOrderTime'));

				var thisVal = $('#selectOrderTime').val();
				var thisId = $('#selectOrderTime').find(':selected').attr('data-id');
				bookFun(thisVal, thisId);
			}
			if(attrValRadio == 'order-for-later') {
				var preOrderService = $('.pre-order-service[data-service="' + dataOrderType + '"] .selectDay').clone().attr('id', 'selectDay');
				var preOrderServiceTime = $('.pre-order-service[data-service="' + dataOrderType + '"] .selectDay').val();
				var preOrderServiceTimeClone;
				$('.pre-order-service[data-service="' + dataOrderType + '"] .selectOrderTime[data-time="' + preOrderServiceTime + '"]').each(function(i){
					if(i == 0) {
						// preOrderServiceTimeClone = thisTab.clone().attr('id', 'selectOrderTime');
						preOrderServiceTimeClone = $(this).clone().attr('id', 'selectOrderTime');
					}
				});
				$('.pre-order-section-new').html(preOrderService);
				$('.pre-order-section-new').append(preOrderServiceTimeClone);
				preOrderSectionSelect(dataOrderType);

			}
		// }
		if(dataOrderType == "delivery" || dataOrderType == "catering") {
			$('html').addClass('delivery-charge-menu-active');
		}else {
			$('html').removeClass('delivery-charge-menu-active');
		}

		var thisVal = $('#selectOrderTime').val();
		var thisId = $('#selectOrderTime').find(':selected').attr('data-id');
		if(thisId == undefined || thisId == null || thisId == 'null' || thisVal[0] == 'A') {
			bookFunClear(thisId);
		}
	}

	function preOrderSectionSelect(dataOrderType, response) {
		$('.pre-order-section-new .selectDay').change(function(){
			var preOrderSectionVal = $(this).val();
			$('.pre-order-service[data-service="' + dataOrderType + '"] .selectOrderTime[data-time="' + preOrderSectionVal + '"]').each(function(i){
				if(i == 0) {
					var preOrderNewTime = $(this).html();
					$('.pre-order-section-new .selectOrderTime').html(preOrderNewTime);
				}
			});

			var thisVal = $('#selectOrderTime').val();
			var thisId = $('#selectOrderTime').find(':selected').attr('data-id');
			bookFun(thisVal, thisId);

		});

		var thisVal = $('#selectOrderTime').val();
		var thisId = $('#selectOrderTime').find(':selected').attr('data-id');
		bookFun(thisVal, thisId);
	}

	function bookFunClear() {
	
		jQuery.ajax({
	    	type: "DELETE",
			url: '/preorderings/bookpreordertimeslot/clear?companyId=${company.id}',
			success: function(response) {
				console.log('response DELETE');
				console.log(response);
			},
			error: function(response){
				console.log('error! DELETE');
				console.log(response);
			}
		});
	}

	function bookFun(thisVal, thisId) {
		var dataJson;

		if(thisId != undefined && thisId != null && thisId.length && thisId != 'null') {
			for (var i = 0; i < responseAjaxPreorder.length; i++) {
				for (var b = 0; b < responseAjaxPreorder[i].length; b++) {

					for (var c = 0; c < responseAjaxPreorder[i][b].preOrderTimeSlots.length; c++) {

						if(responseAjaxPreorder[i][b].preOrderTimeSlots[c].id == thisId) {
							dataJson = responseAjaxPreorder[i][b].preOrderTimeSlots[c];
						}

					}

				}
			}
		}

		if(dataJson != undefined) {

			jQuery.ajax({
				headers: {
					Accept: "application/json",
					"Content-Type": "application/json"
				},
		    	type: "POST",
		    	data: JSON.stringify(dataJson),
		    	dataType: 'json',
				url: '/preorderings/bookpreordertimeslot',
				success: function(response) {
					console.log('response');
					console.log(response);
				},
				error: function(response){
					console.log('error!');
					console.log(response);
				}
			});
		}
	}

	function radioTabUser(thisTab) {
		if( customerorderOrderForNow == 'true' ) {
			$('#menu-cart-content').removeClass('cart-select2');
			thisTab.find('.order-for-now-js').prop("checked", true);
		}else if( customerorderOrderForLater == 'true' ) {
			$('#menu-cart-content').addClass('cart-select2');
			thisTab.find('.order-for-later-js').prop("checked", true);
		}
	}

	function radioCartShow() {

		var tabActive = $('.menu-type-tabs .active');
	    var dataOrderType = tabActive.attr('data-order-type').toLowerCase();
	    var thisTab = tabActive.parent().parent();

		if( $('.order-now-' + dataOrderType).length || $('.pre-order-js .pre-order-service[data-service="' + dataOrderType + '"]').length ) {
			thisTab.find('.radio-cart-wrap').show();
		}else {
			thisTab.find('.radio-cart-wrap').hide();
			var varOnlineForASAP;
			var varOnlineForPreOrdering;
			var nowOrderTypeOpenForASAP;
			var nowOrderTypeOpenForPreOrdering;

			if(dataOrderType == "delivery") {
				varOnlineForASAP = deliveryOnlineForASAP;
				varOnlineForPreOrdering = deliveryOnlineForPreOrdering;
				nowOrderTypeOpenForASAP = nowDeliveryOpenForASAP;
				nowOrderTypeOpenForPreOrdering = nowDeliveryOpenForPreOrdering;
			}
			if(dataOrderType == "collection") {
				varOnlineForASAP = collectionOnlineForASAP;
				varOnlineForPreOrdering = collectionOnlineForPreOrdering;
				nowOrderTypeOpenForASAP = nowCollectionOpenForASAP;
				nowOrderTypeOpenForPreOrdering = nowCollectionOpenForPreOrdering;

			}
			if(dataOrderType == "catering") {
				varOnlineForASAP = cateringOnlineForASAP;
				varOnlineForPreOrdering = cateringOnlineForPreOrdering;
				nowOrderTypeOpenForASAP = nowCateringOpenForASAP;
				nowOrderTypeOpenForPreOrdering = nowCateringOpenForPreOrdering;
			}
			if(dataOrderType == "curb-side") {
				varOnlineForASAP = curbSideOnlineForASAP;
				varOnlineForPreOrdering = curbSideOnlineForPreOrdering;
				nowOrderTypeOpenForASAP = nowCurbSideOpenForASAP;
				nowOrderTypeOpenForPreOrdering = nowCurbSideOpenForPreOrdering;
			}
			
			setTimeout(function(){

				if (nowOrderTypeOpenForASAP == "false" && nowOrderTypeOpenForPreOrdering == "false") {
					$('.pre-order-section-new').html(selectClose);
					$('#menu-cart-content').removeClass('cart-select2');
					// show closed
				} else if (varOnlineForASAP == "false" && varOnlineForPreOrdering == "false") {
					$('.pre-order-section-new').html(selectOffline);
					$('#menu-cart-content').removeClass('cart-select2');
					// show offline
				}

			}, 50);
		}

		if( $('.order-now-' + dataOrderType).length ) {
		    thisTab.find('.order-wrap-now-js').show();
			if(customerorderOrderDate) {
				console.log("customerorderOrderDate true");
				radioTabUser(thisTab);
			}else {
				console.log('order-for-now-js');
				thisTab.find('.order-for-now-js').prop("checked", true);
			}
		}else {
			thisTab.find('.order-wrap-now-js').hide();
			if(customerorderOrderDate) {
				console.log("customerorderOrderDate true");
				radioTabUser(thisTab);
			}else {
				console.log('order-for-later-js');
				thisTab.find('.order-for-later-js').prop("checked", true);
			}
		}
		if( $('.pre-order-js .pre-order-service[data-service="' + dataOrderType + '"]').length ) {
			thisTab.find('.order-wrap-later-js').show();
		}else {
			thisTab.find('.order-wrap-later-js').hide();
		}
	}

	function servicesPreOrder(service, service_first) {

		jQuery.ajax({
			type: "GET",
			url: '/preorderings/' + service + '/?branchID=${branch.id}&language=${defaultLocale.language}&companyId=${companyId}',
			success: function(response) {
				console.log('response');
				console.log(response);
				if(response.length) {
					responseAjaxPreorder.push(response);
				}
				if(response.length) {
					var selectDayPreOrderOption = '';
					var timeSelectOrder = '';
					var selectDayPreOrderDate;
					for (var i = 0; i < response.length; i++) {
						if(response[i].preOrderTimeSlots.length) {
							selectDayPreOrderDate = response[i].date.substr(-2);
							selectDayPreOrderDateMonth = response[i].date.substr(5, 2);
							selectDayPreOrderDate = +selectDayPreOrderDate;

							if(customerorderOrderForLater == "true" && customerorderOrderType == response[i].orderType && customerorderOrderDate == response[i].date) {
								selectDayPreOrderOption += '<option selected value="' + response[i].date + '">' + response[i].day + ', ' + selectDayPreOrderDateMonth + '/' + selectDayPreOrderDate + '</option>';	
							}else {
								selectDayPreOrderOption += '<option value="' + response[i].date + '">' + response[i].day + ', ' + selectDayPreOrderDateMonth + '/' + selectDayPreOrderDate + '</option>';	
							}
							
							var selectTimePreOrderOption = "";
							for (var b = 0; b < response[i].preOrderTimeSlots.length; b++) {

								if(customerorderOrderForLater == "true" && customerorderOrderType == response[i].orderType && customerorderOrderDate == response[i].date && response[i].preOrderTimeSlots[b].timeSlot == customerorderOrderTime) {
									selectTimePreOrderOption += '<option selected data-id="' + response[i].preOrderTimeSlots[b].id + '" value="' + response[i].preOrderTimeSlots[b].timeSlot + '">' + response[i].preOrderTimeSlots[b].timeSlot + '</option>';
								}else {
									selectTimePreOrderOption += '<option data-id="' + response[i].preOrderTimeSlots[b].id + '" value="' + response[i].preOrderTimeSlots[b].timeSlot + '">' + response[i].preOrderTimeSlots[b].timeSlot + '</option>';
								}

							}
							timeSelectOrder += '<select data-time="' + response[i].date + '" class="selectOrderTime form-select" name="selectOrderTime">' + selectTimePreOrderOption + '</select>';
						}
					}
					if(selectDayPreOrderOption != '') {
						var selectDayPreOrder = '<select class="selectDay form-select" name="selectDay">' + selectDayPreOrderOption + '</select>' + timeSelectOrder;
						$('.pre-order-js').append('<div data-service="' + service + '" class="pre-order-service">' + selectDayPreOrder + '</div>');
					}
					if(customerorderOrderType.length &&  customerorderOrderDate.length && customerorderOrderTime.length ) {
						if(customerorderOrderDate == myDateString) {

						}else {

							if(service == customerorderOrderType.toLowerCase()){

								var preOrderService = $('.pre-order-service[data-service="' + service + '"] .selectDay').clone().attr('id', 'selectDay');
								preOrderService.children('option[value="' + customerorderOrderDate + '"]').attr('selected', 'true');

								var preOrderServiceTime = customerorderOrderDate;
								var preOrderServiceTimeClone;
								$('.pre-order-service[data-service="' + service + '"] .selectOrderTime[data-time="' + preOrderServiceTime + '"]').each(function(i){
									if(i == 0) {
										preOrderServiceTimeClone = $(this).clone().attr('id', 'selectOrderTime');
										preOrderServiceTimeClone.children('option[value="' + customerorderOrderTime + '"]').attr('selected', 'true');
									}
								});
								$('.pre-order-section-new').html(preOrderService);
								$('.pre-order-section-new').append(preOrderServiceTimeClone);

								preOrderSectionSelect(service);
							}
						}
						
					}else {

						if(service_first) {
							var preOrderService = $('.pre-order-service[data-service="' + service + '"] .selectDay').clone().attr('id', 'selectDay');
							var preOrderServiceTime = $('.pre-order-service[data-service="' + service + '"] .selectDay').val();
							var preOrderServiceTimeClone;
							$('.pre-order-service[data-service="' + service + '"] .selectOrderTime[data-time="' + preOrderServiceTime + '"]').each(function(i){
								if(i == 0) {
									preOrderServiceTimeClone = $(this).clone().attr('id', 'selectOrderTime');
								}
							});
							$('.pre-order-section-new').html(preOrderService);
							$('.pre-order-section-new').append(preOrderServiceTimeClone);

							preOrderSectionSelect(service);
						}
					}
				}
				funOrderTypeTabs( $('#pre-order-section .menu-type-tabs .active') );
			},
			dataType: 'json'
		});
	}


	function changeRadio(changeRadioThis) {
		console.log('changeRadio');



		var dataOrderType = changeRadioThis.parent().parent().prev().children('.active').attr('data-order-type').toLowerCase();
		var attrValRadio = changeRadioThis.val();
		if(attrValRadio == 'order-for-now') {
			$('#menu-cart-content').removeClass('cart-select2');
			$('.pre-order-section-new').html($('.now-order-js .order-now-' + dataOrderType + ' .selectDay').clone().attr('id', 'selectDay'));
			$('.pre-order-section-new').append($('.now-order-js .order-now-' + dataOrderType + ' .selectOrderTime').clone().attr('id', 'selectOrderTime'));
		}
		if(attrValRadio == 'order-for-later') {
			$('#menu-cart-content').addClass('cart-select2');
			var preOrderService = $('.pre-order-service[data-service="' + dataOrderType + '"] .selectDay').clone().attr('id', 'selectDay');
			var preOrderServiceTime = $('.pre-order-service[data-service="' + dataOrderType + '"] .selectDay').val();
			var preOrderServiceTimeClone;
			$('.pre-order-service[data-service="' + dataOrderType + '"] .selectOrderTime[data-time="' + preOrderServiceTime + '"]').each(function(i){
				if(i == 0) {
					preOrderServiceTimeClone = $(this).clone().attr('id', 'selectOrderTime');
				}
			});
			$('.pre-order-section-new').html(preOrderService);
			$('.pre-order-section-new').append(preOrderServiceTimeClone);
			preOrderSectionSelect(dataOrderType);
		}

		var thisVal = $('#selectOrderTime').val();
		var thisId = $('#selectOrderTime').find(':selected').attr('data-id');
		if(thisId == undefined || thisId == null || thisId == 'null' || thisVal[0] == 'A') {
			bookFunClear(thisId);
		}
	}


	$(document).ready(function() {

		var symbol = $('.symbol-js').text();
		$('.driver-tip-symbol').text(symbol);

		var valProductPrice = $('#product-price-js').val();

		var valProductPrice10 = valProductPrice * 0.1;
		var valProductPrice15 = valProductPrice * 0.15;
		var valProductPrice20 = valProductPrice * 0.2;
		var valProductPrice25 = valProductPrice * 0.25;

		$('.driver-tip-value-js10').text(valProductPrice10.toFixed(2));
		$('.driver-tip-value-js15').text(valProductPrice15.toFixed(2));
		$('.driver-tip-value-js20').text(valProductPrice20.toFixed(2));
		$('.driver-tip-value-js25').text(valProductPrice25.toFixed(2));

		var driverTipValCache = $('#menu-cart-content .driverTip-js').val();
		if(driverTipValCache > 0) {
			var driverTip = false;
			$('.driver-tip-value-js').each(function(){
				var thisDriverTip = $(this);
				var thisText = thisDriverTip.text();
				thisText = +thisText;
				if(driverTipValCache == thisText) {
					thisDriverTip.closest('.driver-tip-link').addClass('driver-tip-link-active');
					driverTip = true;
				}
			});
			if(driverTip == false) {
				$('.driver-tip-edit-link').addClass('driver-tip-link-active');
				$('.driver-tip-value-jsEdit').text(driverTipValCache);
			}
		}


		$('body').on('click', 'div.driver-tip-link', function (){
			if($(this).hasClass('driver-tip-link-active')) {
				$(this).removeClass('driver-tip-link-active');
				var productPriceJs = $('#product-price-js').val();
				$('.value-js').text(symbol + productPriceJs);
				$('.driverTip-js').val(0);
			}else {
				$('.driver-tip-link').removeClass('driver-tip-link-active');

				var driverTipData = $(this).attr('data-tip');

				$('.driver-tip-link[data-tip="' + driverTipData + '"]').addClass('driver-tip-link-active');

				var tipVal = $(this).find('.driver-tip-value-js').text();
				tipVal = +tipVal;
				$('.driverTip-js').val(tipVal);
				var productPriceJs = $('#product-price-js').val();
				productPriceJs = +productPriceJs;
				var productPriceNew = tipVal + productPriceJs;
				productPriceNew = productPriceNew.toFixed(2);
				$('.value-js').text(symbol + productPriceNew);
				$('.value-js-mobile').text(symbol + productPriceNew);
			}
		});

		$('body').on('click', '#driver-tip-edit-button', function (){
			var driverTipVal = $('#driver-tip-edit-input').val();
			var productPriceJs = $('#product-price-js').val();
			if(driverTipVal > 0) {
				$('.driver-tip-value-jsEdit').text(driverTipVal);
				$('.driverTip-js').val(driverTipVal);


				driverTipVal = +driverTipVal
				productPriceJs = +productPriceJs;
				var priceWithTip = productPriceJs + driverTipVal;
				priceWithTip = priceWithTip.toFixed(2);

				$('.value-js').text(symbol + priceWithTip);
				$('.value-js-mobile').text(symbol + priceWithTip);


				$('.driver-tip-link').removeClass('driver-tip-link-active');
				$('.driver-tip-edit-link').addClass('driver-tip-link-active');
			}else {
				$('.driver-tip-value-jsEdit').text(0);
				$('.driverTip-js').val(0);

				$('.value-js').text(symbol + productPriceJs);
				$('.value-js-mobile').text(symbol + productPriceJs);
				$('.driver-tip-link').removeClass('driver-tip-link-active');
				$('.driver-tip-edit-link').addClass('driver-tip-link-active');
			}
			$('#driver-tip-edit').modal('hide');
			return false
		});



		$('body').on('change', '#selectOrderTime', function (){
			var thisVal = $(this).val();
			var thisId = $(this).find(':selected').attr('data-id');

			bookFun(thisVal, thisId);

			if(thisId == undefined || thisId == null || thisId == 'null') {
				bookFunClear(thisId);
			}

		});

		if($('.jsMinDeliveryAmount').text().length > 0) {
			$('html').addClass('delivery-charge-menu-active2');
			var symbol = $('.symbol-js').text();
			if(symbol == "€") {
				symbol = "€ ";
			}
			var textMinDeliveryAmount = $('.jsMinDeliveryAmount').text();
			textMinDeliveryAmount = symbol + textMinDeliveryAmount;
			$('.jsMinDeliveryAmount').text(textMinDeliveryAmount);
		}
		

		jQuery.ajax({
			type: "GET",
			url: '/branches/${branch.id}?&companyId=${companyId}',
			success: function(response) {

				if(response.services.length > 2) {
					$('#menu-cart-content').addClass('tabs-more2');
				}


				responsiveText = response;

				for (var i = 0; i < response.locationMetaDatas.length; i++) {
					if(response.locationMetaDatas[i].paramName == "nowBranchOpenForASAP") {
						nowBranchOpenForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowBranchOpenForPreOrdering") {
						nowBranchOpenForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowDeliveryOpenForASAP") {
						nowDeliveryOpenForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowDeliveryOpenForPreOrdering") {
						nowDeliveryOpenForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCollectionOpenForASAP") {
						nowCollectionOpenForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCollectionOpenForPreOrdering") {
						nowCollectionOpenForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCurbSideOpenForASAP") {
						nowCurbSideOpenForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCurbSideOpenForPreOrdering") {
						nowCurbSideOpenForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCateringOpenForASAP") {
						nowCateringOpenForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "nowCateringOpenForPreOrdering") {
						nowCateringOpenForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "branchOnlineForASAP") {
						branchOnlineForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "branchOnlineForPreOrdering") {
						branchOnlineForPreOrdering = response.locationMetaDatas[i].paramValue;
					}

					if(response.locationMetaDatas[i].paramName == "deliveryOnlineForASAP") {
						deliveryOnlineForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "deliveryOnlineForPreOrdering") {
						deliveryOnlineForPreOrdering = response.locationMetaDatas[i].paramValue;
					}

					if(response.locationMetaDatas[i].paramName == "collectionOnlineForASAP") {
						collectionOnlineForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "collectionOnlineForPreOrdering") {
						collectionOnlineForPreOrdering = response.locationMetaDatas[i].paramValue;
					}

					if(response.locationMetaDatas[i].paramName == "curbSideOnlineForASAP") {
						curbSideOnlineForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "curbSideOnlineForPreOrdering") {
						curbSideOnlineForPreOrdering = response.locationMetaDatas[i].paramValue;
					}

					if(response.locationMetaDatas[i].paramName == "cateringOnlineForASAP") {
						cateringOnlineForASAP = response.locationMetaDatas[i].paramValue;
					}
					if(response.locationMetaDatas[i].paramName == "cateringOnlineForPreOrdering") {
						cateringOnlineForPreOrdering = response.locationMetaDatas[i].paramValue;
					}
				}

				var statusText = "";


				if(nowBranchOpenForASAP == "true" && branchOnlineForASAP == "true") {
					statusText = "<i></i><fmt:message key='label.store.open' />"
				}else if(nowBranchOpenForPreOrdering == "true" && branchOnlineForPreOrdering == "true") {
					$('#statusText').addClass('status-menu-pre');
					statusText = "<i></i><fmt:message key='label.store.orderforlater' />"
				}else if(nowBranchOpenForASAP != "true" && nowBranchOpenForPreOrdering != "true") {
					$('#statusText').addClass('status-menu-close');
					statusText = "<i></i><fmt:message key='label.store.close' />"
				}else {
					// offline
					$('#statusText').addClass('status-menu-offline');
					statusText = "<i></i><fmt:message key='label.store.offline' />"
				}

				$('#statusText').html(statusText).css('opacity', 1);

				var preorder_has = false;
				var firstElem = 1;
				for (var i = 0; i < response.services.length; i++) {
					var service = response.services[i].orderType.toLowerCase();
					var tabClass = "";
					var varDeliveryCharge = false;
					if(response.services[i].active) {
						if( ( response.services[i].orderType == "DELIVERY" && nowDeliveryOpenForASAP == "true" && deliveryOnlineForASAP == "true") || ( response.services[i].orderType == "COLLECTION" && nowCollectionOpenForASAP == "true" && collectionOnlineForASAP == "true") || ( response.services[i].orderType == "CATERING" && nowCateringOpenForASAP == "true" && cateringOnlineForASAP == "true") || ( response.services[i].orderType == "CURB-SIDE" && nowCurbSideOpenForASAP == "true" && curbSideOnlineForASAP == "true") ) {
							var asapText = "<fmt:message key='asap.minutes' />";
							var systemAsapText = "<plastocart:system_message key='asap.minutes' />";
							asapText = asapText.replace('{0}', response.services[i].orderTime);
							systemAsapText = systemAsapText.replace('{0}', response.services[i].orderTime);
							
							var timeSelectOrderNow = '<div class="order-now-' + service + '"> <select class="selectDay d-none" name="selectDay"><option value="' + myDateString + '">' + myDateString + '</option></select> <select data-time="' + asapText + '" class="selectOrderTime form-select" name="selectOrderTime"><option value="' + systemAsapText + '">' + asapText + '</option></select> </div>';
							if(response.services[i].orderForNow) {
								$('.now-order-js').append(timeSelectOrderNow);
							}
						}

						if( ( response.services[i].orderType == "DELIVERY" && nowDeliveryOpenForPreOrdering == "true" && deliveryOnlineForPreOrdering == "true") || ( response.services[i].orderType == "COLLECTION" && nowCollectionOpenForPreOrdering == "true" && collectionOnlineForPreOrdering == "true") || ( response.services[i].orderType == "CATERING" && nowCateringOpenForPreOrdering == "true" && cateringOnlineForPreOrdering == "true") || ( response.services[i].orderType == "CURB-SIDE" && nowCurbSideOpenForPreOrdering == "true" && curbSideOnlineForPreOrdering == "true") ) {
							servicesPreOrder(service, false);
							preorder_has = true;
						}

						console.log(customerorderOrderType);
						console.log('active');
						if(customerorderOrderType.length) {
							if(response.services[i].orderType == customerorderOrderType) {
								tabClass = "active";
							}
						}else {
							if(firstElem == 1) {
								tabClass = "active";
							}
							firstElem = firstElem + 1;
						}
						
						var nameTab = response.services[i].orderType;
						if( response.services[i].orderType == 'COLLECTION') {
							nameTab = "<fmt:message key='COLLECTION' />";
						}
						if( response.services[i].orderType == 'DELIVERY') {
							nameTab = "<fmt:message key='DELIVERY' />";
						}
						if( response.services[i].orderType == 'CURB-SIDE') {
							nameTab = "<fmt:message key='CURB-SIDE' />";
						}
						if( response.services[i].orderType == 'CATERING') {
							nameTab = "<fmt:message key='CATERING' />";
						}
						$('.menu-type-tabs').append('<button data-order-type="' + response.services[i].orderType + '" class="' + tabClass + '">' + nameTab + '</button>');



						if(varDeliveryCharge == true) {
							if(response.services[i].orderType == "DELIVERY" || response.services[i].orderType == "CATERING") {
								$('html').addClass('delivery-charge-menu-active');
							}
						}

						if(  (response.services.length - 1) == response.services[i]  ) {
							funOrderTypeTabs( $('#pre-order-section .menu-type-tabs .active') );
						}
					}
				}

				if( preorder_has == false ) {
					
					if($('#pre-order-section .menu-type-tabs .active').length) {
						funOrderTypeTabs( $('#pre-order-section .menu-type-tabs .active') );
					}
				}
			},
			dataType: 'json'
		});

		var firstAjax = 1;
		$(document).ajaxStop(function() {
			if(firstAjax) {
				$('.shooping-panel').addClass('active-done');
				radioCartShow();
				firstAjax = firstAjax - 1;
			}
		});




		$('body').on('click', '.menu-type-tabs > *', function (){
			var valOrderType = $(this).attr('data-order-type');
			var minDeliveryAmountVal = 0;
			if($('#minDeliveryAmount').length) {
				minDeliveryAmountVal = $('#minDeliveryAmount').val().length;
			}

			if( (minDeliveryAmountVal == 0) && ifModalOption && (valOrderType == "DELIVERY" || valOrderType == "CATERING") ){
				if($('#addressPolygonModal').length) {
					$('#addressPolygonModal').modal('show');
					$('#addressPolygonModal').attr('date-tab', valOrderType);
				}else {
					funOrderTypeTabs($(this));
				}
				return false
			}
			funOrderTypeTabs($(this));
		});


		$('.radio-cart-wrap input').change(function(){
			changeRadio($(this));
		});


	});












</script>
