package com.example.usStore.service.facade;

import java.util.List;

import com.example.usStore.domain.Inquiry;
import com.example.usStore.domain.Reply;

public interface InquiryFacade {
	
	/////////////////////////////////////////////////////////////////////////
	/* Inquiry */
	/////////////////////////////////////////////////////////////////////////

	List<Inquiry> getInquiryByItem(int itemId);
	
	List<Inquiry> getInquiryByUserId(String userId);
	
	void insertInquiry(Inquiry inquiry);
	
	void updateInquiry(Inquiry inquiry);
	
	void deleteInquiry(int QID);
	
	/////////////////////////////////////////////////////////////////////////
	/* Reply */
	/////////////////////////////////////////////////////////////////////////
	 
	List<Reply> getReplyByItem(int itemId);
	
	List<Reply> getReplyByQID(int QID);
	
	void insertReply(Reply reply);
	
	void updateReply(Reply reply);
	
	void deleteReply(Reply reply);

}
