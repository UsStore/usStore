package com.example.usStore.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Inquiry implements Serializable{
	private int QID; // PK - seq
	private String title;
	private String content;
	private String userId; // FK - Account
	private int itemId; // FK - Item 
	private String isSecret; // "0" :공개, "1": 비공개 
	private int isAnswer; // "0" : 답변예정 , "1": 답변완료 
	private String ts; //time stamp
	
	public Inquiry() {}
	public Inquiry(int qID, String title, String content, String userId, int itemId, String isSecret, int isAnswer,
			String ts) {
		QID = qID;
		this.title = title;
		this.content = content;
		this.userId = userId;
		this.itemId = itemId;
		this.isSecret = isSecret;
		this.isAnswer = isAnswer;
		this.ts = ts;
	}
	public int getQID() {
		return QID;
	}
	public void setQID(int qID) {
		QID = qID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getIsSecret() {
		return isSecret;
	}
	public void setIsSecret(String isSecret) {
		this.isSecret = isSecret;
	}
	public int getIsAnswer() {
		return isAnswer;
	}
	public void setIsAnswer(int isAnswer) {
		this.isAnswer = isAnswer;
	}
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	
//	 String -> java.sql.Timestamp 변환
//	String now = "2009-03-20 10:20:30.0"; // 형식을 지켜야 함
//	java.sql.Timestamp t = java.sql.Timestamp.valueOf(now);
//
//	
	
	
	
	

}
