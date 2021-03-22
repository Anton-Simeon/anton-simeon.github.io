<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript">
	function login() {	
		jQuery.ajax({
	    	type: "POST",
	    	url: '/ajaxconfirmlogin',
	    	data: jQuery('#loginform').serialize(),
	    	success: function(response) {
	    		if (response.status == 'failure') {
	    			jQuery("#errorDiv").html("<div class=\"alert alert-dismissible alert-danger\"><button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Close\"></button>" + response.errorMessage + "</div>");
	    		} else {
	    			window.location = response.redirecturl;
	    		}
	    	},
	    	dataType: 'json'
	    });
		return false;
	};
</script>
<c:if test="${loginForm.myAccountFlow == false}">
	<c:set var="loginUrl"><fmt:message key='url.path.login' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.register' /></c:set>
	<c:set var="forgotLoginUrl"><fmt:message key='url.path.forgotlogin' /></c:set>
</c:if>
<c:if test="${loginForm.myAccountFlow == true}">
	<c:set var="loginUrl"><fmt:message key='url.path.myaccount.login' /></c:set>
	<c:set var="registerUrl"><fmt:message key='url.path.myaccount.register' /></c:set>
	<c:set var="forgotLoginUrl"><fmt:message key='url.path.myaccount.forgotlogin' /></c:set>
</c:if>
<form:form  method="post" modelAttribute="loginForm" id="loginform">
	<form:hidden path="companyId" />
	<div id="errorDiv"></div>
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
	<c:if test="${warningMessage != null}">
		<div class="alert alert-dismissible alert-warning">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${warningMessage}</strong>
		</div>
	</c:if>
	<div class="mb-3">
		<form:hidden path="refererUrl" />
		<label class="form-label" for="email"><fmt:message key="label.email" /><span class="required">*</span></label>
		<form:input path="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100"/>
	</div>
	<div class="mb-3">
		<label class="form-label" for="password"><fmt:message key="label.password" /> <span class="required">*</span></label>
		<form:password path="password" id="password" cssClass="form-control" htmlEscape="true" maxlength="15"/>
	</div>
	<div class="d-grid">
		<button type="button" class="btn btn-primary" onclick="login()">
			<fmt:message key="label.button.login" />
		</button>
	</div>
	<div class="authorization-form-footer mb-5">
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${forgotLoginUrl}?companyId=${companyId}" class="forgotpassword-button"><fmt:message key="label.link.forgotten.login" /></a>
				<h4><fmt:message key="label.newcustomer" /></h4>
				<a href="/${registerUrl}?companyId=${companyId}"  class="btn btn-primary">
					<fmt:message key="label.button.create.account" />
				</a>
			</c:when>
			<c:otherwise>
				<a href="/${forgotLoginUrl}" class="forgotpassword-button"><fmt:message key="label.link.forgotten.login" /></a>
				<h4><fmt:message key="label.newcustomer" /></h4>
				<a href="/${registerUrl}"  class="btn btn-primary">
					<fmt:message key="label.button.create.account" />
				</a>
			</c:otherwise>
		</c:choose>
	</div>
</form:form>