package com.example.usStore.dao;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.University;

public interface UniversityDao {

	University getUnivByName(String univName) throws DataAccessException;
	
	void insertUniv(University university) throws DataAccessException;
	 
	String getUnivAddrByName(String univName) throws DataAccessException;
}
