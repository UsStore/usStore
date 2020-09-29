package com.example.usStore.dao.mybatis.mapper;

import java.util.List;
import com.example.usStore.domain.Review;

public interface ReviewMapper {
	
   void insertReview(Review review);

   void deleteReview(int itemId);

   List<Review> getReviewListByItemId(int itemId);
   
}