package com.example.usStore.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class University implements Serializable{
	//DTO

	private String univName; // (PK)
	private String univLink;
	private String univAddr;
	
	public String getUnivName() {
		return univName;
	}
	public void setUnivName(String univName) {
		this.univName = univName;
	}
	public String getUnivLink() {
		return univLink;
	}
	public void setUnivLink(String univLink) {
		this.univLink = univLink;
	}
	public String getUnivAddr() {
		return univAddr;
	}
	public void setUnivAddr(String univAddr) {
		this.univAddr = univAddr;
	}
	
	@Override
	public String toString() {
		return "University [univName=" + univName + ", univLink=" + univLink + ", univAddr=" + univAddr + "]";
	}
	
}
