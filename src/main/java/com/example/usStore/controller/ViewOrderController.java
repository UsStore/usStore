package com.example.usStore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Orders;
import com.example.usStore.service.OrderService;
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
	public String goIndex(@RequestParam("itemId") int itemId, @RequestParam("productId") int productId) {
		String viewItem = "";

		switch (productId) {
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

		return viewItem + "?itemId=" + itemId + "&productId=" + productId;
	}
}
