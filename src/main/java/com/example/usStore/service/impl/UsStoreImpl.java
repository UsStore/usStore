package com.example.usStore.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.usStore.dao.*;
import com.example.usStore.domain.*;
import com.example.usStore.service.facade.UsStoreFacade;

/*
 * UsStoreImpl
 * 
 * Account / Orders / Category
 * */

@Service
@Transactional
public class UsStoreImpl implements UsStoreFacade { 
	
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private AccountDao accountDao;
	@Autowired
	private OrderDao orderDao;
	@Autowired
	private UniversityDao univDao;
	@Autowired
	private AttendanceDao attendanceDao;
	

	@Override
	public Account getAccountByUserId(String userId) {
		// TODO Auto-generated method stub
		return accountDao.getAccountByUserId(userId);
	}

	@Override
	public Account getAccountByUserIdAndPassword(String userId, String password) {
		// TODO Auto-generated method stub
		return accountDao.getAccountByUserIdAndPassword(userId, password);
	}

	@Override
	public Account getAccountByUsername(String username) {
		// TODO Auto-generated method stub
		return accountDao.getAccountByUsername(username);
	}

	@Override
	@Transactional
	public void insertAccount(Account account, University university) {
		accountDao.insertAccount(account);
		int flag = univDao.isExistUniv(university.getUnivName());
		if(flag == 0) {
			univDao.insertUniv(university);
		}
	}

	@Override
	@Transactional
	public void updateAccount(Account account, University university) {
		accountDao.updateAccount(account);
		int flag = univDao.isExistUniv(university.getUnivName());
		if(flag == 0) {
			univDao.insertUniv(university);
		}
	}
	
	@Override
	@Transactional
	public void updatePoint(String userId, int point) {
		accountDao.updatePoint(userId, point);
	}
	
	@Override
	public int getPointByUserId(String userId) {
		return accountDao.getPointByUserId(userId);
	}

	@Override
	public List<Category> getCategoryList() {
		return categoryDao.getCategoryList();
	}

	@Override
	public Category getCategory(int categoryId) {
		return categoryDao.getCategory(categoryId);
	}

	@Override
	public List<Orders> getOrdersByUserId(String userId) {
		return orderDao.getOrdersByUserId(userId);
	}
	
	@Override
	public Orders getOrder(int orderId) {
		return orderDao.getOrder(orderId);
	}

	@Override
	public void insertOrder(Orders order) {	    
		orderDao.insertOrder(order);
	}

	@Override
	public List<Orders> getOrdersByUsername(String username) {
		return null;
	}
	
	@Override
	public void insertAttend(String userId) {
		attendanceDao.insertAttend(userId);
	}

	@Override
	public List<Attendance> getCalendarList(String userId) {
		return attendanceDao.getCalendarList(userId);
	}
	 
	@Override
	public List<String> getCalendarByDate(String userId) {
		return attendanceDao.getCalendarByDate(userId);
	}
}