package com.example.usStore.dao;

import java.util.List;

import com.example.usStore.domain.Inquiry;

public interface InquiryDao {
	
	List<Inquiry> getInquiryByItem(int itemId);
	
	List<Inquiry> getInquiryByUserId(String userId);
	
	void insertInquiry(Inquiry inquiry);
	
	void updateInquiry(Inquiry inquiry);
	
	void deleteInquiry(int QID);

}
