package com.example.usStore.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.Cart;
import com.example.usStore.service.OrderValidator;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.UsStoreFacade;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 */
@Controller
@SessionAttributes({"sessionCart", "orderForm"})
public class OrderController {
	
	@Autowired
	private ItemFacade itemFacade;
	
	@Autowired
	private UsStoreFacade usStore;
	
	@Autowired
	private OrderValidator orderValidator;
	
	@ModelAttribute("orderForm")
	public OrderForm createOrderForm() {
		return new OrderForm();
	}

	@ModelAttribute("creditCardTypes")
	public List<String> referenceData() {
		
		ArrayList<String> creditCardTypes = new ArrayList<String>();
		creditCardTypes.add("Visa");
		creditCardTypes.add("MasterCard");
		// add kakao pay -> connect I'mPort API
		creditCardTypes.add("Kakao Pay");
		return creditCardTypes;			
	}
	
	@RequestMapping("/shop/newOrder.do")
	public String initNewOrder(HttpServletRequest request,
			@ModelAttribute("sessionCart") Cart cart,
			@ModelAttribute("orderForm") OrderForm orderForm) throws ModelAndViewDefiningException {
		
		UserSession userSession = (UserSession) request.getSession().getAttribute("userSession");
		if (cart != null) {
			// Re-read account from DB at team's request.
			Account account = usStore.getAccountByUserId(userSession.getAccount().getUserId());
			
			orderForm.getOrder().initOrder(account, cart, "OK");
			return "order/NewOrderForm";	
		} else {
			ModelAndView modelAndView = new ModelAndView("Error");
			modelAndView.addObject("message", "An order could not be created because a cart could not be found.");
			throw new ModelAndViewDefiningException(modelAndView);
		}
	}
	
	// process 변경 필요.
	@RequestMapping("/shop/newOrderSubmitted.do")
	public String bindAndValidateOrder(HttpServletRequest request,
			@ModelAttribute("orderForm") OrderForm orderForm, BindingResult result) {
		
		if (orderForm.didShippingAddressProvided() == false) {	
			// from NewOrderForm
			orderValidator.validateCreditCard(orderForm.getOrder(), result);
			orderValidator.validateBillingAddress(orderForm.getOrder(), result);
			
			if (result.hasErrors()) {
				return "order/NewOrderForm";
			}
			if (orderForm.isShippingAddressRequired() == true) {
				orderForm.setShippingAddressProvided(true);
				return "order/ShippingForm";
			} else {
				return "order/ConfirmOrder";
			}
		}
		else {		// from ShippingForm
			orderValidator.validateShippingAddress(orderForm.getOrder(), result);
			if (result.hasErrors()) {
				return "order/ShippingForm";
			}
			return "order/ConfirmOrder";
		}
	}
	
	// 여기로 넘어가기 전에 카카오페이 결제가 완료되어야 함.
	// 카카오페이 결제 완료 후 이 컨트롤러로 넘기면 될듯.
	@RequestMapping("/shop/confirmOrder.do")
	protected ModelAndView confirmOrder(
			@ModelAttribute("orderForm") OrderForm orderForm, SessionStatus status) {
		
		System.out.println("confirmOrder.do : " + orderForm.getOrder().getLineItems().size());
		
		// insert Order
		usStore.insertOrder(orderForm.getOrder());
		ModelAndView mav = new ModelAndView("order/ViewOrder");
		
		mav.addObject("order", orderForm.getOrder());
		mav.addObject("message", "Thank you, your order has been submitted.");
		
		// updateQuantity order items
		itemFacade.updateQuantity(orderForm.getOrder());
		
		// remove sessionCart and orderForm from session
		status.setComplete();
		return mav;
	}
}
