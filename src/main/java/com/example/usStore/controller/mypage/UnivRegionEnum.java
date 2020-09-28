package com.example.usStore.controller.mypage;

public enum UnivRegionEnum {

	서울특별시(100260), 부산광역시(100267), 인천광역시(100269), 대전광역시(100271), 대구광역시(100272),
	울산광역시(100273), 광주광역시(100275), 경기도(100276), 강원도(100278), 충청북도(100281), 충청남도(100281),
	전라북도(100282), 전라남도, 경상북도(100285), 경상남도(100291), 제주도(100292), 선택하세요(-1);
	
	private int code;
	
	private UnivRegionEnum() {}
	
	private UnivRegionEnum(int code) {
		this.code = code;
	}
	
	public int getCode() {
		return code;
	}
 
	public static int getCode(String region) {
		return 	UnivRegionEnum.valueOf(region).getCode();
	}
 

	
}