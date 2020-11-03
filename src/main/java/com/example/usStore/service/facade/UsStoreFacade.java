package com.example.usStore.service.facade;

import java.util.List;

import com.example.usStore.domain.*;

/*
 * UsStoreFacade
 * 
 * Account / Orders / Category 
 * */
public interface UsStoreFacade {

	/////////////////////////////////////////////////////////////////////////
	/* Account */
	/////////////////////////////////////////////////////////////////////////
	Account getAccountByUserId(String userId);

	Account getAccountByUserIdAndPassword(String userId, String password);

	void insertAccount(Account account, University university);

	void updateAccount(Account account, University university);
	
	Account getAccountByUsername(String username);
	
	void updatePoint(String userId, int point);

	/////////////////////////////////////////////////////////////////////////
	/* Category */
	/////////////////////////////////////////////////////////////////////////
	List<Category> getCategoryList();

	Category getCategory(int categoryId);
	

	/////////////////////////////////////////////////////////////////////////
	/* Orders */
	/////////////////////////////////////////////////////////////////////////
	List<Orders> getOrdersByUserId(String userId);
	
	List<Orders> getOrdersByUsername(String username);

	Orders getOrder(int orderId);
	
	void insertOrder(Orders order);
	
	/////////////////////////////////////////////////////////////////////////
	/* Attendance */
	/////////////////////////////////////////////////////////////////////////
	public void insertAttend(String userId);	//출석 처리
	
	List<Attendance> getCalendarList(String userId);	//출석 정보 가져오기
	
	List<String> getCalendarByDate(String userId); //출석 날짜만 리스트로 가져옴
}