package com.example.usStore.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.SecondHand;
import com.example.usStore.domain.University;


public interface SecondHandDao extends ItemDao {
	
	// ��ü SecondHandList �޾ƿ���
	List<SecondHand> getSecondHandList(String univName) throws DataAccessException;
	
	// itemId �Ű������� �޾� SecondHand ��ü ��ȯ
	SecondHand getSecondHandItem(int itemId) throws DataAccessException;
	
	// SecondHand ����
	public void updateSecondHand(SecondHand secondHand) throws DataAccessException;

	public void insertSecondHand(SecondHand secondHand) throws DataAccessException;
	
	public List<SecondHand> getSHListByRegion(HashMap<String, String> param) throws DataAccessException;

	List<University> getSHMapInfo() throws DataAccessException;
	
	List<SecondHand> getSHListByUniv(String univName) throws DataAccessException;
}