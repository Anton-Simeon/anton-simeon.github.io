<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="verificationVerifyUrl"><fmt:message key='url.path.verification.verify' /></c:set>
<c:set var="verificationResendUrl"><fmt:message key='url.path.verification.resend' /></c:set>
<h2><fmt:message key='header.verification.verify' /></h2>
<div class="row">	
	<form:form action="/${verificationVerifyUrl}" method="post" modelAttribute="verificationForm" id="verificationform" role="form" class="col-md-6 col-sm-10 col-xs-12">
		<form:hidden path="actionFlow" value="verify" />
		<spring:bind path="*">		
		<div class="alert alert-dismissible alert-info"><fmt:message key='verification.info.verifycode' /></div>
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
		<c:if test="${verifySuccessMessage != null}">
			<div class="alert alert-dismissible alert-success">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${verifySuccessMessage}</strong>
			
			</div>
		</c:if>		
		<c:if test="${verifyWarningMessage != null}">
	        <div class="alert alert-dismissible alert-danger">
	            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		        <strong>${verifyWarningMessage}</strong>
		        
		    </div>
	    </c:if>
		<div class="mb-3">
			<label for="code"><fmt:message key="label.verification.code" /><span class="required">*</span></label>
			<form:input path="code" id="code" class="form-control" htmlEscape="true" maxlength="10" />
		</div>		
		<div class="form-group text-center buttons-wrap">			
			<button type="submit" class="btn btn-primary btn-block">
				<fmt:message key="label.button.verifycode" />
			</button>			
		</div>
	</form:form>
</div>
<h2><fmt:message key='header.verification.resend' /></h2>
<div class="row">	
	<form:form action="/${verificationResendUrl}" method="post" modelAttribute="verificationForm" id="verificationform" role="form" class="col-md-6 col-sm-10 col-xs-12">
		<form:hidden path="actionFlow" value="sendotp" />
		<spring:bind path="*">
		<div class="alert alert-dismissible alert-info"><fmt:message key='verification.info.requestcode' /></div>
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
		<c:if test="${resendSuccessMessage != null}">
			<div class="alert alert-dismissible alert-success">
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			<strong>${resendSuccessMessage}</strong>
			
			</div>
		</c:if>		
		<c:if test="${resendWarningMessage != null}">
	        <div class="alert alert-dismissible alert-danger">
	            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		        <strong>${resendWarningMessage}</strong>
		        
		    </div>
	    </c:if>
		<div class="mb-3">
			<label for="phone"><fmt:message key="label.mobile" /><span class="required">*</span></label>
			<form:input path="phone" id="phone" class="form-control" htmlEscape="true" maxlength="20" />
		</div>		
		<div class="form-group text-center buttons-wrap">			
			<button type="submit" class="btn btn-primary btn-block">
				<fmt:message key="label.button.resendcode" />
			</button>			
		</div>
	</form:form>
</div>