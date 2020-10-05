package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.OrderDao;
import com.example.usStore.dao.SequenceDao;
import com.example.usStore.dao.mybatis.mapper.LineItemMapper;
import com.example.usStore.dao.mybatis.mapper.OrderMapper;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository
public class MybatisOrderDao implements OrderDao {
	
	@Autowired
	protected OrderMapper orderMapper;
	@Autowired
	protected LineItemMapper lineItemMapper;

	@Transactional
	public Orders getOrder(int orderId) throws DataAccessException {
		 Orders order = orderMapper.getOrderAndLineitems(orderId);
		 System.out.println(order.toString());
		 System.out.println("lineItem size : " + order.getLineItems().size());   // LineItem 객체들이 같이 생성되었는지 갯수 확인
		 return order;
	}
	
	@Transactional
	public void insertOrder(Orders order) throws DataAccessException {  
    	orderMapper.insertOrder(order);
    	System.out.println("size : " + order.getLineItems().size());
    	for (int i = 0; i < order.getLineItems().size(); i++) {
    		LineItem lineItem = (LineItem) order.getLineItems().get(i);
    		lineItem.setOrderId(order.getOrderId());
    		lineItemMapper.insertLineItem(lineItem);
    	}
	}

	@Override
	public List<Orders> getOrdersByUserId(String userId) throws DataAccessException {
		// TODO Auto-generated method stub
		return orderMapper.getOrdersByUserId(userId);
	}
	
	@Override
	public List<LineItem> getLineItemsByOrderId(int orderId) {
		return lineItemMapper.getLineItemsByOrderId(orderId);
	}
	
}