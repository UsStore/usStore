package com.example.usStore.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Reply implements Serializable{
	
	private int RID; // PK - seq
	private String content;
	private String userId; // FK - Account
	private int QID; // FK - Inquiry 
	private String ts; //time stamp
	
	public Reply() {}
	public Reply(int rID, String content, String userId, int qID, String ts) {
		super();
		RID = rID;
		this.content = content;
		this.userId = userId;
		QID = qID;
		this.ts = ts;
	}
	public int getRID() {
		return RID;
	}
	public void setRID(int rID) {
		RID = rID;
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
	public int getQID() {
		return QID;
	}
	public void setQID(int qID) {
		QID = qID;
	}
	public String getTs() {
		return ts;
	}
	public void setTs(String ts) {
		this.ts = ts;
	}
	
	

}
