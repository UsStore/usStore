package com.example.usStore.domain;

import java.io.Serializable;

/*
 * Event - Attendance Domain Class
 * */
@SuppressWarnings("serial")
public class Attendance  implements Serializable {
	
	private int attendId;
	private String userId; 			// (FK) userId
	private String attendDate;	// 출석체크한 날짜

	public int getAttendId() {
		return attendId;
	}
	public void setAttendId(int attendId) {
		this.attendId = attendId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(String attendDate) {
		this.attendDate = attendDate;
	}
	
	@Override
	public String toString() {
		return "Attendance [attendId=" + attendId + ", userId=" + userId + ", attendDate=" + attendDate + "]";
	}	
}