<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/plastocart.tld" prefix="plastocart" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="addaddress"><fmt:message key='url.path.addaddress' /></c:set>
<c:set var="confirmDetailsUrl"><fmt:message key='url.path.confirmdetails' /></c:set>
<c:set var="orderAllowed" value="${not empty orderType and not empty paymentMethods and not empty orderTime and not empty orderDate}"/>
<c:if test="${promoCodeErrorMessage != null}">
	<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong><fmt:message key="${promoCodeErrorMessage}" /></strong>
	</div>
</c:if>
<c:if test="${infoMessage != null}">
	<div class="alert alert-dismissible alert-info">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${infoMessage}</strong>
		
	</div>
</c:if>
<c:if test="${warningMessage != null}">
	<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${warningMessage}</strong>
		
	</div>
</c:if>
<c:if test="${warningMessageNoZoneFound != null}">
	<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${warningMessageNoZoneFound}</strong>
		
	</div>
</c:if>
<c:if test="${orderAllowed}">		
	<form:form action="/${confirmDetailsUrl}" method="post" modelAttribute="confirmDetailsForm" id="confirmdetailsform" role="form">
		<input type="hidden" name="isAddressBook" value="true" />
		<form:hidden path="companyId" />
		<spring:bind path="*">
			<c:set var="validationErrors"><form:errors path="*"/></c:set>
			<c:if test="${not empty validationErrors}"> 
				<div class="alert alert-dismissible alert-danger">
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					<strong>
						<c:forEach items="${status.errorMessages}" var="error">
							${error} <br />
						</c:forEach>
					</strong>
				</div>
			</c:if>
		</spring:bind>
		<div class="mb-3">
			<label class="form-label" for="ordertype"><fmt:message key="label.ordertype" /> <span class="required">*</span></label> 
			<c:if test="${orderType == 'DELIVERY' or orderType == 'CATERING'}">
				<c:set var="isDeliveryOrCatering" value="true" />
			</c:if>
		   <form:input path="orderType" id="orderType" cssClass="form-control" htmlEscape="true" maxlength="60" readonly="true" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="paymentmethod"><fmt:message key="label.paymentmethod" /> <span class="required">*</span></label> 
			<select id="paymentMethod" name="paymentMethod" class="form-select">	
			    <c:forEach var="thisPaymentMethod" items="${paymentMethods}">
					<option <c:if test="${thisPaymentMethod.paymentType == confirmDetailsForm.paymentMethod}">selected=\"selected\"</c:if> value="${thisPaymentMethod.paymentType}"><plastocart:getmessage messageCode="${thisPaymentMethod.paymentType}" /></option>
				</c:forEach>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label" for="orderDate"><fmt:message key="label.orderdate" /> <span class="required">*</span></label> 
			<form:input path="orderDate" id="orderDate" cssClass="form-control" htmlEscape="true" maxlength="60" readonly="true" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="ordertime"><fmt:message key="label.ordertime" /> <span class="required">*</span> <span aria-hidden="true" class="glyphicon glyphicon-dashboard"></span></label>
			<form:input path="orderTime" id="orderTime" cssClass="form-control" htmlEscape="true" maxlength="60" readonly="true" />
		</div>
		<hr />
		<div class="mb-3">
			<label class="form-label" for="firstname"><fmt:message key="label.firstname" /> <span class="required">*</span></label> 
			<form:input path="firstName" id="firstname" cssClass="form-control" htmlEscape="true" maxlength="60" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="lastname"><fmt:message key="label.lastname" /> <span class="required">*</span></label> 
			<form:input path="lastName" id="lastname" cssClass="form-control" htmlEscape="true" maxlength="60" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="email"><fmt:message key="label.email2" /> <span class="required">*</span></label> 
			<form:input path="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="telephone"><fmt:message key="label.phone" /> <span class="required">*</span></label>
			<div class="form-position">
				<form:input path="phone" id="phone" type="tel" cssClass="form-control" htmlEscape="true" maxlength="40" />
				<span id="valid-msg" class="hide">✓</span>
				<span id="error-msg" class="hide"></span>
			</div>
		</div>
		<div class="mb-3">
			<label class="form-label" for="instructions"><fmt:message key="label.specialinstructions" /></label>
			<form:textarea rows="2" cols="23" id="specialinstructions" path="specialInstructions" cssClass="form-control" maxlength="250" />
		</div>
		<div class="mb-3">
			<label class="form-label" for="promocode"><fmt:message key="label.promocode" /></label> 
			<form:input path="promoCode" id="promocode" cssClass="form-control" htmlEscape="true" maxlength="60" />
		</div>
		<c:if test="${isDeliveryOrCatering == 'true'}">
			<hr />
			<div class="mb-3" id="addressbookdiv">
				<label class="form-label" for="customeraddresses"><fmt:message key="label.address" /> <span class="required">*</span></label>
				<div class="d-flex justify-content-end mb-3">
					<c:choose>
						<c:when test="${widgetSite == 'true'}">
							<button type="button" data-modal-href="/${addaddress}?companyId=${companyId}&referralPage=${confirmDetailsUrl}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal"><fmt:message key='label.link.addaddress' /></button>
						</c:when>
						<c:otherwise>
							<button type="button" data-modal-href="/${addaddress}?referralPage=${confirmDetailsUrl}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal"><fmt:message key='label.link.addaddress' /></button>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="addressbookTablediv">
					<table id="addressbookTable" class="table table-bordered table-striped table-hover" cellspacing="0" role="grid">
						<tbody>
						    <c:forEach var="thisCustomerAddress" items="${customerAddresses}" varStatus="rowStatus">
								<tr id="addressbookTable_row" onclick="changeSelectedItem(this);setSelectedAddresId('${thisCustomerAddress.id}')" class="${rowStatus.index % 2 == 0 ? 'even' : 'odd'} addressbookTable_row" role="row">
									<td width="5%"><form:radiobutton path="addressId" value="${thisCustomerAddress.id}"/></td>
									<td class="address-field-name">
									<c:forEach items="${company.addressFieldRules}" var="fieldRule">
										<c:if test="${fieldRule.display}">
											<c:forEach var="thisAddressFields" items="${thisCustomerAddress.addressFields}" varStatus="rowStatus1">
												<c:if test="${fieldRule.fieldName == thisAddressFields.fieldName}">
													${thisAddressFields.fieldValue}<c:if test="${rowStatus1.index < thisCustomerAddress.addressFields.size() - 1}"><br /></c:if>
												</c:if> 
											</c:forEach>
										</c:if>
									</c:forEach>
									</td>
									<td width="28%">
										<a class="customer-id" role="button" href="javascript: deleteaddress(${thisCustomerAddress.id},${companyId});"> <fmt:message key="label.link.delete" /> </a>
									</td>
								</tr>
						    </c:forEach>
					    </tbody>
					</table>
				</div>
			</div>
		</c:if>
		<div class="d-grid mb-5">
			<button type="submit" class="btn btn-primary btn-block" id="update-confirm">
				<fmt:message key="label.button.continue.standard" />
			</button>
		</div>
	</form:form>
</c:if>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAroNtwZVVZwUcIQsowdwhssYpzaZcoguw&v=3.27&libraries=geometry,places&region=${company.companyLocale.country}"></script>
<script type="text/javascript">
	jQuery.ajax({
		type: "GET",
		url: '/phones/countrycode?companyId=${company.id}',
		success: function(response) {
			console.log(response);
			var countryCode = response.country;

			var input = document.querySelector("#phone"),
				errorMsg = document.querySelector("#error-msg"),
				validMsg = document.querySelector("#valid-msg");

			//here, the index maps to the error code returned from getValidationError - see readme
			var errorMap = ['<fmt:message key="number.invalid" />', '<fmt:message key="country.code.invalid" />', '<fmt:message key="too.short.invalid" />', '<fmt:message key="too.long.invalid" />', '<fmt:message key="number.invalid" />'];

			//initialise plugin
			var valNumber = jQuery('#phone').val();
			if (valNumber[0] == "+") {
				countryCode = 'auto';
			}


			var iti = window.intlTelInput(input, {
				initialCountry: countryCode,
				separateDialCode: true,
				geoIpLookup: function(callback) {
					$.get('https://ipinfo.io', function() {}, "jsonp").always(function(resp) {
						var countryCode = (resp && resp.country) ? resp.country : "us";
						callback(countryCode);
					});
				},
				utilsScript: "/static/aaa_general/js/intl-tel-input/utils.js" // just
			});

			var reset = function() {
				input.classList.remove("error");
				errorMsg.innerHTML = "";
				errorMsg.classList.add("hide");
				validMsg.classList.add("hide");
			};

			//on blur: validate
			input.addEventListener('blur', function() {
				reset();
				if (input.value.trim()) {

					if (iti.isValidNumber()) {
						// var valPhone = jQuery('#phone').val();


						// var codeNumber = iti.selectedCountryData.dialCode;
						// var valPhoneFirst = valPhone[0]

						// var codeNumberLast = codeNumber[codeNumber.length - 1];


						// console.log(valPhoneFirst);
						// console.log(codeNumberLast);
						// if (valPhoneFirst == "0" && codeNumberLast == "0") {
						// 	var lenghNumber = codeNumber.length - 1;
						// 	codeNumber = codeNumber.substr(0, lenghNumber);
						// 	console.log(codeNumber);
						// }


						// if (valPhone[0] != "+") {
						// 	var valPhoneNew = "+" + codeNumber + valPhone;
						// 	jQuery('#phone').val(valPhoneNew);
						// }

						// jQuery('#register-submit').prop("disabled", false);
						// jQuery('#update-confirm').prop("disabled", false);
						// validMsg.classList.remove("hide");
					} else {
						// jQuery('#register-submit').prop("disabled", true);
						// jQuery('#update-confirm').prop("disabled", true);


						// input.classList.add("error");
						// var errorCode = iti.getValidationError();
						// errorMsg.innerHTML = errorMap[errorCode];
						// errorMsg.classList.remove("hide");
					}
				}
			});


			function disableFun() {
				if (input.value.trim()) {
					if (iti.isValidNumber()) {
						jQuery('#register-submit').prop("disabled", false);
						jQuery('#update-confirm').prop("disabled", false);
						validMsg.classList.remove("hide");
					} else {
						jQuery('#register-submit').prop("disabled", true);
						jQuery('#update-confirm').prop("disabled", true);

						input.classList.add("error");
						var errorCode = iti.getValidationError();
						errorMsg.innerHTML = errorMap[errorCode];
						errorMsg.classList.remove("hide");
					}
				}
			}

			//on keyup / change flag: reset
			// input.addEventListener('change', function() {
			// 	reset();
			// 	disableFun();
			// });
			// input.addEventListener('keyup', function() {
			// 	reset();
			// 	disableFun();
			// });

			// input.addEventListener("countrychange", function() {
			// 	reset();
			// 	disableFun();
			// });



			jQuery('#update-confirm').click(function() {
				jQuery(this).addClass('disable-btn').prop("disabled", true);
				var beforeNumber = jQuery('.iti__selected-dial-code').text();
				var phoneNumber = jQuery('#phone').val();
				if (phoneNumber[0] != "+") {
					phoneNumber = beforeNumber + phoneNumber;
					jQuery('#phone').val(phoneNumber);
				}


				//new validation
				jQuery('#confirmdetailsform').submit();
				// jQuery('#update-confirm').addClass('disable-btn');



				// if (iti.isValidNumber()) {
				// 	jQuery('#register-submit').prop("disabled", false);
				// 	jQuery('#update-confirm').prop("disabled", false);
				// 	validMsg.classList.remove("hide");
				// 	jQuery('#confirmdetailsform').submit();
				// 	console.log('update form');
				// } else {
				// 	jQuery('#register-submit').prop("disabled", true);
				// 	jQuery('#update-confirm').prop("disabled", true);

				// 	input.classList.add("error");
				// 	var errorCode = iti.getValidationError();
				// 	errorMsg.innerHTML = errorMap[errorCode];
				// 	errorMsg.classList.remove("hide");
				// 	jQuery('#update-confirm').removeClass('disable-btn');
				// }



				return false
			});



		},
		dataType: 'json'
	});
</script>
<script>
	var selectedCompanyId = '${company.id}';
	function changeSelectedItem(that){
		jQuery(that).find('td input:radio').prop('checked', true);
		jQuery(that).find('td input:radio').trigger("change")
	}
</script>