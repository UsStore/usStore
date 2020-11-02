package com.example.usStore.dao;

import java.util.List;

import com.example.usStore.domain.Attendance;

public interface AttendanceDao {
	
	void insertAttend(String userId);	//출석 처리
	
	List<Attendance> getCalendarByDate(String userId);	//출석 정보 가져오기
}