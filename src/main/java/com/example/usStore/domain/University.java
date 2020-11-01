package com.example.usStore.domain;

import java.io.Serializable;

@SuppressWarnings("serial")
public class University implements Serializable{
	//DTO

	private String univName; // (PK)
	private String univLink;
	private String univAddr;
	private int isExistUniv; // 디비에 해당 대학이 이미 있는지 여부를 알려줌 
	
	public University() {}
	
	public University(String univName, String univLink, String univAddr) {
		super();
		this.univName = univName;
		this.univLink = univLink;
		this.univAddr = univAddr;
	}
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
	public int isExistUniv() {
		return isExistUniv;
	}
	public void setExistUniv(int isExistUniv) {
		this.isExistUniv = isExistUniv;
	}

	@Override
	public String toString() {
		return "University [univName=" + univName + ", univLink=" + univLink + ", univAddr=" + univAddr;
	}
	
}
