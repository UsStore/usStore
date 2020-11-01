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
}