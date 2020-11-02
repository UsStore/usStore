package com.example.usStore.controller.item;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;
import com.example.usStore.domain.Review;
import com.example.usStore.service.OrderService;
import com.example.usStore.service.ReviewValidator;
import com.example.usStore.service.facade.ItemFacade;

@SessionAttributes({"Review", "reviewList"})
@Controller
public class ReviewController {
	
	@Autowired
	private ItemFacade itemFacade; 
	
	private OrderService orderSvc;	   
	
	@Autowired
	public void setUsStoreSvc(OrderService orderService) {
	  this.orderSvc = orderService;
	}
	 
	@RequestMapping(value = "/shop/getReview.do/{itemId}", method = RequestMethod.GET, produces = "application/json")
	   @ResponseBody
	   public List<Review> getReview(@PathVariable("itemId") int itemId, HttpServletResponse response, 
			   Model model, ModelMap modelMap) throws IOException {   
	      System.out.println("/usStore/rest/shop/getReview.do/" + itemId);
	      
	      List<Review> reviewList = new ArrayList<Review>();
	      
	      reviewList = itemFacade.getReviewListByItemId(itemId);
	                    
	      if (reviewList == null) {
	         response.sendError(HttpServletResponse.SC_NOT_FOUND);
	         return null;
	      }
	      
	      if(reviewList.size() > 3) {	//3개만 추출
	    	  for(int i = 3; i < reviewList.size(); i++) {
	    		  reviewList.remove(i);
	    	  }
	      }
	            
	      System.out.println("리뷰 리스트:" + reviewList);

	      return reviewList;
	   }

	   @RequestMapping("/shop/goAddReview.do") //리뷰 작성 허가
	   public String gbAddReview(@RequestParam("itemId") int itemId, HttpServletRequest rq, HttpServletResponse response) throws IOException
	   {
		   System.out.println("goAddReview.do");
		   HttpSession session = rq.getSession(false);
		   
		   Item item = itemFacade.getItem(itemId);
		   		          
		   UserSession userSession = (UserSession) session.getAttribute("userSession");
		   String buyer = userSession.getAccount().getUserId();
		  
		   List<Orders> orderList = null;
		   
		   if(itemFacade.findReviewByuserIdAndItemId(itemId, buyer) == null) {	//해당 제품 리뷰 기록 없는 경우
			   if (orderSvc.getOrdersByUserId(buyer) != null) {	//주문 목록이 1개 이상 존재할 경우
				   System.out.println("order 하나 이상 존재");
				   orderList = orderSvc.getOrdersByUserId(buyer);
				   
				   for(Orders o : orderList) {
					   List<LineItem> lineItems = orderSvc.getLineItemsByOrderId(o.getOrderId());	//해당 주문번호의 lineItem 받음
					   
					   for(LineItem lineItem : lineItems) {
						   if(lineItem.getItemId() == itemId) {	//현 사용자의 구매 목록에 속한 itemId = 현재의 itemId
							   return "redirect:/shop/review.do?itemId=" + itemId;	//리뷰 작성 페이지 이동
						   }
					   }
				   }
			   }
		   }
			 //해당 아이템을 구매한 기록 없거나 이미 리뷰를 작성한 경우
			   PrintWriter out=response.getWriter();
			   out.println("<script>");
			   out.print("alert('You do not have permission!');");
			   out.print("if(" + item.getProductId() + "== 0) {	location.href='/usStore/shop/groupBuying/viewItem.do?itemId=" + itemId + "&productId=0';}");
			   out.print("else if(" + item.getProductId() + "== 1) {	location.href='/usStore/shop/auction/viewItem.do?itemId=" + itemId + "&productId=1';}");
			   out.print("else if(" + item.getProductId() + "== 2) {	location.href='/usStore/shop/secondHand/viewItem.do?itemId=" + itemId + "&productId=2';}");
			   out.print("else if(" + item.getProductId() + "== 3) {	location.href='/usStore/shop/handMade/viewItem.do?itemId=" + itemId + "&productId=3';}");
			   out.println("</script>");
			   out.flush();
			   out.close();
			   
		 //구매 내역이 0인 경우 리뷰 권한 없음
			   if(item.getProductId() == 0)
			   { return "redirect:/shop/groupBuying/viewItem.do?itemId=" + itemId + "&productId=0";	}
			   else if(item.getProductId() == 1)
			   	{	return "redirect:/shop/auction/viewItem.do?itemId=" + itemId + "&productId=1";	}
			   else if(item.getProductId() == 2)
			   {	return "redirect:/shop/secondHand/viewItem.do?itemId=" + itemId + "&productId=2";	}
			   return "redirect:/shop/handMade/viewItem.do?itemId=" + itemId + "&productId=3";
	   }
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/shop/review.do") //리뷰 작성 페이지로 이동
    public String viewRank(@ModelAttribute("review") Review review, @RequestParam("itemId")int itemId, Model model) {
      System.out.println("review.do");
      
      Item item = itemFacade.getItem(itemId);
      
      // 평점 옵션
      @SuppressWarnings("rawtypes")
      Map ratingOptions = new HashMap();
      
      ratingOptions.put(0, "☆☆☆☆☆");
      ratingOptions.put(1, "★☆☆☆☆");
      ratingOptions.put(2, "★★☆☆☆");
      ratingOptions.put(3, "★★★☆☆");
      ratingOptions.put(4, "★★★★☆");
      ratingOptions.put(5, "★★★★★");
      
      model.addAttribute("ratingOptions", ratingOptions);
      model.addAttribute("title", item.getTitle());
      model.addAttribute("itemId", itemId);
      
      return "product/addReview";
   }
	
	@PostMapping("/shop/addReview.do")	//리뷰 등록
	public String checkReview(@ModelAttribute("review") Review review, BindingResult result, 
			@RequestParam("itemId")int itemId, HttpServletRequest rq, SessionStatus sessionStatus) {   

		  HttpSession session = rq.getSession(false);
		  new ReviewValidator().validate(review, result);
		  UserSession userSession = (UserSession) session.getAttribute("userSession");
			      
	      if (result.hasErrors()) {   //유효성 검증 에러 발생시 다시 입력 폼을 이동
	          return "redirect:/shop/review.do?itemId=" + itemId;	
	       }
	      	      
	      String buyer = userSession.getAccount().getUserId();
	      Review reviewObj = new Review(itemId, buyer, review.getDescription(), review.getRating());
	      	      
	      itemFacade.insertReview(reviewObj);	//리뷰 DB 삽입
	      
	      sessionStatus.setComplete();

	      return "redirect:/shop/AllReviewList.do?itemId=" + itemId;	
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/shop/AllReviewList.do") //모든 리뷰 목록 으로 이동
	public String allReviewList(@RequestParam("itemId")int itemId,Model model, ModelMap modelMap)
	{
		@SuppressWarnings("rawtypes")
		Map ratingOptions = new HashMap();
	      
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		
		PagedListHolder<Review> reviewList = new PagedListHolder<Review>(this.itemFacade.getReviewListByItemId(itemId));
		reviewList.setPageSize(5);	//페이지 넘김 처리
		    
		List<Review> reviews = itemFacade.getReviewListByItemId(itemId);
		
	    modelMap.addAttribute("reviews", reviews);
	    modelMap.addAttribute("ratingOptions", ratingOptions);
	    modelMap.addAttribute("reviewList", reviewList);	
	    model.addAttribute("itemId", itemId);
	      
	    return "product/reviewList";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/shop/AllReviewList2.do")	//리뷰 목록 페이지 넘김
	public String allReviewList2 (@ModelAttribute("reviewList") PagedListHolder<Review> reviewList, 
			@RequestParam("pageName") String page, @RequestParam("itemId")int itemId, Model model, ModelMap modelMap)
	{		   
		if ("next".equals(page)) {	//공동구매 목록에서  next 클릭시 다음 목록 페이지로 이동
			reviewList.nextPage();
		}
		else if ("previous".equals(page)) {	//공동구매 목록에서  previous 클릭시 이전 목록 페이지로 이동
			reviewList.previousPage();
		}
	      
		@SuppressWarnings("rawtypes")
		Map ratingOptions = new HashMap();
		      
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
			
		List<Review> reviews = itemFacade.getReviewListByItemId(itemId);
		
		modelMap.addAttribute("reviews", reviews);
		modelMap.addAttribute("ratingOptions", ratingOptions);
		modelMap.addAttribute("reviewList", reviewList);	   
		model.addAttribute("itemId", itemId);
		 
		return "product/reviewList";
	}
	
	@RequestMapping("/shop/goViewItem.do") //모든 리뷰 목록 으로 이동
	public String goViewItem(@RequestParam("itemId")int itemId, Model model, ModelMap modelMap)
	{
		Item item = itemFacade.getItem(itemId);
		String viewItem = "";
		
		switch (item.getProductId()) {
		case 0:
			viewItem = "redirect:/shop/groupBuying/viewItem.do";
			break;
		case 1:
			viewItem = "redirect:/shop/auction/viewItem.do";
			break;
		case 2:
			viewItem = "redirect:/shop/secondHand/viewItem.do";
			break;
		case 3:
			viewItem = "redirect:/shop/handMade/viewItem.do";
			break;
		}

		return viewItem + "?itemId=" + itemId + "&productId=" + item.getProductId();
	}
	
	@RequestMapping("/shop/deleteReview.do") //모든 리뷰 목록 으로 이동
	public String deleteReview(@RequestParam("itemId")int itemId, HttpServletRequest rq) {
		System.out.println("deleteReview");
		HttpSession session = rq.getSession(false);
		UserSession userSession = (UserSession) session.getAttribute("userSession");
		String buyer = userSession.getAccount().getUserId();
		
		Review review = itemFacade.findReviewByuserIdAndItemId(itemId, buyer);
		
		itemFacade.deleteReview(review.getReviewId());	//리뷰 삭제
		
	      return "redirect:/shop/AllReviewList.do?itemId=" + itemId;
	}
}