package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.example.usStore.dao.ReplyDao;
import com.example.usStore.dao.mybatis.mapper.ReplyMapper;
import com.example.usStore.domain.Reply;

public class MybatisReplyDao implements ReplyDao{

	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	public List<Reply> getReplyByItem() {
		return replyMapper.getReplyByItem();
	}

	@Override
	public List<Reply> getReplyByQID() {
		return replyMapper.getReplyByQID();
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
