package com.example.usStore.controller.mypage;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SearchUniversity implements Serializable{ //open api를 이용하여 데이터 입력받는 커맨드 객체 

	private String region;
	private String univName; // 대학 이름 일부도 가능 
	
	
	public SearchUniversity() {
		super();
	}

	public SearchUniversity(String region, String univName) {
		super();
		this.region = region;
		this.univName = univName;
	}
	
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getUnivName() {
		return univName;
	}
	public void setUnivName(String univName) {
		this.univName = univName;
	}
	
	@Override
	public String toString() {
		return "SearchUniversity [region=" + region + ", univName=" + univName + "]";
	}
		
}
