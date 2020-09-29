package com.example.usStore.dao.mybatis;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.example.usStore.dao.ReviewDao;
import com.example.usStore.dao.mybatis.mapper.ReviewMapper;
import com.example.usStore.domain.Review;

@Transactional
@Qualifier("mybatisReviewDao")
@Repository
public class MybatisReviewDao implements ReviewDao{
	
   @Autowired
   private ReviewMapper reviewMapper;
   
   @Override
   public void insertReview(Review review) {
      reviewMapper.insertReview(review);
   }

   @Override
   public void deleteReview(int itemId){
      reviewMapper.deleteReview(itemId);
   }

   @Override
   public List<Review> getReviewListByItemId(int itemId) {
      return reviewMapper.getReviewListByItemId(itemId);
   }
}