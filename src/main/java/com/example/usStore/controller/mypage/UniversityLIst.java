package com.example.usStore.controller.mypage;

import java.util.List;

public class UniversityLIst {

	private List<?> items;
	private int totalCount;
	
	public List<?> getItems() {
		return items;
	}
	public void setItems(List<?> items) {
		this.items = items;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	@Override
	public String toString() {
		return "UniversityLIst [items=" + items + ", totalCount=" + totalCount + "]";
	}
	
}
