package com.example.usStore.dao.mybatis;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.AuctionDao;
import com.example.usStore.dao.mybatis.mapper.AuctionMapper;
import com.example.usStore.dao.mybatis.mapper.ItemMapper;
import com.example.usStore.dao.mybatis.mapper.TagMapper;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.Auction;
import com.example.usStore.domain.Bidder;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;
import com.example.usStore.domain.Tag;

@Transactional
@Qualifier("mybatisAuctionDao")
@Repository
public class MybatisAuctionDao implements AuctionDao {

   @Autowired
   private AuctionMapper auctionMapper;
   @Autowired
   private ItemMapper itemMapper;
   @Autowired
   private TagMapper tagMapper;

   @Override
   public void updateQuantity(Orders order) throws DataAccessException {
		for (int i = 0; i < order.getLineItems().size(); i++) {
			System.out.println("MybatisItemDao");
			LineItem lineItem = (LineItem) order.getLineItems().get(i);
			int itemId = lineItem.getItemId();
			Integer increment = new Integer(lineItem.getQuantity());
			Map<String, Object> param = new HashMap<String, Object>(2);
			param.put("itemId", itemId);
			param.put("increment", increment);
			auctionMapper.updateInventoryQuantity(param);
		}
   }

   @Override
   public int getQuantity(int itemId, int productId) throws DataAccessException {
      // TODO Auto-generated method stub
      return auctionMapper.getQuantity(itemId, productId);
   }

   @Override
   public boolean isItemInStock(int itemId, int productId) throws DataAccessException {
      // TODO Auto-generated method stub
      return (auctionMapper.getQuantity(itemId, productId) > 0 );
   }

   @Override
   public void deleteItem(int itemId) throws DataAccessException {
      // TODO Auto-generated method stub
      auctionMapper.deleteItem(itemId);
   }

   @Override
   public List<Auction> getAuctionList(String unuvName) throws DataAccessException {
      return auctionMapper.getAuctionList(unuvName);
   }

   @Override
   public void insertAuction(Auction auction) throws DataAccessException {
      // TODO Auto-generated method stub
	  itemMapper.insertItem(auction);
	  auctionMapper.insertAuction(auction);
	  for(Tag t : auction.getTags()) {
		  t.setItemId(auction.getItemId());
		  tagMapper.insertTag(t);
	  }
   }

   @Override
   public void updateAuction(Auction auction) throws DataAccessException {
      // TODO Auto-generated method stub
	   itemMapper.updateItem((Item)auction);
	   auctionMapper.updateAuction(auction);
	   
	   for(Tag t : auction.getTags()) {
		   t.setItemId(auction.getItemId());
		   tagMapper.insertTag(t);
	   }
   }

   @Override
   public Auction getAuctionById(int itemId) throws DataAccessException {
      // TODO Auto-generated method stub
      return auctionMapper.getAuctionById(itemId);
   }

   @Override
   public void insertItem(Item item) {
      // TODO Auto-generated method stub
      auctionMapper.insertItem(item);
   }

   @Override
   public void updateItem(Item item) {
      // TODO Auto-generated method stub
      auctionMapper.updateItem(item);
   }

   @Override
   public Item getItem(int itemId) {
      return auctionMapper.getItem(itemId);
   }
   
   public void closeAuction(Date curTime) {
	   auctionMapper.closeAuction(curTime);
   }

   public void updateAuctionUnitCost(int unitCost, int itemId) {
	   auctionMapper.updateAuctionUnitCost(unitCost, itemId);
   }
	
   public void updateBidder(String bidder, int itemId) {
	   auctionMapper.updateBidder(bidder, itemId);
   }
	
   public void insertBidder(Bidder bidder) {
	   auctionMapper.insertBidder(bidder);
   }
   
   public String isBidderExist(int itemId) {
	   return auctionMapper.isBidderExist(itemId);
   }

   public void updateBidPrice(int unitCost, int itemId) {
	   auctionMapper.updateBidPrice(unitCost, itemId);
   }

   @Override
   public String getUserIdByItemId(int itemId) throws DataAccessException {
	   return auctionMapper.getUserIdByItemId(itemId);
   }
  
	
	public List<Bidder> getBidderList() {
		return auctionMapper.getBidderList();
	}

	@Override
	public void updateViewCount(int viewCount, int itemId) {
		// TODO Auto-generated method stub
		auctionMapper.updateViewCount(viewCount, itemId);
	}
	
	@Override
	public List<Item> getItemByPId(int productId) throws DataAccessException {
	    return auctionMapper.getItemByPId(productId);
	}
	
	public List<Item> getItemByTitle(String title) {
		return auctionMapper.getItemByTitle("%" + title.toLowerCase() + "%");
	}

	@Override
	public List<Auction> getACListByRegion(HashMap<String, String> param) throws DataAccessException {
		return auctionMapper.getACListByRegion(param);
	}
}