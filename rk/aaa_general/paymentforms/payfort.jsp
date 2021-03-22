<%@ page language="java" pageEncoding="UTF-8" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.apache.commons.codec.digest.DigestUtils" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.springframework.context.MessageSource" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="com.blueplustechnologies.core.model.Company" %>
<%@ page import="com.blueplustechnologies.core.model.Customer" %>
<%@ page import="com.blueplustechnologies.core.model.CustomerOrder" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethod" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegration" %>
<%@ page import="com.blueplustechnologies.core.model.PaymentMethodIntegrationParam" %>
<%@ page import="com.blueplustechnologies.plastocart.util.WebContextUtil" %>
<%
	WebApplicationContext springContext =  WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
	MessageSource messageSource = (MessageSource)springContext.getBean("messageSource");

	PaymentMethod paymentMethod = (PaymentMethod) WebContextUtil.getSession().getAttribute("paymentmethod");
	Customer customer = (Customer) WebContextUtil.getSession().getAttribute("customer");
	CustomerOrder customerOrder = (CustomerOrder) WebContextUtil.getSession().getAttribute("customerorder");
	
	PaymentMethodIntegration paymentMethodIntegration = paymentMethod.getPaymentMethodIntegration();
	String accessCode = null;
	String merchantIdentifier = null;
	String currency = null;
	String language = null;
	String amount = customerOrder.getSubTotal().multiply(new BigDecimal(100)).toString();
	
	if (paymentMethodIntegration != null && paymentMethodIntegration.getPaymentMethodIntegrationParams() != null) {
		for (PaymentMethodIntegrationParam thisPaymentMethodIntegrationParam: paymentMethodIntegration.getPaymentMethodIntegrationParams()) {
			if (thisPaymentMethodIntegrationParam.getKey().equals("access_code")) {
				accessCode = thisPaymentMethodIntegrationParam.getValue();
			} else if (thisPaymentMethodIntegrationParam.getKey().equals("merchant_identifier")) {
				merchantIdentifier = thisPaymentMethodIntegrationParam.getValue();
			} else if (thisPaymentMethodIntegrationParam.getKey().equals("currency")) {
				currency = thisPaymentMethodIntegrationParam.getValue();
			} else if (thisPaymentMethodIntegrationParam.getKey().equals("language")) {
				language = thisPaymentMethodIntegrationParam.getValue();
			}
		}
	}
	
	String signature = 
			"OTPASS"
			+ "access_code="+accessCode
			+ "amount="+amount
			+ "command=PURCHASE" 
			+ "currency="+currency
			+ "customer_email=" + StringEscapeUtils.escapeJavaScript(customer.getEmail())
			+ "customer_name=" + StringEscapeUtils.escapeJavaScript(customer.getFirstName() + " " + customer.getLastName())
			+ "language=" + language
			+ "merchant_identifier=" + merchantIdentifier
			+ "merchant_reference=" + customerOrder.getTransId()
			+ "OTPASS";
%>
<form action="https://sbcheckout.payfort.com/FortAPI/paymentPage" method="POST" id="form1" name="form1">
	<input type="hidden" id="command" name="PURCHASE" />
	<input type="hidden" name="access_code" value=" accessCode  " />
	<input type="hidden" name="amount" value="<%= amount %>" />
	<input type="hidden" name="currency" value="<%= currency %>" />		
	<input type="hidden" name="customer_email" value="<%= StringEscapeUtils.escapeJavaScript(customer.getEmail()) %>" />
	<input type="hidden" name="customer_name" value="<%= StringEscapeUtils.escapeJavaScript(customer.getFirstName() + " " + customer.getLastName()) %>" />		
	<input type="hidden" name="language" value="<%= language %>" />
	<input type="hidden" name="merchant_identifier" value="<%= merchantIdentifier %>" />
	<input type="hidden" name="merchant_reference" value="<%= customerOrder.getTransId() %>" />
	<input type="hidden" name="signature" value="<%= DigestUtils.sha256Hex(signature) %>" />
	<button id="payFortSubmitButton" type="submit" class="btn btn-primary btn-block"><%= messageSource.getMessage("label.button.paybycard.standard", null, WebContextUtil.getDefaultLocale()) %></button>
</form>