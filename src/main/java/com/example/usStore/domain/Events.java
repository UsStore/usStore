package com.example.usStore.domain;

public class Events {
	private String title;
	private String start;
	
	public Events(String title, String start) {
		super();
		this.title = title;
		this.start = start;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	@Override
	public String toString() {
		return "Events [title=" + title + ", start=" + start + "]";
	}
}
