package com.example.usStore.dao.mybatis.mapper;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.example.usStore.domain.Account;
import com.example.usStore.domain.GroupBuying;

public interface GroupBuyingMapper extends ItemMapper {
   // 공동구매 추가 메소드
   public void insertGroupBuying(GroupBuying GroupBuying);

   // 공동구매 수정 메소드
   public void updateGroupBuying(GroupBuying GroupBuying);

   // 모든 공동구매 리스트 가져오는 메소드
   List<GroupBuying> getGroupBuyingList(String univName);
   
   public List<GroupBuying> geGBListByRegion(HashMap<String, String> param);

   // itemId를 받아 해당하는 groupBuying 객체를 가져오는 메소드
   GroupBuying getGroupBuyingItem(int itemId);

   //기한 마감시 삭제
   public void closeGroupBuying(Date curTime);
   
   //품절시 삭제
   public void soldOutGroupBuying(int itemId);
   
}