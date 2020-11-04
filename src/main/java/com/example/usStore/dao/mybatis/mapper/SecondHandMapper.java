package com.example.usStore.dao.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.SecondHand;
import com.example.usStore.domain.University;


public interface SecondHandMapper extends ItemMapper {

	List<SecondHand> getSecondHandList(String univName);

	SecondHand getSecondHandItem(int itemId);
	
	void insertSecondHand(SecondHand secondHand);
	
	void updateSecondHand(SecondHand secondHand);
	
	void deleteSecondHand(int itemId);
	
	List<SecondHand> getSHListByRegion(HashMap<String, String> param);
	
	List<University> getSHMapInfo();
}
