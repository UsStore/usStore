package com.example.usStore.dao.mybatis.mapper;


import com.example.usStore.domain.University;

public interface UniversityMapper {
	

	University getUnivByName(String univName);
	
	void insertUniv(University university);
	
	String getUnivAddrByName(String univName);
	
	int isExistUniv(String univName);

}
