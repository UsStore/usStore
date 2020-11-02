package com.example.usStore.controller.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.util.WebUtils;

import com.example.usStore.domain.Accuse;
import com.example.usStore.service.facade.MyPageFacade;
import com.example.usStore.service.facade.UsStoreFacade;

@Controller
@SessionAttributes("userSession")
@RequestMapping("/shop/viewAccount.do")
public class ViewAccountController {

	@Autowired
	private UsStoreFacade usStore;
	public void setusStore(UsStoreFacade usStore) {
		this.usStore = usStore;
	}
	
	private MyPageFacade myPageFacade;
	
	@Autowired
	public void setMyPageFacade(MyPageFacade myPageFacade) {
		this.myPageFacade = myPageFacade;
	}

	@ModelAttribute("accountForm")
	public AccountForm formBackingObject(HttpServletRequest request) 
			throws Exception {
		UserSession userSession = 
			(UserSession) WebUtils.getSessionAttribute(request, "userSession");
		if (userSession != null) {	// edit an existing account
			return new AccountForm(
					usStore.getAccountByUserId(userSession.getAccount().getUserId()));
		}
		else {	// create a new account
			return new AccountForm();
		}
	}

	@RequestMapping(method = RequestMethod.GET)
	public String showForm(Model model, HttpServletRequest rq) {
		HttpSession session = rq.getSession(false);
		UserSession userSession = (UserSession)session.getAttribute("userSession");
		String victim = userSession.getAccount().getUserId();
		List<Accuse> accuseList = this.myPageFacade.selectAccuseList(victim);
		
		model.addAttribute(accuseList);
		return "account/mypage";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String goEdit() {  // url 바꾸고 GET으로 수정해보기 
		return "redirect:/shop/editAccount.do";
	}
}
