package com.example.usStore.controller.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import com.example.usStore.domain.Cart;
import com.example.usStore.domain.Item;
import com.example.usStore.service.facade.ItemFacade;
import com.example.usStore.service.facade.UsStoreFacade;

/**
 * @author Juergen Hoeller
 * @since 30.11.2003
 * @modified-by Changsup Park
 * @modified-by Jieun Lee
 */

@Controller
@SessionAttributes("sessionCart")
public class AddItemToCartController { 

	private ItemFacade itemFacade;
	
	@Autowired
	public void setItemFacade(ItemFacade itemFacade) {
		this.itemFacade = itemFacade;
	}

	@ModelAttribute("sessionCart")
	public Cart createCart() {
		return new Cart();
	}
	
	@RequestMapping("/shop/addItemToCart.do")
	public ModelAndView handleRequest(
			@RequestParam("workingItemId") int workingItemId,
			@RequestParam("productId") int productId,
			@ModelAttribute("sessionCart") Cart cart ) throws Exception {
		
		// if already item in cart
		if (cart.containsItemId(workingItemId)) {
			// increment quantity
			cart.incrementQuantityByItemId(workingItemId);
		} else {
			// isInStock is a "real-time" property that must be updated
			// every time an item is added to the cart, even if other
			// item details are cached.
			System.out.println("workingItemId : " + workingItemId);
			System.out.println("productId : " + productId);
			
			Item item = null;
			switch(productId) {
				case 0:
					item = this.itemFacade.getGroupBuyingItem(workingItemId);
					break;
				case 1:
					item = this.itemFacade.getAuctionById(workingItemId);
					break;
				case 2:
					item = this.itemFacade.getSecondHandItem(workingItemId);
					break;
				case 3:
					item = this.itemFacade.getHandMadeById(workingItemId);
					break;
			}
			
			// is it in stock? yes -> true // no -> false
			boolean isInStock = this.itemFacade.isItemInStock(workingItemId, item.getProductId());
			cart.addItem(item, isInStock);
		}
		return new ModelAndView("order/Cart", "cart", cart);
	}
}