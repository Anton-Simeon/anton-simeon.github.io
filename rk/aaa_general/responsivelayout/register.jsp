<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<c:set var="termsAndConditionsUrl"><fmt:message key='url.path.termsandconditions' /></c:set>
<c:if test="${registerForm.myAccountFlow == false}">
	<c:set var="loginUrl"><fmt:message key='url.path.login' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.register' /></c:set>
</c:if>
<c:if test="${registerForm.myAccountFlow == true}">
	<c:set var="loginUrl"><fmt:message key='url.path.myaccount.login' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.myaccount.register' /></c:set>
</c:if>
<c:set var="currentCustomerLocale" value="['en', 'US']" />
<c:if test="${not empty sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
	<c:set var="currentCustomerLocale" value="${fn:split(sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'], '_')}" />
</c:if>
<c:set var="shoppingCartEmpty" value="TRUE" />
<c:set var="customerOrder" value="${customerOrder}" />
<form:form action="/${registerUrl}" method="post" modelAttribute="registerForm" id="registerform" role="form">
	<form:hidden path="companyId"/>
	<spring:bind path="*">
	<c:set var="validationErrors"><form:errors path="*"/></c:set>
	<c:if test="${not empty validationErrors}"> 
		<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>
			<c:forEach var="error" items="${status.errors.allErrors}">
				<fmt:message key="${error.code}"></fmt:message> <br />
			</c:forEach>
		</strong>
	</div>
	</c:if>
	</spring:bind>
	<input type="hidden" name="isResponsiveLayout" value="true" >
	<form:hidden path="language" id="language" value="${currentCustomerLocale[0]}" />
	<form:hidden path="country" id="country" value="${currentCustomerLocale[1]}" />
	<c:if test="${warningMessage != null}">
		<div class="alert alert-dismissible alert-danger">
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		<strong>${warningMessage}</strong>
		</div>
	</c:if>
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
		<form:input path="email" type="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100" />
	</div>
	<div class="mb-3">
		<label class="form-label" for="password"><fmt:message key="label.password" /> <span class="required">*</span></label>
		<form:password path="password" id="password" cssClass="form-control" htmlEscape="true" maxlength="15" />
	</div>
	<div class="mb-4">
		<label class="form-label" for="phone"><fmt:message key="label.phone" /> <span class="required">*</span></label>
		<div class="form-position">
			<form:input path="phone" id="phone" type="tel" cssClass="form-control" htmlEscape="true" maxlength="40" />
			<span id="valid-msg" class="hide">✓</span>
			<span id="error-msg" class="hide"></span>
		</div>
	</div>
	<div class="mb-3 form-check">
		<form:checkbox path="promotionSms" id="promotionsms" />
		<label class="form-label" for="promotionsms"><b><fmt:message key="label.receivepromotionsms" /></b></label>
	</div>
	<div class="mb-4 form-check">
		<form:checkbox path="promotionEmail" id="promotionemail" />
		<label class="form-label" for="promotionemail"><b><fmt:message key="label.receivepromotionemail" /></b></label>
	</div>
	<div class="mb-3">
		<div class="g-recaptcha form-field" data-sitekey="6Ldzu7oUAAAAAFthepGOvQuhVh1ZjgDh3GWGgu9H"></div>
	</div>
	<div class="d-grid">
		<button type="submit" class="btn btn-primary" id="register-submit">
			<fmt:message key="label.button.register.popup" />
		</button>
	</div>
	<div class="authorization-form-footer mb-5">
		<h4><fmt:message key="label.link.alreadyregister.popup" /></h4>
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${loginUrl}?companyId=${companyId}" class="btn btn-primary">
					<fmt:message key="label.button.login" />
				</a>
			</c:when>
			<c:otherwise>
				<a href="/${loginUrl}" class="btn btn-primary">
					<fmt:message key="label.button.login" />
				</a>
			</c:otherwise>
		</c:choose>
	</div>


</form:form>
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl=<%= WebContextUtil.getDefaultLocale().getLanguage() %>"></script>
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
			
			
			var iti = window.intlTelInput(input, {
					initialCountry: countryCode,
					separateDialCode: true,
				    geoIpLookup: function(callback) {
					$.get('https://ipinfo.io', function() {}, "jsonp").always(function(resp) {
						var countryCode = (resp && resp.country) ? resp.country : "us";
						callback(countryCode);
				    });
				  },
				  utilsScript: "/static/aaa_general/js/intl-tel-input/utils.js" // just for formatting/placeholders etc
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
		
				//   if (iti.isValidNumber()) {
				// 	var valPhone = $('#phone').val();
					
					
		
				// 	var codeNumber = iti.selectedCountryData.dialCode;
				// 	var valPhoneFirst = valPhone[0]
			
				// 	var codeNumberLast = codeNumber[codeNumber.length - 1];
		
		
				// 	console.log(valPhoneFirst);
				// 	console.log(codeNumberLast);
				// 	if(valPhoneFirst == "0" && codeNumberLast == "0") {
				// 		var lenghNumber = codeNumber.length - 1;
				// 		codeNumber = codeNumber.substr(0, lenghNumber);
				// 		console.log(codeNumber);
				// 	}
		
		
					// if(valPhone[0] != "+") {
					// 	var valPhoneNew = "+" + codeNumber + valPhone;
					// 	$('#phone').val(valPhoneNew);
					// }
			
					// 	$('#register-submit').prop("disabled", false);
					//     validMsg.classList.remove("hide");
					// } else {
					// 	$('#register-submit').prop("disabled", true);
			
					
					//     input.classList.add("error");
					//     var errorCode = iti.getValidationError();
					//     errorMsg.innerHTML = errorMap[errorCode];
					//     errorMsg.classList.remove("hide");
					// }
				// }
			});

			function disableFun() {
				if (iti.isValidNumber()) {
					$('#register-submit').prop("disabled", false);
					validMsg.classList.remove("hide");
				} else {
					$('#register-submit').prop("disabled", true);
					input.classList.add("error");
					var errorCode = iti.getValidationError();
					errorMsg.innerHTML = errorMap[errorCode];
					errorMsg.classList.remove("hide");
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

			$('#register-submit').click(function() {
				var beforeNumber = $('.iti__selected-dial-code').text();
				var phoneNumber = $('#phone').val();
				if (phoneNumber[0] != "+") {
					phoneNumber = beforeNumber + phoneNumber;
					$('#phone').val(phoneNumber);
				}

				//new validation
				$('#registerform').submit();


				return false
			});
	},
		dataType: 'json'
	});
</script>