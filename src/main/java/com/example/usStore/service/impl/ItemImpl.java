package com.example.usStore.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.usStore.dao.AuctionDao;
import com.example.usStore.dao.GroupBuyingDao;
import com.example.usStore.dao.HandMadeDao;
import com.example.usStore.dao.ItemDao;
import com.example.usStore.dao.ReviewDao;
import com.example.usStore.dao.SecondHandDao;
import com.example.usStore.dao.TagDao;
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
import com.example.usStore.service.facade.ItemFacade;

/*
 * ItemFacade
 * 
 * Item / HandMade / GroupBuying / SecondHand / Auction / Tag
 * */
@Repository
@Service("itemImpl")
@Transactional
public class ItemImpl implements ItemFacade {

	@Autowired
	private ItemDao itemDao;
	@Autowired
	private HandMadeDao handMadeDao;
	@Autowired
	private GroupBuyingDao groupBuyingDao;
	@Autowired
	private SecondHandDao secondHandDao;
	@Autowired
	private AuctionDao auctionDao;
	@Autowired
	private TagDao tagDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired // applicationContext.xml占쎈퓠 占쎌젟占쎌벥占쎈쭆 scheduler 揶쏆빘猿쒐몴占 雅뚯눘 뿯 獄쏆룇 벉
	private ThreadPoolTaskScheduler scheduler;

	@Override
	public void updateQuantity(Orders order) {
		// TODO Auto-generated method stub
		itemDao.updateQuantity(order);
	}

	@Override
	public int getQuantity(int itemId, int productId) {
		// TODO Auto-generated method stub
		switch (productId) {
		case 0:
			return groupBuyingDao.getQuantity(itemId, productId);
		case 1:
			return auctionDao.getQuantity(itemId, productId);
		case 2:
			return secondHandDao.getQuantity(itemId, productId);
		case 3:
			return handMadeDao.getQuantity(itemId, productId);
		default:
			System.err.println("getQuantity Error !!");
			return -1;
		}
	}

	@Override
	public void deleteItem(int itemId) {
		// TODO Auto-generated method stub
		itemDao.deleteItem(itemId);
	}

	// 뜝 럩逾졿ㅀ袁ъ삕 占썩뫁伊숃뜎洹⑥삕 뜮 쉻 삕 뵳占
	@Override
	public boolean isItemInStock(int itemId, int productId) {
		// TODO Auto-generated method stub
		switch (productId) {
		case 0:
			return groupBuyingDao.isItemInStock(itemId, productId);
		case 1:
			return auctionDao.isItemInStock(itemId, productId);
		case 2:
			return secondHandDao.isItemInStock(itemId, productId);
		case 3:
			return handMadeDao.isItemInStock(itemId, productId);
		default:
			System.err.println("isItemInStock Error !!");
			return false;
		}
	}

	public List<Item> getItemByTitle(String title) {
		return itemDao.getItemByTitle(title);
	}
	
//********************HandMade********************
	@Override
	public void insertHandMade(HandMade handmade) {
		// TODO Auto-generated method stub
		handMadeDao.insertHandMade(handmade);
	}

	@Override
	public void updateHandMade(HandMade handmade) {
		// TODO Auto-generated method stub
		handMadeDao.updateHandMade(handmade);
	}

	@Override
	public List<HandMade> getHandMadeList(String univName) {
		// TODO Auto-generated method stub
		return handMadeDao.getHandMadeList(univName);
	}

	@Override
	public List<HandMade> getHMListByRegion(HashMap<String, String> param) {
		// TODO Auto-generated method stub
		return handMadeDao.getHMListByRegion(param);
	}
	
	@Override
	public HandMade getHandMadeById(int itemId) {
		// TODO Auto-generated method stub
		return handMadeDao.getHandMadeById(itemId);
	}

	@Override
	public List<HandMade> getHandMadeListByProductId(int productId) {
		// TODO Auto-generated method stub
		return handMadeDao.getHandMadeListByProductId(productId);
	}

	
//********************GroupBuying********************
	@Override
	public void insertGroupBuying(GroupBuying GroupBuying) {
		// TODO Auto-generated method stub
		groupBuyingDao.insertGroupBuying(GroupBuying);
	}

	@Override
	public void updateGroupBuying(GroupBuying GroupBuying) {
		// TODO Auto-generated method stub
		groupBuyingDao.updateGroupBuying(GroupBuying);
	}

	@Override
	public List<GroupBuying> getGroupBuyingList(String univName) {
		return groupBuyingDao.getGroupBuyingList(univName);
	}

	@Override
	public List<GroupBuying> getGBListByRegion(HashMap<String, String> param) {
		// TODO Auto-generated method stub
		return groupBuyingDao.getGBListByRegion(param);
	}
	
	@Override
	public GroupBuying getGroupBuyingItem(int itemId) {
		// TODO Auto-generated method stub
		return groupBuyingDao.getGroupBuyingItem(itemId);
	}

	public void groupBuyingScheduler(Date deadLine) {
		Runnable updateTableRunner = new Runnable() {
			@Override
			public void run() {
				System.out.println("스케쥴러 - close메소드 실행");
				Date curTime = new Date();
				groupBuyingDao.closeGroupBuying(curTime); // state 변경
				System.out.println("스케쥴러 - 현재시간 : " + curTime.toString());
			}
		};
		scheduler.schedule(updateTableRunner, deadLine);
	}
	
	//기한 마감시 삭제
	public void closeGroupBuying(Date curTime) {
		groupBuyingDao.closeGroupBuying(curTime);
	}

	//품절시 삭제
	public void soldOutGroupBuying(int itemId) {
		groupBuyingDao.soldOutGroupBuying(itemId);
	}
	
//********************SecondHand********************
	@Override
	public List<SecondHand> getSecondHandList(String univName) {
		return secondHandDao.getSecondHandList(univName);
	}

	@Override
	public SecondHand getSecondHandItem(int itemId) {
		return secondHandDao.getSecondHandItem(itemId);
	}

	@Override
	public List<SecondHand> getSHListByRegion(HashMap<String, String> param) {
		return secondHandDao.getSHListByRegion(param);
	}
	
	@Override
	public List<University> getSHMapInfo(){
		return secondHandDao.getSHMapInfo();
	}
	
	@Override
	public void insertSecondHand(SecondHand secondHand) {
		secondHandDao.insertSecondHand(secondHand);
	}

	@Override
	public void updateSecondHand(SecondHand secondHand) {
		secondHandDao.updateSecondHand(secondHand);
	}

	
//********************Auction********************
	@Override
	public List<Auction> getAuctionList(String univName) {
		// TODO Auto-generated method stub
		return auctionDao.getAuctionList(univName);
	}

	@Override
	public List<Auction> getACListByRegion(HashMap<String, String> param) {
		// TODO Auto-generated method stub
		return auctionDao.getACListByRegion(param);
	}
	
	@Override
	public void insertAuction(Auction auction) {
		// TODO Auto-generated method stub
		auctionDao.insertAuction(auction);
	}

	@Override
	public void updateAuction(Auction auction) {
		// TODO Auto-generated method stub
		auctionDao.updateAuction(auction);
	}

	@Override
	public Auction getAuctionById(int itemId) {
		// TODO Auto-generated method stub
		return auctionDao.getAuctionById(itemId);
	}

	public void testScheduler(Date deadLine) {
		Runnable updateTableRunner = new Runnable() {
			@Override
			public void run() {
				Date curTime = new Date();
				auctionDao.closeAuction(curTime);

				List<Auction> auctionList = auctionDao.getAuctionList(null);
				for (int i = 0; i < auctionList.size(); i++) {
					if (auctionList.get(i).getAuctionState() == 1) {
						int unitCost = auctionList.get(i).getUnitCost();
						int itemId = auctionList.get(i).getItemId();

						auctionDao.updateBidPrice(unitCost, itemId);
					}
				}
			}
		};
		scheduler.schedule(updateTableRunner, deadLine);

		System.out.println("updateTableRunner has been scheduled to execute at " + deadLine);
	}

	public void updateAuctionUnitCost(int unitCost, int itemId) {
		auctionDao.updateAuctionUnitCost(unitCost, itemId);
	}

	public void updateBidder(String bidder, int itemId) {
		auctionDao.updateBidder(bidder, itemId);
	}

	public void insertBidder(Bidder bidder) {
		auctionDao.insertBidder(bidder);
	}

	public String isBidderExist(int itemId) {
		return auctionDao.isBidderExist(itemId);
	}

	public void updateBidPrice(int unitCost, int itemId) {
		auctionDao.updateBidPrice(unitCost, itemId);
	}

	public List<Bidder> getBidderList() {
		return auctionDao.getBidderList();
	}

	@Override
	public List<Tag> getTagList() {
		// TODO Auto-generated method stub
		return tagDao.getTagList();
	}

	@Override
	public List<Tag> getTagByTagId(int tagId) {
		// TODO Auto-generated method stub
		return tagDao.getTagByTagId(tagId);
	}

	@Override
	public List<Tag> getTagByItemId(int itemId) {
		// TODO Auto-generated method stub
		return tagDao.getTagByItemId(itemId);
	}

	@Override
	public List<Tag> getTagByTagName(String tagName) {
		// TODO Auto-generated method stub
		return tagDao.getTagByTagName(tagName);
	}

	@Override
	public void insertTag(Tag tag) {
		// TODO Auto-generated method stub
		tagDao.insertTag(tag);
	}

	@Override
	public void deleteTag(int itemId) {
		// TODO Auto-generated method stub
		tagDao.deleteTag(itemId);
	}

	@Override
	public void insertItem(Item item) {
		// TODO Auto-generated method stub
		itemDao.insertItem(item);
	}

	@Override
	public void updateItem(Item item) {
		// TODO Auto-generated method stub
		itemDao.updateItem(item);
	}

	@Override
	public Item getItem(int itemId) {
		// TODO Auto-generated method stub
		return itemDao.getItem(itemId);
	}

	@Override
	public String getUserIdByItemId(int itemId) {
		return itemDao.getUserIdByItemId(itemId);
	}

	@Override
	public void updateViewCount(int viewCount, int itemId) {
		// TODO Auto-generated method stub
		itemDao.updateViewCount(viewCount, itemId);
	}

	@Override
	public List<Item> getItemByPId(int productId) {
		// TODO Auto-generated method stub
		return itemDao.getItemByPId(productId);
	}

	@Override
	public void insertReview(Review review) {
		reviewDao.insertReview(review);
	}

	@Override
	public void deleteReview(int itemId) {
		reviewDao.deleteReview(itemId);
	}

	@Override
	public List<Review> getReviewListByItemId(int itemId) {
		return reviewDao.getReviewListByItemId(itemId);
	}

	@Override
	public Review findReviewByuserIdAndItemId(int itemId, String buyer) {
		return reviewDao.findReviewByuserIdAndItemId(itemId, buyer);
	}


	
	
}