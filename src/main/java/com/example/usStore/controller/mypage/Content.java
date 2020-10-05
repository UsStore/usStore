package com.example.usStore.controller.mypage;

import java.util.List;

public class Content {

	private List<UnivInfo> univs;

	public Content() {
		super();
	}

	public Content(List<UnivInfo> univs) {
		super();
		this.univs = univs;
	}

	public List<UnivInfo> getUnivs() {
		return univs;
	}

	public void setUnivs(List<UnivInfo> univs) {
		this.univs = univs;
	}

	@Override
	public String toString() {
		return "Content [univs=" + univs + "]";
	}

	
    

}
