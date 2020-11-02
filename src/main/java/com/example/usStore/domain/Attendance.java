package com.example.usStore.domain;

import java.io.Serializable;
import java.util.Date;

/*
 * Event - Attendance Domain Class
 * */
@SuppressWarnings("serial")
public class Attendance  implements Serializable {
	
	private int attendId;
	private String userId; 			// (FK) userId
	private Date attendDate;	// 출석체크한 날짜

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
	public Date getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(Date attendDate) {
		this.attendDate = attendDate;
	}
	
	@Override
	public String toString() {
		return "Attendance [attendId=" + attendId + ", userId=" + userId + ", attendDate=" + attendDate + "]";
	}	
}