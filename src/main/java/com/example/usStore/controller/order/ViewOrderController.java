package com.example.usStore.controller.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.LineItem;
import com.example.usStore.domain.Orders;
import com.example.usStore.service.OrderService;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.UsStoreFacade;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 * @modified by Jieun Lee
 */

@Controller
@SessionAttributes("userSession")
public class ViewOrderController {

	private UsStoreFacade usStoreFacade;
	
	@Autowired
	private ItemFacade itemFacade; 
	
	@Autowired
	public void setusStore(UsStoreFacade usStoreFacade) {
		this.usStoreFacade = usStoreFacade;
	}

	@RequestMapping("/shop/viewOrder.do")
	public ModelAndView handleRequest(
			@ModelAttribute("userSession") UserSession userSession,
			@RequestParam("orderId") int orderId) throws Exception {
		
		Orders order = usStoreFacade.getOrder(orderId);
		
		// check username in Orders
		if (userSession.getAccount().getUsername().equals(order.getShipToUsername())) {
			System.out.println("account username : " + userSession.getAccount().getUsername());
			System.out.println("order shipToUsername : " + order.getShipToUsername());
			return new ModelAndView("order/ViewOrder", "order", order);
		}
		else {
			System.out.println("account username : " + userSession.getAccount().getUsername());
			System.out.println("Order : " + order.toString());
			System.out.println("order shipToUsername : " + order.getShipToUsername());
			return new ModelAndView("Error", "message", "You may only view your own orders.");
		}
	}
	
	 // go index(remove sessions)
	@RequestMapping("/shop/order/viewItem.do")
	public String goViewItem(@RequestParam("itemId") int itemId) {
		String viewItem = "";

		Item item = itemFacade.getItem(itemId);
		
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
	
	@RequestMapping("/shop/order/goAddReview.do")
	public String goAddReview(@RequestParam("itemId") int itemId, @RequestParam("userId") String userId, HttpServletResponse response) throws IOException {
		  
		   if(itemFacade.findReviewByuserIdAndItemId(itemId, userId) == null) {	//해당 제품 리뷰 기록 없는 경우
			   return "redirect:/shop/review.do?itemId=" + itemId;	//리뷰 작성 페이지 이동
		   }
			 //해당 아이템을 구매한 기록 없는 경우
			   PrintWriter out=response.getWriter();
			   out.println("<script>");
			   out.print("alert('You have already written review!');");
			   out.print("location.href='/usStore/shop/AllReviewList.do?itemId=" + itemId + "';");
			   out.println("</script>");
			   out.flush();
			   out.close();
			   
		 //리뷰 권한 없음
		return "redirect:/shop/AllReviewList.do?itemId=" + itemId;
	}
}
