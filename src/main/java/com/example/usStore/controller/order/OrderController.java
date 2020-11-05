package com.example.usStore.controller.order;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Account;
import com.example.usStore.domain.Cart;
import com.example.usStore.domain.KakaoPayApproval;
import com.example.usStore.service.OrderValidator;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.UsStoreFacade;

import lombok.Setter;
import lombok.extern.java.Log;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 * @modified by Jieun Lee
 */

@Log
@Controller
@SessionAttributes({"sessionCart", "orderForm"})
public class OrderController {
	
	@Autowired
	private ItemFacade itemFacade;
	
	@Autowired
	private UsStoreFacade usStore;
	
    @Setter(onMethod_ = @Autowired)
    private KakaoPayService kakaopay;
    
	@Autowired
	private OrderValidator orderValidator;
	
	@ModelAttribute("orderForm")
	public OrderForm createOrderForm() {
		return new OrderForm();
	}

	@ModelAttribute("creditCardTypes")
	public List<String> referenceData() {
		
		ArrayList<String> creditCardTypes = new ArrayList<String>();
		creditCardTypes.add("결제 수단을 선택해주세요.");
		creditCardTypes.add("Visa");
		creditCardTypes.add("MasterCard");
		// add kakao pay 
		creditCardTypes.add("KakaoPay");
		return creditCardTypes;			
	}
	
	@RequestMapping("/shop/newOrder.do")
	public String initNewOrder(
			@RequestParam(value="payFlag", required=false) String payFlag,
			HttpServletRequest request,
			@ModelAttribute("sessionCart") Cart cart,
			@ModelAttribute("orderForm") OrderForm orderForm) throws ModelAndViewDefiningException {
		
		UserSession userSession = (UserSession) request.getSession().getAttribute("userSession");
		request.setAttribute("orderForm", orderForm);
		System.out.println("newOrder : " + payFlag);
		
		// restore orderForm in session
		if (cart != null) {
			// Re-read account from DB at team's request.
			Account account = usStore.getAccountByUserId(userSession.getAccount().getUserId());
			
			if(payFlag == null) {
				orderForm.getOrder().initOrder(account, cart, "OK");
			}
			return "order/NewOrderForm";	
		} else {
			ModelAndView modelAndView = new ModelAndView("Error");
			modelAndView.addObject("message", "An order could not be created because a cart could not be found.");
			throw new ModelAndViewDefiningException(modelAndView);
		}
	}
	
	
	@RequestMapping("/shop/newOrderSubmitted.do")
	public String bindAndValidateOrder(@RequestParam(value="payFlag", required=false) String payFlag, 
			HttpServletRequest request, @ModelAttribute("orderForm") OrderForm orderForm, BindingResult result) {

		
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
				if(payFlag != null && payFlag.equals("success")) {
					orderForm.getOrder().setCardType("KakaoPay");
				}
				return "order/ConfirmOrder";
			}
		}
		else {		// from ShippingForm
			orderValidator.validateShippingAddress(orderForm.getOrder(), result);
			if (result.hasErrors()) {
				return "order/ShippingForm";
			}
			if(payFlag != null && payFlag.equals("success")) {
				orderForm.getOrder().setCardType("KakaoPay");
			}
			return "order/ConfirmOrder";
		}
	}

    @RequestMapping("/shop/kakaoPay.do")
    public String kakaoPay(HttpServletRequest request, @ModelAttribute("orderForm") OrderForm orderForm) {
        log.info("kakaoPay.do");
        HttpSession session = request.getSession();
        
        return "redirect:" + kakaopay.kakaoPayReady(session, orderForm);
    }
    
    @RequestMapping("/shop/kakaoPaySuccess.do")
    public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
        log.info("kakaoPaySuccess pg_token : " + pg_token);        
        KakaoPayApproval kakaopayApproval = kakaopay.kakaoPayInfo(pg_token);

        return "redirect:/shop/newOrder.do?payFlag=success";
    }
    
    // 카카오페이 결제 실패시
    @RequestMapping("/shop/kakaoPaySuccessFail.do")
    public String kakaoPaySuccessFail() {
        log.info("kakaoPaySuccessFail");
        return "redirect:/shop/newOrder.do?payFlag=fail";
    }
    
    // 카카오페이 결제 취소시
    @RequestMapping("/shop/kakaoPayCancel.do")
    public String kakaoPayCancel() {
        log.info("kakaoPayCancel");
        return "redirect:/shop/newOrder.do?payFlag=cancel";
    }
    
    
	// 카카오페이 결제 완료 후 이 컨트롤러로 넘기면 될듯.
	@RequestMapping("/shop/confirmOrder.do")
	protected ModelAndView confirmOrder(@ModelAttribute("orderForm") OrderForm orderForm, SessionStatus status) {
		
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
