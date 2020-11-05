package com.example.usStore.dao.mybatis.mapper;

import java.util.List;

import com.example.usStore.domain.Inquiry;

public interface InquiryMapper {
	
	List<Inquiry> getInquiryByItem(int itemId);
	
	List<Inquiry> getInquiryByUserId(String userId);
	
	void insertInquiry(Inquiry inquiry);
	
	void updateInquiry(Inquiry inquiry);
	
	void deleteInquiry(int QID);
	
}
