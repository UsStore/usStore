package com.example.usStore.controller.item;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.example.usStore.controller.mypage.UserSession;
import com.example.usStore.domain.Inquiry;
import com.example.usStore.domain.Item;
import com.example.usStore.domain.Reply;
import com.example.usStore.service.facade.InquiryFacade;
import com.example.usStore.service.facade.ItemFacade;

@Controller 
@SessionAttributes("InquiryForm")
public class InquiryController {
	
	@Autowired
	private InquiryFacade inquiryFacade;
	
	@Autowired
	private ItemFacade itemFacade; 
	
	@RequestMapping("/shop/getInquiry.do/{itemId}")
	@ResponseBody
	public List<Inquiry> getInquiry(@PathVariable("itemId") int itemId, HttpServletResponse response)  throws IOException{
		
		List<Inquiry> inquiryList = this.inquiryFacade.getInquiryByItem(itemId);
		if (inquiryList == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return null;
		}
		return inquiryList;
	}
	
	@RequestMapping("/shop/getReply.do/{itemId}")
	@ResponseBody
	public List<Reply> getReply(@PathVariable("itemId") int itemId, HttpServletResponse response)  throws IOException{
	
		List<Reply> replyList = this.inquiryFacade.getReplyByItem(itemId);
		if (replyList == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return null;
		}
		return replyList;
	}
	
	@ModelAttribute("InquiryForm")
    public Inquiry formBacking() { //accessor method
		   Inquiry inquiryForm = new Inquiry();
		   //필드 초기화 할것 있으면 여기서 하기 
		   return inquiryForm;
	}
	  
	@RequestMapping("/shop/goAddInquiry.do")  // 제품 문의 작성하기 
	public String addInquiry( @ModelAttribute("InquiryForm") Inquiry inquiryForm, 
			@RequestParam("itemId") int itemId, 
			Model model) { // 인터셉터 걸기 
		// 인터셉터로 들어왔기 때문에 로그인 상태임 
		System.out.println("/shop/goAddInquiry.do 컨트롤러 진입 ");

		Item item = itemFacade.getItem(itemId);
		String title = item.getTitle();
		System.out.println("아이디 : " + itemId);
		
		
		model.addAttribute("title", title);
		model.addAttribute("itemId", itemId);
		return "product/addInquiry"; // 문의하는 페이지로 이동 
	}
	
	@RequestMapping("/shop/addInquiry.do") //디비에 등록하기 - insert 
	public String addInquiry( @ModelAttribute("InquiryForm") Inquiry inquiryForm, 
			@RequestParam("itemId") int itemId,
			HttpServletRequest rq, SessionStatus sessionStatus) throws IOException{
		
		HttpSession session = rq.getSession(false);
		UserSession userSession = (UserSession) session.getAttribute("userSession");     
	    String loginUser = userSession.getAccount().getUserId();
	     
	    Item item = itemFacade.getItem(itemId);
	    
	    inquiryForm.setItemId(itemId);
	    inquiryForm.setUserId(loginUser);
	    inquiryForm.setIsSecret("0");
		
		this.inquiryFacade.insertInquiry(inquiryForm);
		sessionStatus.setComplete();
		
		if(item.getProductId() == 0){ 
			return "redirect:/shop/groupBuying/viewItem.do?itemId=" + itemId + "&productId=0";	
		} else if(item.getProductId() == 1){	
			return "redirect:/shop/auction/viewItem.do?itemId=" + itemId + "&productId=1";	
		} else if(item.getProductId() == 2) {	
			return "redirect:/shop/secondHand/viewItem.do?itemId=" + itemId + "&productId=2";	
		} else{
			return "redirect:/shop/handMade/viewItem.do?itemId=" + itemId + "&productId=3";
		}
	}
	
	
	@RequestMapping("/shop/deleteInquiry.do") 
	public String deleteInquiry(@RequestParam("itemId")int itemId, @RequestParam("QID")int QID) {
		
		System.out.println("deleteReview");
		Item item = itemFacade.getItem(itemId);
		System.out.println("productId : " + item.getProductId());
		
		this.inquiryFacade.deleteInquiry(QID);
		
		if(item.getProductId() == 0){ 
			return "redirect:/shop/groupBuying/viewItem.do?itemId=" + itemId + "&productId=0";	
		} else if(item.getProductId() == 1){	
			return "redirect:/shop/auction/viewItem.do?itemId=" + itemId + "&productId=1";	
		} else if(item.getProductId() == 2) {	
			return "redirect:/shop/secondHand/viewItem.do?itemId=" + itemId + "&productId=2";	
		} else{
			return "redirect:/shop/handMade/viewItem.do?itemId=" + itemId + "&productId=3";
		}
	}
	
	

}
