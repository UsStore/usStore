package com.example.usStore.dao.mybatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.example.usStore.dao.ItemDao;
import com.example.usStore.dao.mybatis.mapper.ItemMapper;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;

@Qualifier("mybatisItemDao")
@Repository
public class MybatisItemDao implements ItemDao {

	@Autowired
	private ItemMapper itemMapper;

	@Override
	public void updateQuantity(Orders order) throws DataAccessException {
		// TODO Auto-generated method stub
		for (int i = 0; i < order.getLineItems().size(); i++) {
			System.out.println("MybatisItemDao");
			LineItem lineItem = (LineItem) order.getLineItems().get(i);
			int itemId = lineItem.getItemId();
			Integer increment = new Integer(lineItem.getQuantity());
			Map<String, Object> param = new HashMap<String, Object>(2);
			param.put("itemId", itemId);
			param.put("increment", increment);
			itemMapper.updateInventoryQuantity(param);
		}
	}

	@Override
	public int getQuantity(int itemId, int productId) throws DataAccessException {
		// TODO Auto-generated method stub
		return itemMapper.getQuantity(itemId, productId);
	}

	@Override
	public boolean isItemInStock(int itemId, int productId) throws DataAccessException {
		// TODO Auto-generated method stub
		return itemMapper.isItemInStock(itemId, productId);
	}

	@Override
	public void insertItem(Item item) {
		// TODO Auto-generated method stub
		itemMapper.insertItem(item);
	}

	@Override
	public void updateItem(Item item) {
		// TODO Auto-generated method stub
		itemMapper.updateItem(item);
	}

	@Override
	public Item getItem(int itemId) {
		return itemMapper.getItem(itemId);
	}

	@Override
	public void deleteItem(int itemId) throws DataAccessException {
		// TODO Auto-generated method stub
		itemMapper.deleteItem(itemId);
	}

	@Override
	public String getUserIdByItemId(int itemId) throws DataAccessException {
		return itemMapper.getUserIdByItemId(itemId);
	}

	@Override
	public void updateViewCount(int viewCount, int itemId) {
		// TODO Auto-generated method stub
		itemMapper.updateViewCount(viewCount, itemId);
	}

	@Override
	public List<Item> getItemByPId(int productId) throws DataAccessException {
	   return itemMapper.getItemByPId(productId);
	}	
	
	public List<Item> getItemByTitle(String title) {
		return itemMapper.getItemByTitle("%" + title.toLowerCase() + "%");
	}
}