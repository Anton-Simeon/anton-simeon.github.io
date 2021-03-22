<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="row vdivide">
	<div class="col-sm-6 col-xs-12">
		<h2 class="medium"><fmt:message key='label.returning.customer' /></h2>
		<div class="row">
			<form:form  method="post" modelAttribute="loginForm" id="loginform" class="col-md-10 col-sm-10 col-xs-12">
				<form:hidden path="companyId"/>
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
					<label for="email"><fmt:message key="label.email" /><span class="required">*</span></label>
					<form:input path="email" id="email" cssClass="form-control" htmlEscape="true" maxlength="100" />
				</div>
				<div class="mb-3">
					<label for="password"><fmt:message key="label.password" /> <span class="required">*</span></label>
					<form:password path="password" id="password" cssClass="form-control" htmlEscape="true" maxlength="15"/>
				</div>
				<div class="mb-3">
					<c:choose>
						<c:when test="${param.custombuttons == 'yes'}">
							<c:choose>
								<c:when test="${param.hoverbuttons == 'yes'}">
									<button type="button" class="btn btn-primary btn-block" onclick="login()">
										<span class="text-large"><fmt:message key="label.button.login" /></span>
									</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-primary btn-block" onclick="login()">
										<span class="text-large"><fmt:message key="label.button.login" /></span>
									</button>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-primary btn-block" onclick="login()">
								<span class="text-large"><fmt:message key="label.button.login" /></span>
							</button>
						</c:otherwise>
					</c:choose>
					<div class="forgot-text">
						<c:choose>
							<c:when test="${widgetSite == 'true'}">
								<a href="/${forgotLoginUrl}?companyId=${companyId}" class="forgotpassword-button">
									<b><fmt:message key="label.link.forgotten.login" /></b>
								</a>
							</c:when>
							<c:otherwise>
								<a href="/${forgotLoginUrl}" class="forgotpassword-button">
									<b><fmt:message key="label.link.forgotten.login" /></b>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>	
			</form:form>
		</div>
	</div>
	<div class="col-sm-6 col-xs-12">
		<br /><br />
		<h2 class="small"><fmt:message key="label.login.text.savetimelater" /></h2>
		<fmt:message key='label.login.text.createaccount' /><br /><br />
		<c:choose>
			<c:when test="${widgetSite == 'true'}">
				<a href="/${registerUrl}?companyId=${companyId}"><button type="button" class="btn btn-primary full-width">
					<span class="text-large"><fmt:message key="label.button.create.account" /></span>
				</button></a>
			</c:when>
			<c:otherwise>
				<a href="/${registerUrl}"><button type="button" class="btn btn-primary full-width">
					<span class="text-large"><fmt:message key="label.button.create.account" /></span>
				</button></a>
			</c:otherwise>
		</c:choose>
	</div>
</div>