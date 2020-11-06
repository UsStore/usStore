package com.example.usStore.dao;

import java.util.List;

import com.example.usStore.domain.Reply;

public interface ReplyDao {

	List<Reply> getReplyByItem(int itemId);
	
	List<Reply> getReplyByQID(int QID);
	
	void insertReply(Reply reply);
	
	void updateReply(Reply reply);
	
	void deleteReply(Reply reply);
	
}
