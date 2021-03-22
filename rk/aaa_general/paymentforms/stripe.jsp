<!-- 	
	1. as soon as the Pay button is clicked, do an Ajax post to /stripe/checkout in local server:
		 POST /stripe/checkout
		 {
			"paymentGateway": "Stripe"
		 }
		 
			- We need to store the order in the database, before the payment is processed
		- We need to hit the API and check if the customer has recently processed a transaction. This is to avoid duplicates.
		
		RESPONSE:
		 {
			"paymentGateway": "Stripe",
			"duplicateTransaction": true,
			"customerDateCreated" : "2019-08-21 17:88:99"
		 }	  
		 
		 if duplicateTransaction is true, don't submit the call for payment processing by Stripe.
		 Instead show this message in a modal:
		 error.stripe.duplicateidempotencykey=You have already made a successful payment recently at {0}.If you want to process another payment for a new order click OK to proceed..  
				

-->
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.springframework.context.MessageSource" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="com.blueplustechnologies.core.model.Branch" %>
<%@ page import="com.blueplustechnologies.core.model.Customer" %>
<%@ page import="com.blueplustechnologies.core.model.CustomerOrder" %>
<%@ page import="com.blueplustechnologies.core.model.Menu" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethod" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegration" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegrationParam" %>
<%@ page import="com.blueplustechnologies.core.model.ShoppingCart" %>
<%@ page import="com.blueplustechnologies.core.paymentgateway.stripe.model.PaymentIntent" %>
<%@ page import="com.blueplustechnologies.core.paymentgateway.stripe.model.SetupIntent" %>
<%@ page import="com.blueplustechnologies.core.service.CustomerOrderService" %>
<%@ page import="com.blueplustechnologies.core.service.api.v1.BranchService" %>
<%@ page import="com.blueplustechnologies.core.paymentgateway.stripe.service.StripeService" %>
<%@ page import="com.blueplustechnologies.core.paymentgateway.stripe.service.StripeUserService" %>
<%@ page import="com.blueplustechnologies.core.paymentgateway.stripe.model.StripeUser" %>
<%@ page import="com.blueplustechnologies.core.util.DateUtil" %>
<%@ page import="com.blueplustechnologies.plastocart.util.CommonUtil" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<%@ page import="org.springframework.util.StringUtils" %>
<c:set var="currencyLocale" value="${defaultLocale}"></c:set>
<%!
	public void createCustomerOrder(ServletConfig config, CustomerOrder customerOrder, String paymentGateway) {
		WebApplicationContext springContext =  WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
		CustomerOrderService customerOrderService = (CustomerOrderService)springContext.getBean("customerOrderService");
		BranchService branchServiceV1 = (BranchService)springContext.getBean("branchServiceV1");
		
        Menu menu = (Menu) WebContextUtil.getSession().getAttribute("menu");
        Branch branch = branchServiceV1.findBranchByID(menu.getBranchId(), null);
		Customer customer = (Customer)WebContextUtil.getSession().getAttribute("customer");
		ShoppingCart shoppingCart = (ShoppingCart)WebContextUtil.getSession().getAttribute("shoppingcart");
		boolean firstCustomerOrder = !(customerOrderService.hasPlacedCustomerOrder(customer.getId())); 
		customerOrder.setFirstCustomerOrder(firstCustomerOrder);        			        			
		customerOrder.setOrderItems(shoppingCart.getItems());
		customerOrder.setOrderStatus("PENDING");
		
		if (Character.isDigit(customerOrder.getOrderTime().charAt(0))) { 
			customerOrder.setPreOrdered(true);
		} else {
			customerOrder.setPreOrdered(false);          
		}
		customerOrder.setOrderTime(customerOrder.getOrderDate() + " " + customerOrder.getOrderTime());
		customerOrder.setOrderDate(DateUtil.getCurrentDate(branch.getTimeZone()));
	
		customerOrder.setSitePreference("NORMAL");
		customerOrder.setPaymentGateway(paymentGateway);
		if (branch.getOrderConfirmationSetting().equals("ORDERCONFIRMATION")) {
				customerOrder.setOrderConfirmationStatus("PENDING");
		} else {
				customerOrder.setOrderConfirmationStatus("AUTOCONFIRMED");
		}
		customerOrder = customerOrderService.createCustomerOrder(customerOrder);
		WebContextUtil.getSession().setAttribute("customerorder", customerOrder);
	}
 %>
<%!
	private com.stripe.model.Customer findStripeCustomer(StripeUser stripeUser) throws com.stripe.exception.StripeException {
		// stripeCustomer = this.stripeServiceV1.findStripeCustomer(stripeUser.getStripeCustomerId(), paymentMethod.getId());
		com.stripe.model.Customer stripeCustomer = null;
		try {
			stripeCustomer = com.stripe.model.Customer.retrieve(stripeUser.getStripeCustomerId());
		} catch (Exception e) {
			
		}
		return stripeCustomer;
	}
%>
<%!
	private void setStripeAPIKey(PaymentMethod paymentMethod) {
		PaymentMethodIntegration paymentMethodIntegration = paymentMethod.getPaymentMethodIntegration();
		if (paymentMethodIntegration != null && paymentMethodIntegration.getPaymentMethodIntegrationParams() != null) {
			for (PaymentMethodIntegrationParam thisPaymentMethodIntegrationParam: paymentMethodIntegration.getPaymentMethodIntegrationParams()) {
				if (thisPaymentMethodIntegrationParam.getKey().equals("secret_api_key")) {
					com.stripe.Stripe.apiKey = thisPaymentMethodIntegrationParam.getValue().trim();
					break;
				}
			}
		}
	}
%>
<%
	WebApplicationContext springContext =  WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
	MessageSource messageSource = (MessageSource)springContext.getBean("messageSource");
	StripeService stripeServiceV1 = (StripeService)springContext.getBean("stripeServiceV1");
	StripeUserService stripeUserServiceV1 = (StripeUserService)springContext.getBean("stripeUserServiceV1");
	CustomerOrderService customerOrderService = (CustomerOrderService)springContext.getBean("customerOrderService");
	
	Customer customer = (Customer) WebContextUtil.getSession().getAttribute("customer");
	CustomerOrder customerOrder = (CustomerOrder) WebContextUtil.getSession().getAttribute("customerorder");
	PaymentMethod paymentMethod = (PaymentMethod) WebContextUtil.getSession().getAttribute("paymentmethod");
	
	setStripeAPIKey(paymentMethod);
	
	String publicApiKey = null;
	String connectAccount = null;
	boolean isDirectCharges = false;
	PaymentMethodIntegration paymentMethodIntegration = paymentMethod.getPaymentMethodIntegration();
	if (paymentMethodIntegration != null && paymentMethodIntegration.getPaymentMethodIntegrationParams() != null) {
		for (PaymentMethodIntegrationParam thisPaymentMethodIntegrationParam: paymentMethodIntegration.getPaymentMethodIntegrationParams()) {
			if (thisPaymentMethodIntegrationParam.getKey().equals("public_api_key")) {
				publicApiKey = thisPaymentMethodIntegrationParam.getValue();
			}
			if (thisPaymentMethodIntegrationParam.getKey().equals("direct_charges")) {
				isDirectCharges = Boolean.valueOf(thisPaymentMethodIntegrationParam.getValue());
			}
			if (thisPaymentMethodIntegrationParam.getKey().equals("connect_account")) {
				connectAccount = thisPaymentMethodIntegrationParam.getValue();
			}
		}
	}	
	
	boolean hasSavedCards = false;
	StripeUser stripeUser = stripeUserServiceV1.findStripeUserByCustomerID(customer.getId());
	com.stripe.model.Customer stripeCustomer = null;
	if (stripeUser != null && StringUtils.hasText(stripeUser.getStripeCustomerId())) {
		stripeCustomer = findStripeCustomer(stripeUser);
		if (stripeCustomer == null) {
			try {
				stripeUserServiceV1.deleteStripeUserByCustomerID(customer.getId());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	if (stripeCustomer != null) {
			
		Map<String, Object> cardParams = new LinkedHashMap<String, Object>();
		cardParams.put("customer", stripeCustomer.getId());
		cardParams.put("type", "card");
		com.stripe.model.PaymentMethodCollection paymentMethodCollection = com.stripe.model.PaymentMethod.list(cardParams);
		if (paymentMethodCollection.getData().size() > 0) {
			hasSavedCards = true;
			/** customer has saved cards, show saved cards */
			/** Do an Ajax GET /stripe/cards to get list of saved cards */
%>
	<div id="list-card">
		<a href="#" id="add_new_card"><div class="card-brand"></div><fmt:message key="info.card.addnewcard" /></a>
		<ul class="list-cards"></ul>
		<button id="btn_card_choice" type="button" class="btn btn-block btn-primary ajax-btn"><%= messageSource.getMessage("label.button.paybycard.standard", null, WebContextUtil.getDefaultLocale()) %> (<plastocart:fmcn locale="${currencyLocale}" value="${customerorder.subTotal}" />)</button>
		<div id="card-errors2" class="error show" role="alert"></div>
	</div>
	<script>
<%
	if (isDirectCharges && connectAccount != null) {
%>
	var stripe = Stripe('<%= publicApiKey %>', {stripeAccount:"<%=connectAccount%>"});
<%

	} else {
%>
	var stripe = Stripe('<%= publicApiKey %>');
<%
	}
%>
		var elements = stripe.elements({
			fonts: [
				{
					cssSrc: 'https://fonts.googleapis.com/css?family=Source+Code+Pro',
				},
			],
			// Stripe's examples are localized to specific languages, but if
			// you wish to have Elements automatically detect your user's locale,
			// use `locale: 'auto'` instead.
			locale: '<%= WebContextUtil.getDefaultLocale().getLanguage() %>'
		});

		jQuery.ajax({
			url: '/stripe/cards?companyId=<%= WebContextUtil.getCompanyId() %>',
			type: 'get',
			success: function( data, textStatus, jQxhr ){
				
				console.log(data.length);
				jQuery('.list-cards').html('');
				if(data.length) {
					var card = '';
					var classActive = '';
					for (var i = 0; i < data.length; i++) {
						console.log('data');
						if(i == 0) {
							classActive = 'active';
						}else {
							classActive = '';
						}
						card = card + '<li><div class="card-style card-style-js ' + classActive + '" data-card="' + data[i].id + '"><div class="card-brand"></div><h6>' + data[i].card.brand + '</h6><p>Ending ' + data[i].card.last4 + '</p></div>	<div class="delete-card delete-card-js" data-card="' + data[i].id + '"></div> </li>';
					}
					jQuery('.list-cards').html(card);
					if(card.length) {
						jQuery('#btn_card_choice').removeAttr('disabled');
					}
					
				}

				jQuery('.card-style-js').click(function(){
					jQuery('.card-style-js').removeClass('active');
					jQuery(this).addClass('active');
					jQuery('#btn_card_choice').removeAttr('disabled');
				});


				jQuery('.delete-card-js').click(function(){
					var payment_method_id = jQuery(this).attr('data-card');
					jQuery('#delete_card').attr('data-card', payment_method_id);
					jQuery('#delete_card').modal('show');

				});

				jQuery('#delete-card-modal').click(function(){
					var payment_method_id = jQuery('#delete_card').attr('data-card');
					jQuery.ajax({
						url: '/stripe/paymentmethods/' + payment_method_id + '?companyId=<%= WebContextUtil.getCompanyId() %>&paymentMethodID=' + <%= paymentMethod.getId() %>,
						type: 'DELETE',
						success: function( data, textStatus, jQxhr ){
							console.log(data);
						},
						error: function( jqXhr, textStatus, errorThrown ){
							console.log( errorThrown );
						}
					});
					if( jQuery('.card-style-js[data-card="' + payment_method_id + '"]').hasClass('active') || (jQuery('.card-style-js').length < 2) ){
						jQuery('#btn_card_choice').attr('disabled', 'disabled');
					}
					jQuery('.card-style-js[data-card="' + payment_method_id + '"]').parent().remove();
					jQuery('#delete_card').modal('hide');
				});
			},
			error: function( jqXhr, textStatus, errorThrown ){
				console.log( errorThrown );
			}
		});

		jQuery('#btn_card_choice').click(function(){
			var payment_method_id = jQuery('.card-style-js.active').attr('data-card');
			jQuery.ajax({
				url: '/stripe/paymentintents?companyId=<%= WebContextUtil.getCompanyId() %>', 
				dataType: 'json',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify({ payment_method_id: payment_method_id }),
				success: function( data, textStatus, jQxhr ){
					console.log(data);
					var clientSecret = data.clientSecret;
					stripe.handleCardPayment(
						clientSecret,
						{
							payment_method: payment_method_id,
						}
						).then(function(result) {
							if (result.error) {
								console.log(result.error);
								jQuery('#btn_card_choice').removeClass('disable-btn');
								document.getElementById('card-errors2').innerHTML = result.error.message;
								// Display error.message in your UI.
							} else {
								// The payment has succeeded. Display a success message.
								console.log('done');
								window.location.replace('/stripe/success?companyId=<%= WebContextUtil.getCompanyId() %>');	 

							}
						});
				},
				error: function( jqXhr, textStatus, errorThrown ){
					console.log( errorThrown );
				}
			});
		});
	</script>
<%
	SetupIntent setupIntent = (SetupIntent)stripeServiceV1.createSetupIntent(paymentMethod.getId()).getBody();
%>
<div id="new-card" style="display: none;">
	<a href="#" id="card-back"></a><div class="row"><div class="col-xs-12"><div class="field"><div id="example2-card-number" class="input empty"></div><label for="example2-card-number" data-tid="elements_examples.form.card_number_label"><fmt:message key="info.card.cardnumber" /></label><div class="baseline"></div></div></div></div><div class="row"><div class="col-xs-6"><div class="field"><div id="example2-card-expiry" class="input empty"></div><label for="example2-card-expiry" data-tid="elements_examples.form.card_expiry_label"><fmt:message key="info.card.expirydate" /></label><div class="baseline"></div></div></div><div class="col-xs-6"><div class="field"><div id="example2-card-cvc" class="input empty"></div><label for="example2-card-cvc" data-tid="elements_examples.form.card_cvc_label"><fmt:message key="info.card.cvc" /></label><div class="baseline"></div></div></div></div><button id="card-button" data-secret="<%= setupIntent.getClientSecret() %>"><%= messageSource.getMessage("info.card.savecard", null, WebContextUtil.getDefaultLocale()) %></button><div id="card-errors" class="error show" role="alert"></div>
</div>
<script type="text/javascript">
	jQuery('#add_new_card').click(function(){
		jQuery('#new-card').show();
		jQuery('#list-card').hide();
		return false
	});

	jQuery('#card-back').click(function(){
		jQuery('#new-card').hide();
		jQuery('#list-card').show();
		return false
	});

<%
    if (isDirectCharges && connectAccount != null) {
%>
	var stripe = Stripe('<%= publicApiKey %>', {stripeAccount:"<%=connectAccount%>"});
<%
    } else {
%>
	var stripe = Stripe('<%= publicApiKey %>');
<%
    }
%>
	var elements = stripe.elements({
		fonts: [
			{
				cssSrc: 'https://fonts.googleapis.com/css?family=Source+Code+Pro',
			},
		],
		// Stripe's examples are localized to specific languages, but if
		// you wish to have Elements automatically detect your user's locale,
		// use `locale: 'auto'` instead.
		locale: '<%= WebContextUtil.getDefaultLocale().getLanguage() %>'
	});
	// Floating labels
	var inputs = document.querySelectorAll('.cell.example.example2 .input');
	Array.prototype.forEach.call(inputs, function(input) {
		input.addEventListener('focus', function() {
			input.classList.add('focused');
		});
		input.addEventListener('blur', function() {
			input.classList.remove('focused');
		});
		input.addEventListener('keyup', function() {
			if (input.value.length === 0) {
				input.classList.add('empty');
			} else {
				input.classList.remove('empty');
			}
		});
	});
	var elementStyles = {
		hidePostalCode: true,
		base: {
			color: '#32325D',
			fontWeight: 500,
			fontFamily: 'Source Code Pro, Consolas, Menlo, monospace',
			fontSize: '16px',
			fontSmoothing: 'antialiased',
	
			'::placeholder': {
				color: '#CFD7DF',
			},
			':-webkit-autofill': {
				color: '#e39f48',
			},
		},
		invalid: {
			color: '#E25950',
	
			'::placeholder': {
				color: '#FFCCA5',
			},
		},
	};
	var elementClasses = {
		focus: 'focused',
		empty: 'empty',
		invalid: 'invalid',
	};
	var cardNumber = elements.create('cardNumber', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardNumber.mount('#example2-card-number');
	var cardExpiry = elements.create('cardExpiry', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardExpiry.mount('#example2-card-expiry');
	
	var cardCvc = elements.create('cardCvc', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardCvc.mount('#example2-card-cvc');
	jQuery('#paymentformgenerator').on('hide.bs.modal', function () {
		jQuery('#paymentformgenerator .invalid').removeClass('invalid');
		jQuery('#card-errors').text('');
		jQuery('#paymentformgenerator is-invalid').removeClass('is-invalid');
		jQuery('#paymentformgenerator input').val('');
	});

	var cardButton = document.getElementById('card-button');
	var clientSecret = cardButton.dataset.secret;
	cardButton.addEventListener('click', function(ev) {
		jQuery(this).addClass('disable-btn');
		jQuery(this).attr('disabled', 'disabled');

		paymentFun();
	});

	function paymentFun() {
		  stripe.handleCardSetup(
		    clientSecret, cardNumber, {
		      payment_method_data: {
		        billing_details: {name: cardNumber.value}
		      }
		    }
		  ).then(function(result) {
			if (result.error) {
				jQuery('#card-button').removeClass('disable-btn');
				jQuery('#card-button').removeAttr('disabled');
				document.getElementById('card-errors').innerHTML = result.error.message;
			} else {
				var payment_method_id = result.setupIntent.payment_method;
				console.log('payment_method_id');
				console.log(payment_method_id);
				jQuery.ajax({
					url: '/stripe/paymentmethods?companyId=<%= WebContextUtil.getCompanyId() %>', 
					dataType: 'json',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify({ payment_method_id: payment_method_id }),
					success: function( data, textStatus, jQxhr ){
						console.log('data');
						console.log(data);

						jQuery.ajax({
							url: '/stripe/cards?companyId=<%= WebContextUtil.getCompanyId() %>',
							type: 'get',
							success: function( data, textStatus, jQxhr ){
								
								console.log(data.length);
								jQuery('.list-cards').html('');
								if(data.length) {
									var card = '';
									var classActive = '';
									for (var i = 0; i < data.length; i++) {
										console.log('data');
										if(i == 0) {
											classActive = 'active';
										}else {
											classActive = '';
										}
										card = card + '<li style="padding-right: 0"><div class="card-style card-style-js ' + classActive + '" data-card="' + data[i].id + '"><div class="card-brand"></div><h6>' + data[i].card.brand + '</h6><p>Ending ' + data[i].card.last4 + '</p></div></li>';
									}
									jQuery('.list-cards').html(card);

									
									jQuery('#new-card').hide();
									jQuery('#list-card').show();
									jQuery('#add_new_card').hide();
									jQuery('#card-button').removeClass('disable-btn');
									jQuery('#card-button').removeAttr('disabled');
									jQuery('#btn_card_choice').removeAttr('disabled');

								}
								jQuery('.card-style-js').click(function(){
									jQuery('.card-style-js').removeClass('active');
									jQuery(this).addClass('active');
								});

							},
							error: function( jqXhr, textStatus, errorThrown ){
								console.log( errorThrown );
							}
						});
					},
					error: function( jqXhr, textStatus, errorThrown ){
						document.getElementById('card-errors').innerHTML = result.error.message;
					}
				});
			}
		});
	}
</script>
			<!--  Show saved cards modal here -->
<%			
		}
	} 
	
	if (stripeUser == null || !hasSavedCards) {
		
		if (!customerOrderService.transIDExists(customerOrder.getTransId())) {
			createCustomerOrder(config, customerOrder, "Stripe");
		}
		
		BigDecimal amount = customerOrder.getSubTotal().multiply(new BigDecimal("100"));
		amount.setScale(0, BigDecimal.ROUND_UP);
		
		PaymentIntent paymentIntent = new PaymentIntent();		
		paymentIntent.setAmount(String.valueOf(amount.toBigInteger()));
		paymentIntent.setDate(customerOrder.getOrderDate());			
		paymentIntent.setPaymentMethodID(paymentMethod.getId());
		paymentIntent.setCustomerID(customerOrder.getCustomerId());
		paymentIntent.setCustomerOrderID(customerOrder.getTransId());
		
		paymentIntent = (PaymentIntent)stripeServiceV1.createPaymentIntent(paymentIntent).getBody();
%>
<div class="row">
	<div class="col-xs-12">
		<div class="field">
			<div id="example2-card-number" class="input empty"></div>
			<label for="example2-card-number" data-tid="elements_examples.form.card_number_label"><fmt:message key="info.card.cardnumber" /></label>
			<div class="baseline"></div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xs-6">
		<div class="field">
			<div id="example2-card-expiry" class="input empty"></div>
			<label for="example2-card-expiry" data-tid="elements_examples.form.card_expiry_label"><fmt:message key="info.card.expirydate" /></label>
			<div class="baseline"></div>
		</div>
	</div>
	<div class="col-xs-6">
		<div class="field">
			<div id="example2-card-cvc" class="input empty"></div>
			<label for="example2-card-cvc" data-tid="elements_examples.form.card_cvc_label"><fmt:message key="info.card.cvc" /></label>
			<div class="baseline"></div>
		</div>
	</div>
	<div class="col-xs-12">
		<div class="form-group-checkbox">
			<input type="checkbox"  name="card-savecard" id="example2-card-savecard">
			<label for="example2-card-savecard" data-tid="elements_examples.form.save_card_label"><fmt:message key="info.card.savecard" /></label>
		</div>
	</div>	
	<div class="col-xs-12">
		<div class="stripe-text">
			<fmt:message key="info.card.savecardterms">
				<fmt:param value="${company.name}"/>
			</fmt:message>
		</div>
	</div>
</div>
<button id="card-button" data-secret="<%= paymentIntent.getClientSecret() %>"><%= messageSource.getMessage("label.button.paybycard.standard", null, WebContextUtil.getDefaultLocale()) %> (<plastocart:fmcn locale="${currencyLocale}" value="${customerorder.subTotal}" />)</button>
<div id="card-errors" class="error show" role="alert"></div>
<script type="text/javascript">
<%
	if (isDirectCharges && connectAccount != null) {
%>
	var stripe = Stripe('<%= publicApiKey %>', {stripeAccount:"<%=connectAccount%>"});
<%
	} else {
%>
	var stripe = Stripe('<%= publicApiKey %>');
<%
	}
%>
	var elements = stripe.elements({
		fonts: [
			{
				cssSrc: 'https://fonts.googleapis.com/css?family=Source+Code+Pro',
			}
		],
		// Stripe's examples are localized to specific languages, but if
		// you wish to have Elements automatically detect your user's locale,
		// use `locale: 'auto'` instead.
		locale: '<%= WebContextUtil.getDefaultLocale().getLanguage() %>'
	});
	// Floating labels
	var inputs = document.querySelectorAll('.cell.example.example2 .input');
	Array.prototype.forEach.call(inputs, function(input) {
		input.addEventListener('focus', function() {
			input.classList.add('focused');
		});
		input.addEventListener('blur', function() {
			input.classList.remove('focused');
		});
		input.addEventListener('keyup', function() {
			if (input.value.length === 0) {
				input.classList.add('empty');
			} else {
				input.classList.remove('empty');
			}
		});
	});
	var elementStyles = {
		hidePostalCode: true,
		base: {
			color: '#32325D',
			fontWeight: 500,
			fontFamily: 'Source Code Pro, Consolas, Menlo, monospace',
			fontSize: '16px',
			fontSmoothing: 'antialiased',
	
			'::placeholder': {
				color: '#CFD7DF',
			},
			':-webkit-autofill': {
				color: '#e39f48',
			},
		},
		invalid: {
			color: '#E25950',
	
			'::placeholder': {
				color: '#FFCCA5',
			},
		},
	};
	var elementClasses = {
		focus: 'focused',
		empty: 'empty',
		invalid: 'invalid',
	};
	var cardNumber = elements.create('cardNumber', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardNumber.mount('#example2-card-number');
	var cardExpiry = elements.create('cardExpiry', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardExpiry.mount('#example2-card-expiry');
	
	var cardCvc = elements.create('cardCvc', {
		style: elementStyles,
		classes: elementClasses,
	});
	cardCvc.mount('#example2-card-cvc');
	jQuery('#paymentformgenerator').on('hide.bs.modal', function () {
		jQuery('#paymentformgenerator .invalid').removeClass('invalid');
		jQuery('#card-errors').text('');
		jQuery('#paymentformgenerator is-invalid').removeClass('is-invalid');
		jQuery('#paymentformgenerator input').val('');
	});

	var cardButton = document.getElementById('card-button');
	var clientSecret = cardButton.dataset.secret;
	cardButton.addEventListener('click', function(ev) {
		jQuery(this).addClass('disable-btn');
		jQuery(this).attr('disabled', 'disabled');

		paymentFun();
	});
	function paymentFun() {
		stripe.handleCardPayment(
			clientSecret, cardNumber, {}
		).then(function(result) {
			if (result.error) {
				jQuery('#card-button').removeClass('disable-btn');
				jQuery('#card-button').removeAttr('disabled');
				document.getElementById('card-errors').innerHTML = result.error.message;
			} else {
				var saveCard = false;
				if (jQuery('#example2-card-savecard:checked').length) {
					saveCard = true;
				}
				jQuery.ajax({
					url: '/stripe/confirm_payment?companyId=<%= WebContextUtil.getCompanyId() %>', 
					dataType: 'text',
					type: 'post',
					contentType: 'application/json',
					data: JSON.stringify({ payment_method_id: result.paymentIntent.payment_method, save_card: saveCard }),
					success: function( data, textStatus, jQxhr ){
						console.log(data);
					},
					error: function( jqXhr, textStatus, errorThrown ){
						console.log( errorThrown );
					}
				});
				window.location.replace('/stripe/success?companyId=<%= WebContextUtil.getCompanyId() %>');	            
			}
		});
	}
</script>
<%
	}
%>