package com.example.usStore.service;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.example.usStore.domain.Review;

@Component
public class ReviewValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Review.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("리뷰 validation");
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "required");
	}
}
