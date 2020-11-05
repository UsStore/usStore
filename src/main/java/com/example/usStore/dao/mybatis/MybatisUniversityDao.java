package com.example.usStore.dao.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.example.usStore.dao.UniversityDao;
import com.example.usStore.dao.mybatis.mapper.UniversityMapper;
import com.example.usStore.domain.University;


@Repository
public class MybatisUniversityDao implements UniversityDao{
	
	@Autowired
	UniversityMapper univMapper;
	

	@Override
	public University getUnivByName(String univName) throws DataAccessException {
		return univMapper.getUnivByName(univName);
	}

	@Override
	public void insertUniv(University university) throws DataAccessException {
		univMapper.insertUniv(university);
	}

	@Override
	public String getUnivAddrByName(String univName) throws DataAccessException {
		return univMapper.getUnivAddrByName(univName);
	}

	@Override
	public int isExistUniv(String univName) throws DataAccessException {
		return univMapper.isExistUniv(univName);
	}

}
