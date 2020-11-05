package com.example.usStore.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.GroupBuying;

public interface GroupBuyingDao extends ItemDao {
   
   // 공동구매 추가 메소드
   public void insertGroupBuying(GroupBuying GroupBuying) throws DataAccessException;
     
   // 공동구매 수정 메소드  
   public void updateGroupBuying(GroupBuying GroupBuying) throws DataAccessException;
   
   // 모든 공동구매 리스트 가져오는 메소드
   List<GroupBuying> getGroupBuyingList(String univName) throws DataAccessException;
   
   List<GroupBuying> getGBListByRegion(HashMap<String, String> param) throws DataAccessException;
   
   // itemId를 받아 해당하는 groupBuying 객체를 가져오는 메소드
   GroupBuying getGroupBuyingItem(int itemId) throws DataAccessException;
   
   //공동구매 종료 (scheduler)
   public void closeGroupBuying(Date curTime);
   
   //품절시 공동구매 종료
   public void soldOutGroupBuying(int itemId);
   
}