package com.example.usStore.domain;

import java.io.Serializable;

/*
 * UsStore - Item(HandMade) Domain Class
 * */
@SuppressWarnings("serial")
public class HandMade extends Item implements Serializable {

	// Field
	private int itemId;
	private int listPrice;
	
	// Constructor
	public HandMade() { }
	public HandMade(Item item, int itemId, int listPrice) {
		super(item.getItemId(), item.getUnitCost(), item.getTitle(), item.getDescription(), item.getViewCount(), item.getQty(), item.getTags(), 
				item.getUserId(), item.getProductId(), item.getImgUrl());
		this.itemId = itemId;
		this.listPrice = listPrice;
	}
	
	// Getter & Setter
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public int getListPrice() {
		return listPrice;
	}
	public void setListPrice(int listPrice) {
		this.listPrice = listPrice;
	}
	
	@Override
	public String toString() {
		return super.toString() + "HandMade [itemId=" + itemId + ", listPrice=" + listPrice + "]";
	}
	
}
