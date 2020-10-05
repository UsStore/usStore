package com.example.usStore.service;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import com.example.usStore.domain.Orders;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 */
@Component
public class OrderValidator implements Validator {

	public boolean supports(Class<?> clazz) {
		return Orders.class.isAssignableFrom(clazz);
	}

	public void validate(Object obj, Errors errors) {
		validateCreditCard((Orders) obj, errors);
		validateBillingAddress((Orders) obj, errors);
		validateShippingAddress((Orders) obj, errors);
	}

	public void validateCreditCard(Orders order, Errors errors) {
		errors.setNestedPath("order");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "creditCard", "CCN_REQUIRED", "FAKE (!) credit card number required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "expiryDate", "EXPIRY_DATE_REQUIRED", "Expiry date is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "cardType", "CARD_TYPE_REQUIRED", "Card type is required.");
		errors.setNestedPath("");
	}

	public void validateBillingAddress(Orders order, Errors errors) {
		errors.setNestedPath("order");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billToUsername", "FIRST_NAME_REQUIRED", "Billing Info: 성함을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billAddr1", "ADDRESS_REQUIRED", "Billing Info: 주소를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billAddr2", "ADDRESS_REQUIRED", "Billing Info: 주소를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billCity", "CITY_REQUIRED", "Billing Info: 도시 정보를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billZip", "ZIP_REQUIRED", "Billing Info: 우편번호를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "billCountry", "COUNTRY_REQUIRED", "Billing Info: 국가 정보를 입력해주세요.");
		errors.setNestedPath("");
	}

	public void validateShippingAddress(Orders order, Errors errors) {
		errors.setNestedPath("order");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipToUsername", "FIRST_NAME_REQUIRED", "Shipping Info: 성함을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipAddr1", "ADDRESS_REQUIRED", "Shipping Info: 주소를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipAddr2", "ADDRESS_REQUIRED", "Shipping Info: 주소를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipCity", "CITY_REQUIRED", "Shipping Info: 도시 정보를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipZip", "ZIP_REQUIRED", "Shipping Info: 우편번호를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shipCountry", "COUNTRY_REQUIRED", "Shipping Info: 국가 정보를 입력해주세요.");
		errors.setNestedPath("");
	}
}