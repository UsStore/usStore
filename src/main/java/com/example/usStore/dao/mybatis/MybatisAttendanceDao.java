package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.usStore.dao.AttendanceDao;
import com.example.usStore.dao.mybatis.mapper.AttendanceMapper;
import com.example.usStore.domain.Attendance;

@Qualifier("MybatisAttendanceDao")
@Repository
public class MybatisAttendanceDao implements AttendanceDao {

	@Autowired
	private AttendanceMapper attendanceMapper;
	
	public void insertAttend(String userId) {
		attendanceMapper.insertAttend(userId);
	}

	public List<Attendance> getCalendarByDate(String userId) {
		return attendanceMapper.getCalendarByDate(userId);
	}
	
}