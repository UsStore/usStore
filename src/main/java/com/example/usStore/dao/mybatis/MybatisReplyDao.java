package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.ReplyDao;
import com.example.usStore.dao.mybatis.mapper.ReplyMapper;
import com.example.usStore.domain.Reply;

@Transactional
@Qualifier("mybatisReplyDao")
@Repository
public class MybatisReplyDao implements ReplyDao{

	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public List<Reply> getReplyByItem(int itemId) {
		return replyMapper.getReplyByItem(itemId);
	}

	@Override
	public List<Reply> getReplyByQID(int QID) {
		return replyMapper.getReplyByQID(QID);
	}

	@Override
	public void insertReply(Reply reply) {
		replyMapper.insertReply(reply);
	}

	@Override
	public void updateReply(Reply reply) {
		replyMapper.updateReply(reply);
	}

	@Override
	public void deleteReply(Reply reply) {
		replyMapper.deleteReply(reply);
	}

}
