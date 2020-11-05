package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.InquiryDao;
import com.example.usStore.dao.mybatis.mapper.InquiryMapper;
import com.example.usStore.domain.Inquiry;

@Transactional
@Qualifier("mybatisInquiryDao")
@Repository
public class MybatisInquiryDao implements InquiryDao {

	
	@Autowired
	private InquiryMapper inquiryMapper;
	
	@Override
	public List<Inquiry> getInquiryByItem(int itemId) {
		return inquiryMapper.getInquiryByItem(itemId);
	}

	@Override
	public List<Inquiry> getInquiryByUserId(String userId) {
		return inquiryMapper.getInquiryByUserId(userId);
	}

	@Override
	public void insertInquiry(Inquiry inquiry) {
		inquiryMapper.insertInquiry(inquiry);
		
	}

	@Override
	public void updateInquiry(Inquiry inquiry) {
		inquiryMapper.updateInquiry(inquiry);
	}

	@Override
	public void deleteInquiry(int QID) {
		inquiryMapper.deleteInquiry(QID);
	}

}
