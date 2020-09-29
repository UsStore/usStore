package com.example.usStore.controller;

import java.io.Serializable;

import com.example.usStore.domain.Orders;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 */
 
@SuppressWarnings("serial")
public class OrderForm implements Serializable {

	private final Orders order = new Orders();
	private boolean shippingAddressRequired = false;
	private boolean shippingAddressProvided = false;

	public Orders getOrder() {
		return order;
	}

	public void setShippingAddressRequired(boolean shippingAddressRequired) {
		this.shippingAddressRequired = shippingAddressRequired;
	}

	public boolean isShippingAddressRequired() {
		return shippingAddressRequired;
	}

	public void setShippingAddressProvided(boolean shippingAddressProvided) {
		this.shippingAddressProvided = shippingAddressProvided;
	}

	public boolean didShippingAddressProvided() {
		return shippingAddressProvided;
	}
}
