<%@ page language="java" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	<c:set var="myAccountUrl">
		<fmt:message key='url.path.myaccount'/>
	</c:set>
	<h2 class="profile-title"><fmt:message key='header.personal.info'/></h2>
	<div class="row">
	<form:form action="/${myAccountUrl}" method="post" modelAttribute="myAccountForm" id="updatemyaccountform"
			   role="form" class="col-lg-6 col-md-10">
		<form:hidden path="companyId"/>
		<spring:bind path="*">
			<c:set var="validationErrors">
				<form:errors path="*"/>
			</c:set>
			<c:if test="${not empty validationErrors}">
				<div class="alert alert-dismissible alert-danger">
				<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				<c:forEach items="${status.errorMessages}" var="error">
					${error} <br />
				</c:forEach>
				</div>
			</c:if>
		</spring:bind>
		<c:if test="${successMessage != null}">
			<div class="alert alert-dismissible alert-success">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			${successMessage}
			</div>
		</c:if>
		<c:if test="${infoMessage != null}">
			<div class="alert alert-dismissible alert-info">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			${infoMessage}
			</div>
		</c:if>
		<c:if test="${warningMessage != null}">
			<div class="alert alert-dismissible alert-warning">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			${warningMessage}
			</div>
		</c:if>
		<div class="mb-3">
		<label class="form-label" for="firstname">
		<fmt:message key="label.firstname"/>
		<span class="required">*</span></label>
		<form:input path="firstName" id="firstname" cssClass="form-control" htmlEscape="true" maxlength="60"/>
		</div>
		<div class="mb-3">
		<label class="form-label" for="lastname">
		<fmt:message key="label.lastname"/>
		<span class="required">*</span></label>
		<form:input path="lastName" id="lastname" cssClass="form-control" htmlEscape="true" maxlength="60"/>
		</div>
		<div class="mb-3">
		<label class="form-label" for="email">
		<fmt:message key="label.email2"/>
		<span class="required">*</span></label>
		<form:input path="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100"/>
		</div>
		<div class="mb-3">
		<label class="form-label" for="phone">
		<fmt:message key="label.phone"/>
		<span class="required">*</span></label>
		<div class="form-position">
			<form:input path="phone" id="phone" type="tel" cssClass="form-control" htmlEscape="true" maxlength="40"/>
			<span id="valid-msg" class="hide">✓</span>
			<span id="error-msg" class="hide"></span>
		</div>
		</div>
		<div class="mb-3 d-grid">
		<c:choose>
			<c:when test="${param.custombuttons == 'yes'}">
				<c:choose>
					<c:when test="${param.hoverbuttons == 'yes'}">
						<button type="submit" class="btn btn-primary btn-block" id="update-info">
						<fmt:message key="label.button.myaccount"/>
						</button>
					</c:when>
					<c:otherwise>
						<button type="submit" class="btn btn-primary btn-block" id="update-info">
						<fmt:message key="label.button.myaccount"/>
						</button>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<button type="submit" class="btn btn-primary btn-block" id="update-info">
				<fmt:message key="label.button.myaccount"/>
				</button>
			</c:otherwise>
		</c:choose>
		</div>
	</form:form>
	</div>
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
				// if (input.value.trim()) {

				// 	if (iti.isValidNumber()) {
				// 		var valPhone = jQuery('#phone').val();


				// 		var codeNumber = iti.selectedCountryData.dialCode;
				// 		var valPhoneFirst = valPhone[0]

				// 		var codeNumberLast = codeNumber[codeNumber.length - 1];


				// 		console.log(valPhoneFirst);
				// 		console.log(codeNumberLast);
				// 		if (valPhoneFirst == "0" && codeNumberLast == "0") {
				// 			var lenghNumber = codeNumber.length - 1;
				// 			codeNumber = codeNumber.substr(0, lenghNumber);
				// 			console.log(codeNumber);
				// 		}


				// 		if (valPhone[0] != "+") {
				// 			var valPhoneNew = "+" + codeNumber + valPhone;
				// 			jQuery('#phone').val(valPhoneNew);
				// 		}

				// 		jQuery('#register-submit').prop("disabled", false);
				// 		jQuery('#update-info').prop("disabled", false);
				// 		validMsg.classList.remove("hide");
				// 	} else {
				// 		jQuery('#register-submit').prop("disabled", true);
				// 		jQuery('#update-info').prop("disabled", true);


				// 		input.classList.add("error");
				// 		var errorCode = iti.getValidationError();
				// 		errorMsg.innerHTML = errorMap[errorCode];
				// 		errorMsg.classList.remove("hide");
				// 	}
				// }
			});


			function disableFun() {
				if (input.value.trim()) {
					if (iti.isValidNumber()) {
						jQuery('#register-submit').prop("disabled", false);
						jQuery('#update-info').prop("disabled", false);
						validMsg.classList.remove("hide");
					} else {
						jQuery('#register-submit').prop("disabled", true);
						jQuery('#update-info').prop("disabled", true);

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



			jQuery('#update-info').click(function() {
				var beforeNumber = jQuery('.iti__selected-dial-code').text();
				var phoneNumber = jQuery('#phone').val();
				if (phoneNumber[0] != "+") {
					phoneNumber = beforeNumber + phoneNumber;
					jQuery('#phone').val(phoneNumber);
				}

				//new validation
				jQuery('#updatemyaccountform').submit();

				// jQuery('#update-info').addClass('disable-btn');

				// if (iti.isValidNumber()) {
				// 	jQuery('#register-submit').prop("disabled", false);
				// 	jQuery('#update-info').prop("disabled", false);
				// 	validMsg.classList.remove("hide");
				// 	jQuery('#updatemyaccountform').submit();
				// 	console.log('update form');
				// } else {
				// 	jQuery('#register-submit').prop("disabled", true);
				// 	jQuery('#update-info').prop("disabled", true);

				// 	input.classList.add("error");
				// 	var errorCode = iti.getValidationError();
				// 	errorMsg.innerHTML = errorMap[errorCode];
				// 	errorMsg.classList.remove("hide");
				// 	jQuery('#update-info').removeClass('disable-btn');
				// }
				return false
			});
		},
		dataType: 'json'
	});
</script>