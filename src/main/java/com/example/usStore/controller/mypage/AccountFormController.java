package com.example.usStore.controller.mypage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.util.WebUtils;
import com.example.usStore.domain.University;
import com.example.usStore.service.AccountFormValidator;
import com.example.usStore.service.facade.UsStoreFacade;

@Controller
@RequestMapping({"/shop/newAccount.do","/shop/editAccount.do"})
@SessionAttributes("accountForm")
public class AccountFormController { 

	@Value("account/EditAccountForm")
	private String formViewName;
	
	@Value("index")
	private String successViewName;
	
	@Autowired
	private UsStoreFacade usStore;
	
	public void setusStore(UsStoreFacade usStore) {
		this.usStore = usStore;
	}
	
	@Autowired
	private AccountFormValidator validator;
	public void setValidator(AccountFormValidator validator) {
		this.validator = validator;
	}
	
	// 뒤로 가기 버튼 누르면 컨트롤러에서 세션 종료 시켜서 accountForm에 대한 참조를 삭제 시켜야함 
	// 애초에 판매글 추가할때랑 같은 원리임 
	
	@ModelAttribute("accountForm")
	public AccountForm formBackingObject(HttpServletRequest request) 
			throws Exception {
		System.out.println("before show Form ? ");
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
	public String showForm(HttpSession session, @RequestParam(value="univName", required=false) String univName,
			@RequestParam(value="univLink", required=false) String univLink,
			@RequestParam(value="univAddr", required=false) String univAddr,
			@RequestParam(value="region", required=false) String region,
			@ModelAttribute("accountForm") AccountForm accountForm) { 
		// 작성 또는 수정을 위해 폼을 열었을 때 
		
		System.out.println("show Form ");
		if(univName != null) { // 대학교 찾기를 눌렀을 때 
			accountForm.getAccount().setUniversity(univName);
			University university =  new University(univName, univLink, univAddr, region);
			session.setAttribute("university", university);
		}
		return formViewName;
	}
	
	@RequestMapping("/back.do")
	public String goBack(@ModelAttribute("accountForm")AccountForm accountForm, SessionStatus sessionStatus) {
		sessionStatus.setComplete();
		return "index";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String onSubmit( // 디비에 저장하려고 등록 버튼 눌렀을 때 
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("accountForm") AccountForm accountForm, 
			BindingResult result) throws Exception {

		validator.validate(accountForm, result);
		System.out.println("onSubmit");
		
		if (result.hasErrors()) { return formViewName;}

		University university = (University)session.getAttribute("university");
		if(university != null) {
			try {
				if (accountForm.isNewAccount()){
					System.out.println("newAccount");
					// 트랜젝션
					usStore.insertAccount(accountForm.getAccount(), university);
				}else { 
					usStore.updateAccount(accountForm.getAccount(), university);
				}
			}
			catch (DataIntegrityViolationException ex) {
				result.rejectValue("account.username", "USER_ID_ALREADY_EXISTS",
						"User ID already exists: choose a different ID.");
				return formViewName; 
			}
			session.removeAttribute("university");
		}
		
		UserSession userSession = new UserSession(accountForm.getAccount());
		usStore.getAccountByUserId(accountForm.getAccount().getUserId());
		session.setAttribute("userSession", userSession);
		return successViewName;  
	}
}
