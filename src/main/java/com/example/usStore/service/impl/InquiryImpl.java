package com.example.usStore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.InquiryDao;
import com.example.usStore.dao.ReplyDao;
import com.example.usStore.domain.Inquiry;
import com.example.usStore.domain.Reply;
import com.example.usStore.service.facade.InquiryFacade;


@Repository
@Service("inquiryImpl")
@Transactional
public class InquiryImpl implements InquiryFacade{

	@Autowired
	private InquiryDao inquiryDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	/////////////////////////////////////////////////////////////////////////
	/* Inquiry */
	/////////////////////////////////////////////////////////////////////////

	
	@Override
	public List<Inquiry> getInquiryByItem(int itemId) {
		return inquiryDao.getInquiryByItem(itemId);
	}

	@Override
	public List<Inquiry> getInquiryByUserId(String userId) {
		return inquiryDao.getInquiryByUserId(userId);
	}

	@Override
	public void insertInquiry(Inquiry inquiry) {
		inquiryDao.insertInquiry(inquiry);
	}

	@Override
	public void updateInquiry(Inquiry inquiry) {
		inquiryDao.updateInquiry(inquiry);
	}

	@Override
	public void deleteInquiry(int QID) {
		inquiryDao.deleteInquiry(QID);
	}

	
/////////////////////////////////////////////////////////////////////////
/* Reply */
/////////////////////////////////////////////////////////////////////////

	
	@Override
	public List<Reply> getReplyByItem() {
		return replyDao.getReplyByItem();
	}

	@Override
	public List<Reply> getReplyByQID() {
		return replyDao.getReplyByQID();
	}

	@Override
	public void insertReply(Reply reply) {
		replyDao.insertReply(reply);
	}

	@Override
	public void updateReply(Reply reply) {
		replyDao.updateReply(reply);
	}

	@Override
	public void deleteReply(Reply reply) {
		replyDao.deleteReply(reply);
	}
	
}
