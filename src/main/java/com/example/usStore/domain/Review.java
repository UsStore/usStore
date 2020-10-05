package com.example.usStore.domain;

public class Review {
   private int reviewId;
   private int itemId;
   private String buyer;
   private String description;
   private int rating;
   
   public Review() {}
   
   public Review(int itemId, String buyer, String description, int rating) {
	super();
	this.itemId = itemId;
	this.buyer = buyer;
	this.description = description;
	this.rating = rating;
   }

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
   public int getRating() {
	return rating;
   }
   public void setRating(int rating) {
	   this.rating = rating;
   }
	
   @Override
   public String toString() {
	   return "Review [reviewId=" + reviewId + ", itemId=" + itemId + ", buyer=" + buyer + ", description=" + description
			   + ", rating=" + rating + "]";
   }
      
}