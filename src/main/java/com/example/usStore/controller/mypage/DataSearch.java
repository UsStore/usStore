package com.example.usStore.controller.mypage;

public class DataSearch {

	private Content content;	

	public DataSearch() {
		super();
	}

	public Content getContent() {
		return content;
	}

	public void setContent(Content content) {
		this.content = content;
	}

	public DataSearch(Content content) {
		super();
		this.content = content;
	}

	@Override
	public String toString() {
		return "DataSearch [content=" + content + "]";
	}	

    
}
