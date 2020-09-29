package com.example.usStore.controller.item;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.usStore.domain.Item;
import com.example.usStore.domain.Review;
import com.example.usStore.service.ReviewValidator;
import com.example.usStore.service.facade.ItemFacade;

@Controller
public class ReviewController {
	
	@Autowired
	   private ItemFacade itemFacade; 
	
	@RequestMapping("/shop/review.do") 
    public String viewRank(@ModelAttribute("review") Review review, @RequestParam("itemId")int itemId, Model model) {
      System.out.println("review.do");
      
      Item item = itemFacade.getItem(itemId);
      
      model.addAttribute("title", item.getTitle());
      model.addAttribute("itemId", itemId);
      return "product/addReview";
   }
	
	//checkReview.do
	@PostMapping("/shop/checkReview.do")      // go checkGroupBuying.jsp
	public String checkReview(@ModelAttribute("review") Review review, BindingResult result, @RequestParam("itemId")int itemId, Model model, ModelMap modelMap) {   
		   
	      new ReviewValidator().validate(review, result);
	      
	      
	      if (result.hasErrors()) {   //유효성 검증 에러 발생시
	          model.addAttribute("itemId", itemId);
	          return "redirect:/shop/review.do?itemId=" + itemId;
	       }
	      
	      return "product/checkReview";
	}
	
}
