<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<c:set var="termsAndConditionsUrl"><fmt:message key='url.path.termsandconditions' /></c:set>
<c:if test="${registerForm.myAccountFlow == false}">
	<c:set var="ajaxloginUrl"><fmt:message key='url.path.ajaxlogin' /></c:set>
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.ajaxregister' /></c:set>
</c:if>
<c:if test="${registerForm.myAccountFlow == true}">
	<c:set var="ajaxloginUrl"><fmt:message key='url.path.myaccount.ajaxlogin' /></c:set>
	<c:set var="ajaxregisterUrl"><fmt:message key='url.path.myaccount.ajaxregister' /></c:set>
</c:if>
<c:set var="currentCustomerLocale" value="['en', 'US']" />
<c:if test="${not empty sessionScope['javax.servlet.jsp.jstl.fmt.locale.session']}">
	<c:set var="currentCustomerLocale" value="${fn:split(sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'], '_')}" />
</c:if>
<div class="modal-header">
	<h4 class="modal-title"><fmt:message key='header.create.new.account.popup' /></h4>
	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
</div>
<div class="modal-body">
	<form:form method="post" modelAttribute="registerForm" id="registerform">
		<form:hidden path="refererUrl" />
		<form:hidden path="companyId"/>
		<form:hidden path="language" id="language" value="${currentCustomerLocale[0]}" />
		<form:hidden path="country" id="country" value="${currentCustomerLocale[1]}" />
		<input type="hidden" name="isResponsiveLayout" value="true" >
		<div id="errorDiv"></div>
		<div class="mb-3">
			<fmt:message key="label.firstname" var="var_firstname" />
			<form:input path="firstName" id="firstname" cssClass="form-control" placeholder="${var_firstname}" htmlEscape="true" maxlength="60" />
		</div>
		<div class="mb-3">
			<fmt:message key="label.lastname" var="var_lastname" />
			<form:input path="lastName" id="lastname" cssClass="form-control" placeholder="${var_lastname}" htmlEscape="true" maxlength="60" />
		</div>
		<div class="mb-3">
			<fmt:message key="label.email2" var="var_email2" />
			<form:input path="email" type="email" id="email" cssClass="form-control" placeholder="${var_email2}" htmlEscape="true" maxlength="100" />
		</div>
		<div class="mb-3">
			<fmt:message key="label.password" var="var_password" />
			<form:password path="password" id="password" cssClass="form-control" placeholder="${var_password}" htmlEscape="true" maxlength="15" />
		</div>
		<div class="mb-3">
			<fmt:message key="label.phone" var="var_phone" />
			<div class="form-position">
				<form:input path="phone" id="phone-popup" type="tel" cssClass="form-control" htmlEscape="true" maxlength="40" />
				<span id="valid-msg-popup" class="hide">✓</span>
				<span id="error-msg-popup" class="hide"></span>
			</div>
		</div>
		<div class="mb-3 form-check">
			<form:checkbox path="promotionSms" id="promotionsms" />
			<label for="receivepromotionsbysms"><fmt:message key="label.receivepromotionsms" /></label>
		</div>
		<div class="mb-3 form-check">
			<form:checkbox path="promotionEmail" id="promotionemail" />
			<label for="receivepromotionsbyemail"><fmt:message key="label.receivepromotionemail" /></label>
		</div>
		<div class="mb-3">
			<div class="g-recaptcha form-field" data-sitekey="6Ldzu7oUAAAAAFthepGOvQuhVh1ZjgDh3GWGgu9H"></div>
		</div>
	</form:form>
	<div class="d-grid mb-1">
		<button type="submit" class="btn btn-primary" id="register-popup-button"><fmt:message key="label.button.register.popup" /></button>
	</div>
</div>
<div class="modal-footer">
	<h4><fmt:message key="label.link.alreadyregister.popup" /></h4>
	<c:choose>
		<c:when test="${widgetSite == 'true'}">
			<button type="button" data-modal-href="/${ajaxloginUrl}?companyId=${companyId}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
				<fmt:message key="label.button.login" />
			</button>
		</c:when>
		<c:otherwise>
			<button type="button" data-modal-href="/${ajaxloginUrl}" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
				<fmt:message key="label.button.login" />
			</button>
		</c:otherwise>
	</c:choose>
</div>
<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl=<%= WebContextUtil.getDefaultLocale().getLanguage() %>"></script>
<script type="text/javascript">
$(document).ready(function () {
	if( $(window).width() > 1025 ) {
		$("#firstname").focus();
	}
});
</script>
<script type="text/javascript">
$.ajax({
	type: "GET",
	url: '/phones/countrycode?companyId=${company.id}',
	success: function(response) {
		console.log(response);
		var countryCode = response.country;

		var input = document.querySelector("#phone-popup"),
			errorMsg = document.querySelector("#error-msg-popup"),
			validMsg = document.querySelector("#valid-msg-popup");
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
		});


		function disableFun() {
			if (iti.isValidNumber()) {
				$('#register-popup-button').prop("disabled", false);
				validMsg.classList.remove("hide");
			} else {
				$('#register-popup-button').prop("disabled", true);

				input.classList.add("error");
				var errorCode = iti.getValidationError();
				errorMsg.innerHTML = errorMap[errorCode];
				errorMsg.classList.remove("hide");
			}

		}

		$('#register-popup-button').click(function() {
			var beforeNumber = $('.iti__selected-dial-code').text();
			var phoneNumber = $('#phone-popup').val();
			if (phoneNumber[0] != "+") {
				phoneNumber = beforeNumber + phoneNumber;
				$('#phone-popup').val(phoneNumber);
			}
			$('#register-popup-button').prop("disabled", true);

				setTimeout(function() {
					$.ajax({
						type: "POST",
						url: '/myaccount/ajaxregister',
						data: $('#registerform').serialize(),
						success: function(response) {
							if (response.status == 'failure') {
								$('#register-popup-button').prop("disabled", false);
								$("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
							} else {
								window.location = response.redirecturl;
							}
						},
						dataType: 'json'
					});
				}, 100);

			return false
		});
	},
	dataType: 'json'
});
</script>