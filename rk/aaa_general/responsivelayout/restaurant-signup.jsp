<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row contatus-email">
	<div class="col-md-4 col-sm-3 col-xs-3"></div>
	<div class="col-md-4 col-sm-6 col-xs-12">
		<h1>${param.pageTitle}</h1>
		<c:choose>
			<c:when test="${not empty isSuccess}">
				<br><br>
				<c:choose>
					<c:when test="${isSuccess}">
						<h2 class="success">
							<fmt:message key="label.contactusemail.message.success">
								 <fmt:param value="${param.pageTitle}"/>
							</fmt:message>
						</h2>
					</c:when>
					<c:otherwise>
						<h2 class="failure"><fmt:message key="label.contactusemail.message.failure"></fmt:message></h2>
					</c:otherwise>
				</c:choose>
				<br>
			</c:when>
			<c:otherwise>
				<form:form action="" method="POST" modelAttribute="storeSignUpDetails">
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
					<div class="contatus-email-form">
						<div class="mb-3">
							<label for="fullName"><fmt:message key="label.fullname" /> <span class="required">*</span></label>
							<form:input path="fullName" id="fullName" cssClass="form-control" htmlEscape="true" maxlength="60" />
						</div>
						<div class="mb-3">
							<label for="storeName"><fmt:message key="label.storename" /> <span class="required">*</span></label>
							<form:input path="storeName" id="storeName" cssClass="form-control" htmlEscape="true" maxlength="60" />
						</div>
						<div class="mb-3">
							<label for="phoneNumber"><fmt:message key="label.phone" /> <span class="required">*</span></label>
							<form:input path="phoneNumber" id="phoneNumber" cssClass="form-control" htmlEscape="true" maxlength="40" />
						</div>
						<div class="mb-3">
							<label for="townCity"><fmt:message key="label.city" /> <span class="required">*</span></label>
							<form:input path="townCity" id="townCity" cssClass="form-control" htmlEscape="true" maxlength="60" />
						</div>
						<div class="mb-3">
							<label for="emailFrom"><fmt:message key="label.email2" /> <span class="required">*</span></label>
							<form:input path="emailFrom" id="emailFrom" cssClass="form-control" htmlEscape="true" maxlength="100" />
						</div>
						<form:hidden path="emailTo" value="${param.emailTo}" />
						<div class="mb-3">
							<label for="message"><fmt:message key="label.message" /> <span class="required">*</span></label>
							<form:textarea class="form-control" rows="3"  path="message" htmlEscape="true" ></form:textarea>
						</div>
						<button class="btn btn-block btn-primary full-width contatus-email-button" type="submit"><fmt:message key="label.button.submit"></fmt:message></button>
					</div>
				</form:form>
			</c:otherwise>
		</c:choose>			
	</div>
	<div class="col-md-3 col-sm-3 col-xs-3"></div>
</div>