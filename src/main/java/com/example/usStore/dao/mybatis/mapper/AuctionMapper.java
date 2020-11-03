package com.example.usStore.dao.mybatis.mapper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.Auction;
import com.example.usStore.domain.Bidder;
import com.example.usStore.domain.Item;

public interface AuctionMapper extends ItemMapper {
	
	// select Auction
	List<Auction> getAuctionList(String univName);
	
	public List<Auction> getACListByRegion(HashMap<String, String> param);

	// insert Auction
	public void insertAuction(Auction auction);

	// update Auction
	public void updateAuction(Auction auction);

	// �븘�씠�뀥 �븘�씠�뵒濡� �빐�떦 寃쎈ℓ 媛앹껜 諛섑솚
	public Auction getAuctionById(int itemId);
	
	public void insertNewEvent(HashMap<String, Date> map);
	
	public void closeAuction(Date curTime);

	public void updateAuctionUnitCost(int unitCost, int itemId);
	
	public void updateBidder(String bidder, int itemId);
	
	public void insertBidder(Bidder bidder);
	
	public String isBidderExist(int itemId);

	public void updateBidPrice(int unitCost, int itemId);
	
	public List<Item> searchItemList(String keywords);
	
	public List<Bidder> getBidderList();
}
