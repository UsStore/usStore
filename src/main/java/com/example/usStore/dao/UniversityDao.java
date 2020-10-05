package com.example.usStore.dao;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.University;

public interface UniversityDao {

	University getUnivByName(String univNameU) throws DataAccessException;
	
	void insertUniv(University university) throws DataAccessException;
	 
}
