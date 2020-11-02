package com.example.usStore.domain;

import java.io.Serializable;

/*
 * UsStore - LineItem Domain Class
 * */
@SuppressWarnings("serial")
public class LineItem implements Serializable {

  /* Private Fields */
  private int orderId;
  private int lineNum;
  private String title;
  private int itemId;
  private int quantity;
  private int unitPrice;
  private Item item;

  /* Constructors */

  public LineItem() {}

  public LineItem(int lineNum, CartItem cartItem) {
    this.orderId = cartItem.getOrderId();
	this.lineNum = lineNum;
    this.itemId = cartItem.getItem().getItemId();
    this.quantity = cartItem.getQuantity();
    this.title = cartItem.getTitle();
    this.unitPrice = cartItem.getItem().getUnitCost();
    this.item = cartItem.getItem();
  }

  /* JavaBeans Properties */
  
	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	
	public int getLineNum() {
		return lineNum;
	}
	
	public void setLineNum(int lineNum) {
		this.lineNum = lineNum;
	}
	
	public int getItemId() {
		return itemId;
	}
	
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	
	public int getQuantity() {
		return quantity;
	}
	
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Item getItem() {
		return item;
	}
	
	public void setItem(Item item) {
		this.item = item;
	}
	
	public int getTotalPrice() {
		return this.unitPrice * this.quantity;
	}
	
	public int getOrderId() {
		return orderId;
	}
	
	public int getUnitPrice() {
		return unitPrice;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "LineItem [orderId=" + orderId + ", lineNum=" + lineNum + ", title=" + title + ", itemId=" + itemId
				+ ", quantity=" + quantity + ", unitPrice=" + unitPrice + ", item=" + item + ", getLineNum()="
				+ getLineNum() + ", getItemId()=" + getItemId() + ", getQuantity()=" + getQuantity() + ", getItem()="
				+ getItem() + ", getTotalPrice()=" + getTotalPrice() + ", getOrderId()=" + getOrderId()
				+ ", getUnitPrice()=" + getUnitPrice() + ", getTitle()=" + getTitle() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
}
