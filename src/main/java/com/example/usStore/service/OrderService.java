package com.example.usStore.service;

import java.util.List;

import com.example.usStore.domain.Orders;
import com.example.usStore.service.facade.UsStoreFacade;
import com.example.usStore.service.impl.OrderServiceImpl;
import com.example.usStore.service.impl.UsStoreImpl;

/**
 * Separate OrderService interface, implemented by OrderServiceImpl. * 
 *
 * <p>Mainly targeted at usage as remote service interface,
 * just exposing the <code>getOrder</code> method.
 *
 * @author Juergen Hoeller
 * @since 26.12.2003
 * @see UsStoreFacade
 * @see UsStoreImpl
 * @see OrderServiceImpl
 */
//@WebService(name = "OrderService") 
public interface OrderService {

	Orders getOrder(int orderId);
	
	public List<Orders> getOrdersByUserId(String userId);

}
