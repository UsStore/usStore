package com.example.usStore.dao.mybatis.mapper;

import java.util.List;

import com.example.usStore.domain.Attendance;

public interface AttendanceMapper {
	//출석 처리
	void insertAttend(String userId);	
	
	//출석 정보 가져오기
	List<Attendance> getCalendarList(String userId);	
	
	//출석 날짜만 리스트로
	List<String> getCalendarByDate(String userId);
}
