package com.example.usStore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.OrderDao;
import com.example.usStore.domain.Orders;
import com.example.usStore.service.OrderService;

/**
 * @author Chang-Sup Park
 */
@Service("orderServiceImpl")
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;

	public Orders getOrder(int orderId) {
		return orderDao.getOrder(orderId);
	}

	public List<Orders> getOrdersByUserId(String userId) {
		return orderDao.getOrdersByUserId(userId);
	}
}
