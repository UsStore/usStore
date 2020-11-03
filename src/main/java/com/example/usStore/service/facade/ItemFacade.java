package com.example.usStore.service.facade;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.Auction;
import com.example.usStore.domain.Bidder;
import com.example.usStore.domain.GroupBuying;
import com.example.usStore.domain.HandMade;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.Orders;
import com.example.usStore.domain.Review;
import com.example.usStore.domain.SecondHand;
import com.example.usStore.domain.Tag;
import com.example.usStore.domain.University;

/*
 * ItemFacade
 * 
 * Item / HandMade / GroupBuying / SecondHand / Auction / Tag 
 * */
public interface ItemFacade {

   /////////////////////////////////////////////////////////////////////////
   /* Item */
   /////////////////////////////////////////////////////////////////////////
   
   void insertItem(Item item);
   
   void updateItem(Item item);
   
   Item getItem(int itemId);
   
   public void deleteItem(int itemId);
   
   void updateQuantity(Orders order);
   
   int getQuantity(int itemId, int productId);

   boolean isItemInStock(int itemId, int productId);

   String getUserIdByItemId(int itemId);
   
   void updateViewCount(int viewCount, int itemId);
   
   List<Item> getItemByPId(int productId);
   
   List<Item> getItemByTitle(String title);
   
   /////////////////////////////////////////////////////////////////////////
   /* HandMade */
   /////////////////////////////////////////////////////////////////////////

   public void insertHandMade(HandMade handmade);
   
   public void updateHandMade(HandMade handmade);
   
   List<HandMade> getHandMadeList(String univName);
   
   public List<HandMade> getHMListByRegion(HashMap<String, String> param);

   HandMade getHandMadeById(int itemId);
   
   List<HandMade> getHandMadeListByProductId(int productId);
   
   /////////////////////////////////////////////////////////////////////////
   /* GroupBuying */
   /////////////////////////////////////////////////////////////////////////
   public void insertGroupBuying(GroupBuying GroupBuying);
   
   public void updateGroupBuying(GroupBuying GroupBuying);
   
   List<GroupBuying> getGroupBuyingList(String univName);
   
   public List<GroupBuying> getGBListByRegion(HashMap<String, String> param);
   
   GroupBuying getGroupBuyingItem(int itemId);
   
   public void groupBuyingScheduler(Date deadLine);
   
   public void closeGroupBuying(Date curTime);
   
 //품절시 삭제
   public void soldOutGroupBuying(int itemId);
   
   /////////////////////////////////////////////////////////////////////////
   /* SecondHand */
   /////////////////////////////////////////////////////////////////////////   
   List<SecondHand> getSecondHandList(String univName);
   
   SecondHand getSecondHandItem(int itemId);
   
   public void insertSecondHand(SecondHand secondHand);
   
   public void updateSecondHand(SecondHand secondHand);
   
   public List<SecondHand> getSHListByRegion(HashMap<String, String> param);
   
   /////////////////////////////////////////////////////////////////////////
   /* Auction */
   /////////////////////////////////////////////////////////////////////////
   List<Auction> getAuctionList(String univName);
   
   public List<Auction> getACListByRegion(HashMap<String, String> param);
   
   public void insertAuction(Auction auction);
    
   public void updateAuction(Auction auction);

	public Auction getAuctionById(int itemId);
	
	public void testScheduler(Date deadLine);
	
	public void updateAuctionUnitCost(int unitCost, int itemId);
	
	public void updateBidder(String bidder, int itemId);
	
	public void insertBidder(Bidder bidder);
	
	public String isBidderExist(int itemId);
	
	public void updateBidPrice(int unitCost, int itemId);
	
	public List<Bidder> getBidderList();
	
	/////////////////////////////////////////////////////////////////////////
	/* Tag */
	/////////////////////////////////////////////////////////////////////////
	List<Tag> getTagList ();
	
	List<Tag> getTagByTagId(int tagId);
	
	List<Tag> getTagByItemId(int itemId);	
	
	List<Tag> getTagByTagName(String tagName);	
	
	void insertTag(Tag tag);	
	
	void deleteTag(int itemId);

	/////////////////////////////////////////////////////////////////////////
	/* Review */
	/////////////////////////////////////////////////////////////////////////
	
	void insertReview(Review review);
	
	void deleteReview(int itemId);
	
	List<Review> getReviewListByItemId(int itemId);

	Review findReviewByuserIdAndItemId(int itemId, String buyer);
	
}