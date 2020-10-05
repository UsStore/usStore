package com.example.usStore.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.example.usStore.domain.Review;

public interface ReviewDao {
      // 공동구매 추가 메소드
      void insertReview(Review Review) throws DataAccessException;
        
      // 공동구매 수정 메소드  
      void deleteReview(int itemId) throws DataAccessException;
      
      // 모든 공동구매 리스트 가져오는 메소드
      List<Review> getReviewListByItemId(int itemId);
      
      //리뷰 조건 조회
      Review findReviewByuserIdAndItemId(int itemId, String buyer);
}