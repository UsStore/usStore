package com.example.usStore.controller.cart;

import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.example.usStore.domain.Cart;
import com.example.usStore.domain.CartItem;

/**
 * @author Juergen Hoeller
 * @since 30.11.2003
 * @modified-by Changsup Park
 */

@Controller
@SessionAttributes("sessionCart")
public class UpdateCartQuantitiesController { 

	@RequestMapping("/shop/updateCartQuantities.do")
	public ModelAndView handleRequest(
			HttpServletRequest request,	
			@ModelAttribute("sessionCart") Cart cart) throws Exception {
		
		// get all cart items for update quantities
		Iterator<CartItem> cartItems = cart.getAllCartItems();
		
		while (cartItems.hasNext()) {
			CartItem cartItem = (CartItem) cartItems.next();
			int itemId = cartItem.getItem().getItemId();
			try {
				// all items quantity update
				int quantity = Integer.parseInt(request.getParameter(String.valueOf(itemId)));
				cart.setQuantityByItemId(itemId, quantity);
				
				if (quantity < 1) {
					cartItems.remove();
				}
			}
			catch (NumberFormatException ex) {
				// ignore on purpose
			}
		}
		return new ModelAndView("order/Cart", "cart", cart);
	}

}
