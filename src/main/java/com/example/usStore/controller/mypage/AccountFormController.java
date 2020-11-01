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
import org.springframework.web.util.WebUtils;
import com.example.usStore.service.AccountFormValidator;
import com.example.usStore.service.facade.UsStoreFacade;

@Controller
@RequestMapping({"/shop/newAccount.do","/shop/editAccount.do"})
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
	
	@ModelAttribute("accountForm")
	public AccountForm formBackingObject(HttpServletRequest request) 
			throws Exception {
		System.out.println("formBackingObject");
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
	public String showForm(@RequestParam(value="univName", required=false) String univName,
			@ModelAttribute("accountForm") AccountForm accountForm) { // 작성 또는 수정을 위해 폼을 열었을 때 
		// 파라미터가 있어도 되고 없어도 됨 
		System.out.println("pop up 에서대학 찾은거 넘겨준거 : " + univName);
		accountForm.getAccount().setUniversity(univName);
		return formViewName;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String onSubmit( // 디비에 저장하려고 등록 버튼 눌렀을 때 
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("accountForm") AccountForm accountForm,
			BindingResult result) throws Exception {

		validator.validate(accountForm, result);
		System.out.println("onSubmit");
		System.out.println("대학교 이름 제대로 옴? " + accountForm.getAccount().getUniversity());
		
		if (result.hasErrors())
			return formViewName;
		
		try {
			if (accountForm.isNewAccount()) {
				System.out.println("newAccount");
				usStore.insertAccount(accountForm.getAccount());
			}
			else {
				System.out.println("updateAccount");
				usStore.updateAccount(accountForm.getAccount());
			}
		}
		catch (DataIntegrityViolationException ex) {
			result.rejectValue("account.username", "USER_ID_ALREADY_EXISTS",
					"User ID already exists: choose a different ID.");
			return formViewName; 
		}
		
		UserSession userSession = new UserSession(accountForm.getAccount());
		usStore.getAccountByUserId(accountForm.getAccount().getUserId());
		session.setAttribute("userSession", userSession);
		return successViewName;  
	}
}
