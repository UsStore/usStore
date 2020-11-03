package com.example.usStore.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.HandMade;

public interface HandMadeDao extends ItemDao {

	// insert HandMade
	public void insertHandMade(HandMade handmade) throws DataAccessException;
	  
	// update HandMade
	public void updateHandMade(HandMade handmade) throws DataAccessException;
	
	// 모든 수공예 리스트 가져오는 메소드
	List<HandMade> getHandMadeList(String univName) throws DataAccessException;
	
	public List<HandMade> getHMListByRegion(HashMap<String, String> param);
	
	// itemId 받아서 해당하는 HandMade 객체 반환
	HandMade getHandMadeById(int itemId) throws DataAccessException;
	
	// Product_id를 받아 HandMade 전체 list 가져오기
	List<HandMade> getHandMadeListByProductId(int productId) throws DataAccessException;
}
