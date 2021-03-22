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
<%@ page import="com.blueplustechnologies.core.model.PaymentMethod" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegration" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegrationParam" %>
<%@ page import="com.blueplustechnologies.core.model.ShoppingCart" %>
<%@ page import="com.blueplustechnologies.core.service.CustomerOrderService" %>
<%@ page import="com.blueplustechnologies.core.util.DateUtil" %>
<%@ page import="com.blueplustechnologies.plastocart.util.CommonUtil" %>
<%@ page import="java.util.Currency" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<%@ page import="org.springframework.util.StringUtils" %>
<c:set var="currencyLocale" value="${defaultLocale}"></c:set>
<%!
	public void createCustomerOrder(ServletConfig config, CustomerOrder customerOrder, String paymentGateway) {
		WebApplicationContext springContext =  WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
		CustomerOrderService customerOrderService = (CustomerOrderService)springContext.getBean("customerOrderService");
		
		Branch branch = (Branch)WebContextUtil.getSession().getAttribute("branch");
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
<%
	WebApplicationContext springContext =  WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
	MessageSource messageSource = (MessageSource)springContext.getBean("messageSource");
	CustomerOrderService customerOrderService = (CustomerOrderService)springContext.getBean("customerOrderService");
	
	String currencyCode = Currency.getInstance(WebContextUtil.getDefaultLocale()).getCurrencyCode();
	
	Customer customer = (Customer) WebContextUtil.getSession().getAttribute("customer");
	CustomerOrder customerOrder = (CustomerOrder) WebContextUtil.getSession().getAttribute("customerorder");
	PaymentMethod paymentMethod = (PaymentMethod) WebContextUtil.getSession().getAttribute("paymentmethod");
	PaymentMethodIntegration paymentMethodIntegration = paymentMethod.getPaymentMethodIntegration();
	String singleUseAPIToken = "";
	String environment = "";
	String accountNumber = "";
	if (paymentMethodIntegration != null && paymentMethodIntegration.getPaymentMethodIntegrationParams() != null) {
		for (PaymentMethodIntegrationParam thisPaymentMethodIntegrationParam: paymentMethodIntegration.getPaymentMethodIntegrationParams()) {
			if (thisPaymentMethodIntegrationParam.getKey().equals("single_use_token")) {
				singleUseAPIToken = thisPaymentMethodIntegrationParam.getValue().trim();
			}
			if (thisPaymentMethodIntegrationParam.getKey().equals("environment")) {
				environment = thisPaymentMethodIntegrationParam.getValue().trim();
			}
			if (thisPaymentMethodIntegrationParam.getKey().equals("account_number")) {
				accountNumber = thisPaymentMethodIntegrationParam.getValue().trim();
			}			
		}
	}
	
	if (!customerOrderService.transIDExists(customerOrder.getTransId())) {
		createCustomerOrder(config, customerOrder, "PaySafe");
	}
%>
<html>
	<head>
		<!-- include the Paysafe.js SDK -->
		<script src="https://hosted.paysafe.com/js/v1/latest/paysafe.min.js"></script>
		<script src="https://hosted.paysafe.com/threedsecure/js/latest/paysafe.threedsecure.min.js"></script>			
		<!-- external style for the payment fields.internal style must be set using the SDK -->
	</head>
	<body>
		<div id="new-card">
			<a href="#" id="card-back" style="display: none;"></a>
			<!-- Create divs for the payment fields -->
			<div class="field-paysafe">
				<div id="cardNumber" class="field-iframe"></div>
				<div class="field-iframe-label">Card number</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<div class="field-paysafe">
						<div id="expiryDate" class="field-iframe"></div>
						<div class="field-iframe-label">Expiry date</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="field-paysafe">
						<div id="cvv" class="field-iframe"></div>
						<div class="field-iframe-label">CVV</div>
					</div>
				</div>
			</div>
			<div class="field-paysafe">
				<div class="field-iframe">
					<input type="text" id="cardHolderName" class="field-iframe-input input" name="cardHolderName">
				</div>
				<div class="field-iframe-label">Card Holder Name</div>
			</div>
			<div class="field-paysafe">
				<div class="field-iframe">
					<input type="text" id="billingPostcode" class="field-iframe-input input" name="billingPostcode">
				</div>
				<div class="field-iframe-label">Billing Postcode</div>
			</div>
			<div class="field-paysafe">
				<div class="field-iframe field-iframe-focus">
					<select id="billingCountry" class="field-iframe-input input" name="billingCountry">
						<option value="-1" selected="" disabled="">Select please</option>
						<option value="AF">Afghanistan</option>
						<option value="AX">Åland Islands</option>
						<option value="AL">Albania</option>
						<option value="DZ">Algeria</option>
						<option value="AS">American Samoa</option>
						<option value="AD">Andorra</option>
						<option value="AO">Angola</option>
						<option value="AI">Anguilla</option>
						<option value="AQ">Antarctica</option>
						<option value="AG">Antigua and Barbuda</option>
						<option value="AR">Argentina</option>
						<option value="AM">Armenia</option>
						<option value="AW">Aruba</option>
						<option value="AU">Australia</option>
						<option value="AT">Austria</option>
						<option value="AZ">Azerbaijan</option>
						<option value="BS">Bahamas</option>
						<option value="BH">Bahrain</option>
						<option value="BD">Bangladesh</option>
						<option value="BB">Barbados</option>
						<option value="BY">Belarus</option>
						<option value="BE">Belgium</option>
						<option value="BZ">Belize</option>
						<option value="BJ">Benin</option>
						<option value="BM">Bermuda</option>
						<option value="BT">Bhutan</option>
						<option value="BO">Bolivia, Plurinational State of</option>
						<option value="BQ">Bonaire, Sint Eustatius and Saba</option>
						<option value="BA">Bosnia and Herzegovina</option>
						<option value="BW">Botswana</option>
						<option value="BV">Bouvet Island</option>
						<option value="BR">Brazil</option>
						<option value="IO">British Indian Ocean Territory</option>
						<option value="BN">Brunei Darussalam</option>
						<option value="BG">Bulgaria</option>
						<option value="BF">Burkina Faso</option>
						<option value="BI">Burundi</option>
						<option value="KH">Cambodia</option>
						<option value="CM">Cameroon</option>
						<option value="CA">Canada</option>
						<option value="CV">Cape Verde</option>
						<option value="KY">Cayman Islands</option>
						<option value="CF">Central African Republic</option>
						<option value="TD">Chad</option>
						<option value="CL">Chile</option>
						<option value="CN">China</option>
						<option value="CX">Christmas Island</option>
						<option value="CC">Cocos (Keeling) Islands</option>
						<option value="CO">Colombia</option>
						<option value="KM">Comoros</option>
						<option value="CG">Congo</option>
						<option value="CD">Congo, the Democratic Republic of the</option>
						<option value="CK">Cook Islands</option>
						<option value="CR">Costa Rica</option>
						<option value="CI">Côte d'Ivoire</option>
						<option value="HR">Croatia</option>
						<option value="CU">Cuba</option>
						<option value="CW">Curaçao</option>
						<option value="CY">Cyprus</option>
						<option value="CZ">Czech Republic</option>
						<option value="DK">Denmark</option>
						<option value="DJ">Djibouti</option>
						<option value="DM">Dominica</option>
						<option value="DO">Dominican Republic</option>
						<option value="EC">Ecuador</option>
						<option value="EG">Egypt</option>
						<option value="SV">El Salvador</option>
						<option value="GQ">Equatorial Guinea</option>
						<option value="ER">Eritrea</option>
						<option value="EE">Estonia</option>
						<option value="ET">Ethiopia</option>
						<option value="FK">Falkland Islands (Malvinas)</option>
						<option value="FO">Faroe Islands</option>
						<option value="FJ">Fiji</option>
						<option value="FI">Finland</option>
						<option value="FR">France</option>
						<option value="GF">French Guiana</option>
						<option value="PF">French Polynesia</option>
						<option value="TF">French Southern Territories</option>
						<option value="GA">Gabon</option>
						<option value="GM">Gambia</option>
						<option value="GE">Georgia</option>
						<option value="DE">Germany</option>
						<option value="GH">Ghana</option>
						<option value="GI">Gibraltar</option>
						<option value="GR">Greece</option>
						<option value="GL">Greenland</option>
						<option value="GD">Grenada</option>
						<option value="GP">Guadeloupe</option>
						<option value="GU">Guam</option>
						<option value="GT">Guatemala</option>
						<option value="GG">Guernsey</option>
						<option value="GN">Guinea</option>
						<option value="GW">Guinea-Bissau</option>
						<option value="GY">Guyana</option>
						<option value="HT">Haiti</option>
						<option value="HM">Heard Island and McDonald Islands</option>
						<option value="VA">Holy See (Vatican City State)</option>
						<option value="HN">Honduras</option>
						<option value="HK">Hong Kong</option>
						<option value="HU">Hungary</option>
						<option value="IS">Iceland</option>
						<option value="IN">India</option>
						<option value="ID">Indonesia</option>
						<option value="IR">Iran, Islamic Republic of</option>
						<option value="IQ">Iraq</option>
						<option value="IE">Ireland</option>
						<option value="IM">Isle of Man</option>
						<option value="IL">Israel</option>
						<option value="IT">Italy</option>
						<option value="JM">Jamaica</option>
						<option value="JP">Japan</option>
						<option value="JE">Jersey</option>
						<option value="JO">Jordan</option>
						<option value="KZ">Kazakhstan</option>
						<option value="KE">Kenya</option>
						<option value="KI">Kiribati</option>
						<option value="KP">Korea, Democratic People's Republic of</option>
						<option value="KR">Korea, Republic of</option>
						<option value="KW">Kuwait</option>
						<option value="KG">Kyrgyzstan</option>
						<option value="LA">Lao People's Democratic Republic</option>
						<option value="LV">Latvia</option>
						<option value="LB">Lebanon</option>
						<option value="LS">Lesotho</option>
						<option value="LR">Liberia</option>
						<option value="LY">Libya</option>
						<option value="LI">Liechtenstein</option>
						<option value="LT">Lithuania</option>
						<option value="LU">Luxembourg</option>
						<option value="MO">Macao</option>
						<option value="MK">Macedonia, the former Yugoslav Republic of</option>
						<option value="MG">Madagascar</option>
						<option value="MW">Malawi</option>
						<option value="MY">Malaysia</option>
						<option value="MV">Maldives</option>
						<option value="ML">Mali</option>
						<option value="MT">Malta</option>
						<option value="MH">Marshall Islands</option>
						<option value="MQ">Martinique</option>
						<option value="MR">Mauritania</option>
						<option value="MU">Mauritius</option>
						<option value="YT">Mayotte</option>
						<option value="MX">Mexico</option>
						<option value="FM">Micronesia, Federated States of</option>
						<option value="MD">Moldova, Republic of</option>
						<option value="MC">Monaco</option>
						<option value="MN">Mongolia</option>
						<option value="ME">Montenegro</option>
						<option value="MS">Montserrat</option>
						<option value="MA">Morocco</option>
						<option value="MZ">Mozambique</option>
						<option value="MM">Myanmar</option>
						<option value="NA">Namibia</option>
						<option value="NR">Nauru</option>
						<option value="NP">Nepal</option>
						<option value="NL">Netherlands</option>
						<option value="NC">New Caledonia</option>
						<option value="NZ">New Zealand</option>
						<option value="NI">Nicaragua</option>
						<option value="NE">Niger</option>
						<option value="NG">Nigeria</option>
						<option value="NU">Niue</option>
						<option value="NF">Norfolk Island</option>
						<option value="MP">Northern Mariana Islands</option>
						<option value="NO">Norway</option>
						<option value="OM">Oman</option>
						<option value="PK">Pakistan</option>
						<option value="PW">Palau</option>
						<option value="PS">Palestinian Territory, Occupied</option>
						<option value="PA">Panama</option>
						<option value="PG">Papua New Guinea</option>
						<option value="PY">Paraguay</option>
						<option value="PE">Peru</option>
						<option value="PH">Philippines</option>
						<option value="PN">Pitcairn</option>
						<option value="PL">Poland</option>
						<option value="PT">Portugal</option>
						<option value="PR">Puerto Rico</option>
						<option value="QA">Qatar</option>
						<option value="RE">Réunion</option>
						<option value="RO">Romania</option>
						<option value="RU">Russian Federation</option>
						<option value="RW">Rwanda</option>
						<option value="BL">Saint Barthélemy</option>
						<option value="SH">Saint Helena, Ascension and Tristan da Cunha</option>
						<option value="KN">Saint Kitts and Nevis</option>
						<option value="LC">Saint Lucia</option>
						<option value="MF">Saint Martin (French part)</option>
						<option value="PM">Saint Pierre and Miquelon</option>
						<option value="VC">Saint Vincent and the Grenadines</option>
						<option value="WS">Samoa</option>
						<option value="SM">San Marino</option>
						<option value="ST">Sao Tome and Principe</option>
						<option value="SA">Saudi Arabia</option>
						<option value="SN">Senegal</option>
						<option value="RS">Serbia</option>
						<option value="SC">Seychelles</option>
						<option value="SL">Sierra Leone</option>
						<option value="SG">Singapore</option>
						<option value="SX">Sint Maarten (Dutch part)</option>
						<option value="SK">Slovakia</option>
						<option value="SI">Slovenia</option>
						<option value="SB">Solomon Islands</option>
						<option value="SO">Somalia</option>
						<option value="ZA">South Africa</option>
						<option value="GS">South Georgia and the South Sandwich Islands</option>
						<option value="SS">South Sudan</option>
						<option value="ES">Spain</option>
						<option value="LK">Sri Lanka</option>
						<option value="SD">Sudan</option>
						<option value="SR">Suriname</option>
						<option value="SJ">Svalbard and Jan Mayen</option>
						<option value="SZ">Swaziland</option>
						<option value="SE">Sweden</option>
						<option value="CH">Switzerland</option>
						<option value="SY">Syrian Arab Republic</option>
						<option value="TW">Taiwan, Province of China</option>
						<option value="TJ">Tajikistan</option>
						<option value="TZ">Tanzania, United Republic of</option>
						<option value="TH">Thailand</option>
						<option value="TL">Timor-Leste</option>
						<option value="TG">Togo</option>
						<option value="TK">Tokelau</option>
						<option value="TO">Tonga</option>
						<option value="TT">Trinidad and Tobago</option>
						<option value="TN">Tunisia</option>
						<option value="TR">Turkey</option>
						<option value="TM">Turkmenistan</option>
						<option value="TC">Turks and Caicos Islands</option>
						<option value="TV">Tuvalu</option>
						<option value="UG">Uganda</option>
						<option value="UA">Ukraine</option>
						<option value="AE">United Arab Emirates</option>
						<option value="GB">United Kingdom</option>
						<option value="US">United States</option>
						<option value="UM">United States Minor Outlying Islands</option>
						<option value="UY">Uruguay</option>
						<option value="UZ">Uzbekistan</option>
						<option value="VU">Vanuatu</option>
						<option value="VE">Venezuela, Bolivarian Republic of</option>
						<option value="VN">Viet Nam</option>
						<option value="VG">Virgin Islands, British</option>
						<option value="VI">Virgin Islands, U.S.</option>
						<option value="WF">Wallis and Futuna</option>
						<option value="EH">Western Sahara</option>
						<option value="YE">Yemen</option>
						<option value="ZM">Zambia</option>
					</select>
				</div>
				<div class="field-iframe-label">Billing Country</div>
			</div>
			<div class="form-group-checkbox">
				<input type="checkbox" name="card-savecard" id="paysafe-card-savecard">
				<label for="paysafe-card-savecard">Save Card</label>
			</div>
			<!-- Add a payment button -->
			<button id="payNow" type="button"><%= messageSource.getMessage("label.button.paybycard.standard", null, WebContextUtil.getDefaultLocale()) %> (<plastocart:fmcn locale="${currencyLocale}" value="${customerorder.subTotal}" />)</button>
		</div>
		<div id="list-card" style="display: none;">
			<a href="#" id="add_new_card"><div class="card-brand"></div><fmt:message key="info.card.addnewcard" /></a>
			<ul class="list-cards"></ul>
			<button id="btn_card_choice" type="button" class="btn btn-block btn-primary ajax-btn"><%= messageSource.getMessage("label.button.paybycard.standard", null, WebContextUtil.getDefaultLocale()) %> (<plastocart:fmcn locale="${currencyLocale}" value="${customerorder.subTotal}" />)</button>
		</div>
		<div class="error-card"></div>
		<script type = "text/javascript">
			// Base64-encoded version the Single-Use Token API key.
			// Create the key below by concatenating the API username and password
			// separated by a colon and Base 64 encoding the result

			jQuery('.field-iframe-input').on('focus', function(){
				var thisInput = jQuery(this);
				var thisInputParent = thisInput.parent();
				thisInputParent.addClass('field-iframe-focus');
			});
			jQuery('.field-iframe-input').on('blur', function(){
				var thisInput = jQuery(this);
				var thisInputValue = thisInput.val();
				var thisInputParent = thisInput.parent();
				if(thisInputValue.length) {
					thisInputParent.addClass('field-iframe-focus');
				}else {
					thisInputParent.removeClass('field-iframe-focus');
				}
			});


			var apiKey = "<%= singleUseAPIToken %>";

			var options = {
					// select the Paysafe test / sandbox environment
				environment: '<%= environment %>',

				// set the CSS selectors to identify the payment field divs above
				// set the placeholder text to display in these fields
				fields: {
					cardNumber: {
						selector: "#cardNumber",
						placeholder: "1234 1234 1234 1234",
						separator: " "
					},
					expiryDate: {
						selector: "#expiryDate",
						placeholder: "Expiry date"
					},
					cvv: {
						selector: "#cvv",
						placeholder: "CVV",
						optional: false
					}
				},					

				//set the CSS styles to apply to the payment fields     
				style: {
				  input: {
						"font-family": "robotoregular,Helvetica,Arial,sans-serif",
						"font-weight": "normal",
						"font-size": "16px"
					},
					"input::-webkit-input-placeholder": {
						"color": "#cfd7df",
						"opacity": "0"
					},
					":focus::-webkit-input-placeholder": {
						"opacity": "1"
					}
				}
			};

			paysafe.fields.setup("my Base64 encoded single-use-token API key", function(instance, error) {
			});

			// initalize the hosted iframes using the SDK setup function
			paysafe.fields.setup(apiKey, options, function(instance, error) {

				// When the customer clicks Pay Now,
				// call the SDK tokenize function to create
				// a single-use payment token corresponding to the card details entered				
				document.getElementById("payNow").addEventListener("click", function(event) {
					
					jQuery('.error-card').html('');
					jQuery('#payNow').attr('disabled', 'disabled').addClass('disable-btn');

					var customerorderValue = ${customerorder.subTotal} * 100;
					customerorderValue = Math.round(customerorderValue);

					var cardHolderNameVal = jQuery('#cardHolderName').val();
					var billingPostcodeVal = jQuery('#billingPostcode').val();
					var billingCountryVal = jQuery('#billingCountry').val();

					var cvv_var = instance.fields.cvv.isValid();
					var cardNumber_var = instance.fields.cardNumber.isValid();
					var expiryDate_var = instance.fields.expiryDate.isValid();


					var cvv_var_isEmpty = instance.fields.cvv.isEmpty();
					var cardNumber_var_isEmpty = instance.fields.cardNumber.isEmpty();
					var expiryDate_var_isEmpty = instance.fields.expiryDate.isEmpty();



					var error_text = '';
					if(cardNumber_var_isEmpty) {
						error_text = error_text + '<br>Card holder name is required'
					}else {
						if(!cardNumber_var) {
							error_text = error_text + '<br>Card holder name is invalid'
						}
					}
					if(expiryDate_var_isEmpty) {
						error_text = error_text + '<br>Expiry date is required'
					}else {
						if(!expiryDate_var) {
							error_text = error_text + '<br>Expiry date is invalid'
						}
					}
					if(cvv_var_isEmpty) {
						error_text = error_text + '<br>CVV is required'
					}else {
						if(!cvv_var) {
							error_text = error_text + '<br>CVV is invalid'
						}
					}
					if(cardHolderNameVal.length < 1) {
						error_text = error_text + '<br>Card holder name is required'
					}
					if(billingPostcodeVal.length < 1) {
						error_text = error_text + '<br>Billing postcode is required'
					}
					if(billingCountryVal == '-1' || billingCountryVal == null || billingCountryVal == undefined) {
						error_text = error_text + '<br>Billing Country is required'
					}

					// console.log(error_text);

					// error_text = error_text.substring(0, error_text.length - 1) + '.';

					if( error_text.length > 0) {
						jQuery('.error-card').html(error_text);
						jQuery('#payNow').removeAttr('disabled').removeClass('disable-btn');
						return false;
					}
					
					instance.tokenize(instance.tokenize({
		                threeDS: {
			                  amount: customerorderValue,
			                  currency: '<%= currencyCode %>',
			                  accountId: <%= accountNumber %>,
							  useThreeDSecureVersion2: true,
							  authenticationPurpose: "PAYMENT_TRANSACTION"
							},
							vault: {
								holderName: cardHolderNameVal
							}
			            }, function(instance, error, result) {
							if (error) {
								// display the tokenization error in dialog window
								jQuery('#payNow').removeAttr('disabled').removeClass('disable-btn');

								jQuery('.error-card').text(error.detailedMessage);
								console.log(error);
							} else {
								// write the Payment token value to the browser console
								console.log(result.token);
								paymentToken(result.token);
							}
						}));
				}, false);
	
				if (error) {
					console.log(error);
				} else {
					instance.fields("cvv cardNumber expiryDate").on("Focus Blur", function(instance, event) {
	
						if(event.data.isEmpty) {
							this.classList.remove('isEmpty_false');
						}else {
							this.classList.add('isEmpty_false');
						}
	
						if(event.type === "Focus") {
							this.classList.add("field-iframe-focus");
						}if(event.type === "Blur") {
							this.classList.remove('field-iframe-focus');
						}
					});
				}
			});

			function paymentToken(paymentToken) {
	
				jQuery('.error-card').html('');
	
				var saveCardBoolean = false;
				if( jQuery('#paysafe-card-savecard:checked').length ) {
					saveCardBoolean = true;
				}

				var customerorderValue = ${customerorder.subTotal} * 100;
				customerorderValue = Math.round(customerorderValue);
				var billingPostcodeVal = jQuery('#billingPostcode').val();
				var billingCountryVal = jQuery('#billingCountry').val();

				var paymentTokenJson = {
					"customerIp": '${customer.ipAddress}',
					"amount": customerorderValue,
					"paymentMethodID": ${paymentmethod.id},
					"customerID": ${customer.id},
					"customerOrderID": ${customerorder.id},
					"transID": '${customerorder.transId}',
					"billingPostcode": billingPostcodeVal,
					'billingCountry': billingCountryVal,
					"reuseCard": false,
					"saveCard": saveCardBoolean
				}
	
				jQuery.ajax({
					headers: {
						Accept: "application/json",
						"Content-Type": "application/json"
					},
					type: "POST",
					data: JSON.stringify(paymentTokenJson),
					url: "https://live.ordertiger.com/api/v1/paysafe/cardpayments/" + paymentToken + "/auths",
					success: function(response) {
						console.log(response);						
						console.log(response.status);
						if (response.status == "COMPLETED") {
							window.location.replace('/paysafe/success?companyId=<%= WebContextUtil.getCompanyId() %>');
						} else {
							jQuery('.error-card').html(response.status);
						}
					},error: function(jqXHR, textStatus, errorThrown) {
	
						console.log(jqXHR);
						console.log(textStatus);
						console.log(errorThrown);
						jQuery('#payNow').removeAttr('disabled');
						jQuery('#payNow').removeClass('disable-btn');
						jQuery('.error-card').show();
						jQuery('.error-card').html(jqXHR.responseJSON.message);
	
					},
					dataType: 'json'
				});
			}
		
			jQuery.ajax({
				url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/customers/${customer.id}/paymentmethods/${paymentmethod.id}/cards',
				type: 'get',
				success: function( data, textStatus, jQxhr ){
					console.log(data);
					console.log(data.length);
					jQuery('.list-cards').html('');
	
					if (data.length) {

						console.log('data.length true');
	
						var card = '';
						var classActive = '';
						jQuery('#list-card').show();
						jQuery('#new-card').hide();
						jQuery('#card-back').show();
	
						for (var i = 0; i < data.length; i++) {
							
							if (i == 0) {
								classActive = 'active';
							}else {
								classActive = '';
							}
	
							var cardTypeVar = data[i].cardType;
							if (cardTypeVar == "VI") {
								cardTypeVar = "Visa"
							}
							if (cardTypeVar == "MC") {
								cardTypeVar = "Mastercard";
							}
							if (cardTypeVar == "AM") {
								cardTypeVar = "American Express";
							}							
							card = card + '<li><div class="card-style card-style-js ' + classActive + '" data-paymentToken="' + data[i].paymentToken + '" data-card="' + data[i].id + '" data-cardBin="' + data[i].cardBin + '"><div class="card-brand"></div><h6>' + cardTypeVar + '</h6><p>Ending ' + data[i].lastDigits + '</p> <div class="securityCode"><input type="password" id="securityCode" name="securityCode" maxlength="4"><div class="security-code-tilte">security code</div></div> </div>	<div class="delete-card delete-card-js" data-card="' + data[i].id + '"></div> </li>';	
						}
						jQuery('.list-cards').html(card);
						if (card.length) {
							jQuery('#btn_card_choice').removeAttr('disabled');
						}						
					}
	
					jQuery('.card-style-js').click(function(){
						jQuery('.card-style-js').removeClass('active');
						jQuery(this).addClass('active');
						jQuery('#btn_card_choice').removeAttr('disabled');
					});
	
	
					jQuery('.delete-card-js').click(function(){
						var cardID = jQuery(this).attr('data-card');
						jQuery('#delete_card').attr('data-card', cardID);
						jQuery('#delete_card').modal('show');
					});
	
					jQuery('#delete-card-modal').click(function(){
						var cardID = jQuery('#delete_card').attr('data-card');
						
						jQuery.ajax({
							url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/customers/${customer.id}/paymentmethods/${paymentmethod.id}/cards/' + cardID,
							type: 'DELETE',
							success: function( data, textStatus, jQxhr ){
								console.log(data);
							},
							error: function( jqXhr, textStatus, errorThrown ){
								console.log( jqXhr );
								console.log( errorThrown );
							}
	
						});
	
						if ( jQuery('.card-style-js[data-card="' + cardID + '"]').hasClass('active') || (jQuery('.card-style-js').length < 2) ){
							jQuery('#btn_card_choice').attr('disabled', 'disabled');
						}
	
						jQuery('.card-style-js[data-card="' + cardID + '"]').parent().remove();
						jQuery('#delete_card').modal('hide');
					});
				},
				error: function( jqXhr, textStatus, errorThrown ){
					console.log( errorThrown );
				}
			});
	
			jQuery('#btn_card_choice').click(function(){
				jQuery('.error-card').html('');
				
				var paymentToken = jQuery('.card-style-js.active').attr('data-paymentToken');
				var cardBin = jQuery('.card-style-js.active').attr('data-cardBin');
				var cardId = jQuery('.card-style-js.active').attr('data-card');
				var securityCodeVal = jQuery('.card-style-js.active #securityCode').val();
				if(securityCodeVal.length < 3) {
					jQuery('.error-card').html('Invalid fields: security code');
					jQuery('#btn_card_choice').removeAttr('disabled');
					jQuery('#btn_card_choice').removeClass('disable-btn');
					return false
				}
	
				var customerorderValue = ${customerorder.subTotal} * 100;
				customerorderValue = Math.round(customerorderValue);
				
				var paymentTokenJson = {
					"customerIp": '${customer.ipAddress}',
					"amount": customerorderValue,
					"paymentMethodID": ${paymentmethod.id},
					"customerID": ${customer.id},
					"customerOrderID": ${customerorder.id},
					"transID": '${customerorder.transId}'+cardId,
					"billingPostcode": null,
					'securityCode': securityCodeVal,
					"billingCountry": null,
					"reuseCard": true,
					"saveCard": false
				}				

				paysafe.threedsecure.start(apiKey, {
					environment: '<%= environment %>',
					accountId: <%= accountNumber %>,
					card: {
						cardBin: cardBin
					}
				}, function (deviceFingerprintingId, error) {

					if (error) {
						console.log('error');
						jQuery('.error-card').html(error.detailedMessage);
						jQuery('#btn_card_choice').removeAttr('disabled');
						jQuery('#btn_card_choice').removeClass('disable-btn');
					} else {
						jQuery('.error-card').html('');
						console.log('deviceFingerprintingId');
						console.log(deviceFingerprintingId);

						var customerorderValueString = customerorderValue + "";
						var paymentAuthenticateJson = {
							"amount": customerorderValueString,
							"paymentMethodID": ${paymentmethod.id},
							"customerID": ${customer.id},
							"customerOrderID":${customerorder.id},
							"transID":'${customerorder.transId}'+cardId,
							"cardID":cardId,
							"deviceFingerPrintingId": deviceFingerprintingId ,
							"currency":"<%= currencyCode %>",
							"merchantUrl" : "https://online.ordertiger.com",
							"paymentToken": paymentToken
						}

						console.log('paymentAuthenticateJson');
						console.log(paymentAuthenticateJson);

						jQuery.ajax({
							headers: {
								Accept: "application/json",
								"Content-Type": "application/json"
							},
							url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/authenticate', 
							dataType: 'json',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify(paymentAuthenticateJson),
							success: function(response) {
								console.log('response new');
								console.log(response);
								jQuery('.error-card').html('');
								if(response.status == "COMPLETED")  {

									console.log(paymentTokenJson);
									jQuery.ajax({
										headers: {
											Accept: "application/json",
											"Content-Type": "application/json"
										},
										url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/' + paymentToken + '/auths', 
										dataType: 'json',
										type: 'POST',
										contentType: 'application/json',
										data: JSON.stringify(paymentTokenJson),
										success: function(response) {						
											console.log(response);
											console.log(response.status);
											if(response.status == "COMPLETED") {
												window.location.replace('/paysafe/success?companyId=<%= WebContextUtil.getCompanyId() %>');
											}else {
												jQuery('.error-card').html(response.status);
												jQuery('#btn_card_choice').removeAttr('disabled');
												jQuery('#btn_card_choice').removeClass('disable-btn');
											}						
										},error: function(jqXHR, textStatus, errorThrown) {						
											console.log(jqXHR);
											jQuery('.error-card').show();
											jQuery('.error-card').html(jqXHR.responseJSON.message);
											jQuery('#btn_card_choice').removeAttr('disabled');
											jQuery('#btn_card_choice').removeClass('disable-btn');						
										},
										dataType: 'json'
									});

								} else if ( (response.status == "PENDING" && response.threeDEnrollment== "Y" ) || (response.status == "PENDING" && response.threeDResult== "C" )  || (response.status="PENDING" && response.sdkChallengePayload != null)) {

									// Do challenge flow here
									// https://developer.paysafe.com/en/rest-apis/3d-secure-2/using-the-api/using-the-3d-secure-2-javascript-sdk/javascript-sdk-challenge-function/
									paysafe.threedsecure.challenge(apiKey, {
										environment: '<%= environment %>',
										sdkChallengePayload: response.sdkChallengePayload
									}, function (id, error) {
										if (error) {
											console.log('error');
											jQuery('.error-card').html(error.detailedMessage);
											jQuery('#btn_card_choice').removeAttr('disabled');
											jQuery('#btn_card_choice').removeClass('disable-btn');
										} else {
											if (id != null) {
									 			
												 jQuery.ajax({
													headers: {
														Accept: "application/json",
														"Content-Type": "application/json"
													},
													url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/paymentmethods/${paymentmethod.id}/authenticate/' + id, 
													type: 'GET',
													success: function(response) {
														if (response.status == "COMPLETED") {

															console.log(paymentTokenJson);
															jQuery.ajax({
																headers: {
																	Accept: "application/json",
																	"Content-Type": "application/json"
																},
																url: 'https://live.ordertiger.com/api/v1/paysafe/cardpayments/' + paymentToken + '/auths', 
																dataType: 'json',
																type: 'POST',
																contentType: 'application/json',
																data: JSON.stringify(paymentTokenJson),
																success: function(response) {
												
																	console.log(response);
																	console.log(response.status);
																	if(response.status == "COMPLETED") {
																		window.location.replace('/paysafe/success?companyId=<%= WebContextUtil.getCompanyId() %>');
																	}else {
																		jQuery('.error-card').html(response.status);
																		jQuery('#btn_card_choice').removeAttr('disabled');
																		jQuery('#btn_card_choice').removeClass('disable-btn');
																	}
												
																},error: function(jqXHR, textStatus, errorThrown) {				
																	console.log(jqXHR);
																	jQuery('.error-card').show();
																	jQuery('.error-card').html(jqXHR.responseJSON.message);
																	jQuery('#btn_card_choice').removeAttr('disabled');
																	jQuery('#btn_card_choice').removeClass('disable-btn');
												
																},
																dataType: 'json'
															});
														} else if (response.status == "PENDING"){
									 						jQuery('.error-card').html('Authentication status is PENDING');
									 					} else {
															jQuery('.error-card').html(response.status);
															jQuery('#btn_card_choice').removeAttr('disabled');
															jQuery('#btn_card_choice').removeClass('disable-btn');
														}
													},error: function(jqXHR, textStatus, errorThrown) {
														console.log(jqXHR);
														jQuery('.error-card').show();
														jQuery('.error-card').html(jqXHR.responseJSON.message);
														jQuery('#btn_card_choice').removeAttr('disabled');
														jQuery('#btn_card_choice').removeClass('disable-btn');
									
													}
												});
											} else {
							 					jQuery('.error-card').html('Authentication ID not valid');
												jQuery('#btn_card_choice').removeAttr('disabled');
												jQuery('#btn_card_choice').removeClass('disable-btn');
											}											
										}										
									});							
						 		} else if(response.status == "PENDING") {
						 			jQuery('.error-card').html('Authentication status is PENDING');
									jQuery('#btn_card_choice').removeAttr('disabled');
									jQuery('#btn_card_choice').removeClass('disable-btn');
						 		} else {
						 			jQuery('.error-card').html(response.status);
									jQuery('#btn_card_choice').removeAttr('disabled');
									jQuery('#btn_card_choice').removeClass('disable-btn');
						 		}			
							},error: function(jqXHR, textStatus, errorThrown) {
								console.log(jqXHR);
								jQuery('.error-card').show();
								jQuery('.error-card').html(jqXHR.responseJSON.message);
								jQuery('#btn_card_choice').removeAttr('disabled');
								jQuery('#btn_card_choice').removeClass('disable-btn');
			
							},
							dataType: 'json'
						});
					}
				});
			});	
	
			jQuery('#card-back').click(function(){
				jQuery('.error-card').html('');
				jQuery('#new-card').hide();
				jQuery('#list-card').show();
				return false
			});
			
			jQuery('#add_new_card').click(function(){
				jQuery('#new-card').show();
				jQuery('#list-card').hide();
				return false
			});
		</script>
	</body>
</html>