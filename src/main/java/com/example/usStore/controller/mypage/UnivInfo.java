package com.example.usStore.controller.mypage;

import java.io.Serializable;

@SuppressWarnings("serial")
public class UnivInfo implements Serializable{ //open api를 이용하여 데이터 입력받는 커맨드 객체
//Response
	private String campusName;
	private String collegeinfourl;
	private String schoolType;
	private String link;
	private String schoolGubun;
	private String adres;
	private String schoolName;
	private String region;
	private String totalCount;
	private String estType;
	private String seq;

	public UnivInfo() {
	}

	public UnivInfo(String campusName, String collegeinfourl, String schoolType, String link, String schoolGubun, String adres, String schoolName, String region, String totalCount, String estType, String seq) {
		this.campusName = campusName;
		this.collegeinfourl = collegeinfourl;
		this.schoolType = schoolType;
		this.link = link;
		this.schoolGubun = schoolGubun;
		this.adres = adres;
		this.schoolName = schoolName;
		this.region = region;
		this.totalCount = totalCount;
		this.estType = estType;
		this.seq = seq;
	}

	public String getCampusName() {
		return campusName;
	}

	public void setCampusName(String campusName) {
		this.campusName = campusName;
	}

	public String getCollegeinfourl() {
		return collegeinfourl;
	}

	public void setCollegeinfourl(String collegeinfourl) {
		this.collegeinfourl = collegeinfourl;
	}

	public String getSchoolType() {
		return schoolType;
	}

	public void setSchoolType(String schoolType) {
		this.schoolType = schoolType;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getSchoolGubun() {
		return schoolGubun;
	}

	public void setSchoolGubun(String schoolGubun) {
		this.schoolGubun = schoolGubun;
	}

	public String getAdres() {
		return adres;
	}

	public void setAdres(String adres) {
		this.adres = adres;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public String getEstType() {
		return estType;
	}

	public void setEstType(String estType) {
		this.estType = estType;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

}
