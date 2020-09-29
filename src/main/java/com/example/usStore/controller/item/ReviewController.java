package com.example.usStore.controller.item;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReviewController {
	
	@RequestMapping("/shop/addReview.do") 
    public String viewRank(ModelMap modelMap, HttpServletRequest rq) {
      System.out.println("review 작성 페이지");
      
      return "product/addReview";
   }
}
