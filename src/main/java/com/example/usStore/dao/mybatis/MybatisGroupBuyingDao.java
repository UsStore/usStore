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

import com.example.usStore.dao.GroupBuyingDao;
import com.example.usStore.dao.mybatis.mapper.GroupBuyingMapper;
import com.example.usStore.dao.mybatis.mapper.ItemMapper;
import com.example.usStore.dao.mybatis.mapper.TagMapper;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.GroupBuying;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;
import com.example.usStore.domain.Tag;

@Transactional
@Qualifier("mybatisGroupBuyingDao")
@Repository
public class MybatisGroupBuyingDao implements GroupBuyingDao {   
   
   @Autowired
   private GroupBuyingMapper groupBuyingMapper;
   
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
			groupBuyingMapper.updateInventoryQuantity(param);
		}
   }

   @Override
   public int getQuantity(int itemId, int productId) throws DataAccessException {
      // TODO Auto-generated method stub
      return groupBuyingMapper.getQuantity(itemId, productId);
   }

   @Override
   public boolean isItemInStock(int itemId, int productId) throws DataAccessException {
      // TODO Auto-generated method stub
      return (groupBuyingMapper.getQuantity(itemId, productId) > 0);
   }

   @Override
   public void deleteItem(int itemId) throws DataAccessException {
      // TODO Auto-generated method stub
      groupBuyingMapper.deleteItem(itemId);
   }

   @Override
   public void insertGroupBuying(GroupBuying groupBuying) throws DataAccessException {   //insert 트랜잭션 구현
      // TODO Auto-generated method stub
      itemMapper.insertItem(groupBuying);
      groupBuyingMapper.insertGroupBuying(groupBuying);
      for(Tag t : groupBuying.getTags()) {
         t.setItemId(groupBuying.getItemId()); 
         tagMapper.insertTag(t);
      }
   }
   
   @Override
   public void updateGroupBuying(GroupBuying groupBuying) {   //update 트랜잭션 구현
      // TODO Auto-generated method stub
      itemMapper.updateItem(groupBuying);
      groupBuyingMapper.updateGroupBuying(groupBuying);
      for(Tag t : groupBuying.getTags()) {
         t.setItemId(groupBuying.getItemId()); 
         tagMapper.insertTag(t);
      }
   }
   
   @Override
   public List<GroupBuying> getGroupBuyingList(String univName) throws DataAccessException {
      return groupBuyingMapper.getGroupBuyingList(univName);
   }

   @Override
   public GroupBuying getGroupBuyingItem(int itemId) throws DataAccessException {
      // TODO Auto-generated method stub
      return groupBuyingMapper.getGroupBuyingItem(itemId);
   }
   
   @Override
   public void closeGroupBuying(Date curTime) {
      groupBuyingMapper.closeGroupBuying(curTime);
   }
   
   //품절시 공동구매 종료 
   @Override
   public void soldOutGroupBuying(int itemId)  {
	   groupBuyingMapper.soldOutGroupBuying(itemId);
   }
   
   @Override
   public void insertItem(Item item) {
      // TODO Auto-generated method stub
      groupBuyingMapper.insertItem(item);
   }

   @Override
   public void updateItem(Item item) {
      // TODO Auto-generated method stub
      groupBuyingMapper.updateItem(item);
   }

   @Override
   public Item getItem(int itemId) {
      return groupBuyingMapper.getItem(itemId);
   }

   @Override
   public String getUserIdByItemId(int itemId){
      return groupBuyingMapper.getUserIdByItemId(itemId);
   }

   @Override
   public void updateViewCount(int viewCount, int itemId) {
      // TODO Auto-generated method stub
      groupBuyingMapper.updateViewCount(viewCount, itemId);
   }

   @Override
   public List<Item> getItemByPId(int productId){
      return groupBuyingMapper.getItemByPId(productId);
   }
   
   public List<Item> getItemByTitle(String title) {
		return groupBuyingMapper.getItemByTitle("%" + title.toLowerCase() + "%");
	}

	@Override
	public List<GroupBuying> getGBListByRegion(HashMap<String, String> param) {
		// TODO Auto-generated method stub
		return groupBuyingMapper.getGBListByRegion(param);
	}
}