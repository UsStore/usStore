package com.example.usStore.dao;

import java.util.List;

import com.example.usStore.domain.Attendance;

public interface AttendanceDao {
	
	void insertAttend(String userId);	//출석 처리
	
	List<Attendance> getCalendarList(String userId);	//출석 정보 가져오기
	
	List<String> getCalendarByDate(String userId); //출석 날짜 리스트
}