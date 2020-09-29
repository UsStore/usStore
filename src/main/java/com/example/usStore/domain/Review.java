package com.example.usStore.domain;

public class Review {
   private int reviewId;
   private int itemId;
   private String buyer;
   private String description;
   
   public int getReviewId() {
      return reviewId;
   }
   public void setReviewId(int reviewId) {
      this.reviewId = reviewId;
   }
   public int getItemId() {
      return itemId;
   }
   public void setItemId(int itemId) {
      this.itemId = itemId;
   }
   public String getBuyer() {
      return buyer;
   }
   public void setBuyer(String buyer) {
      this.buyer = buyer;
   }
   public String getDescription() {
      return description;
   }
   public void setDescription(String description) {
      this.description = description;
   }
   
   @Override
   public String toString() {
      return "Review [reviewId=" + reviewId + ", itemId=" + itemId + ", buyer=" + buyer + ", description="
            + description + "]";
   }
   
}