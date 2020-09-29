package com.example.usStore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.service.facade.UsStoreFacade;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 */

@Controller
@SessionAttributes("userSession")
public class ListOrdersController {

	private UsStoreFacade usStoreFacade;

	@Autowired
	public void setPetStore(UsStoreFacade usStoreFacade) {
		this.usStoreFacade = usStoreFacade;
	}

	@RequestMapping("/shop/listOrders.do")
	public ModelAndView handleRequest(
		@ModelAttribute("userSession") UserSession userSession
		) throws Exception {
		String userId = userSession.getAccount().getUserId();
		return new ModelAndView("order/ListOrders", "orderList", 
				usStoreFacade.getOrdersByUserId(userId));
	}

}
