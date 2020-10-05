package com.example.usStore.controller.mypage;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.util.WebUtils;
import com.example.usStore.domain.Account;
import com.example.usStore.service.AccountFormValidator;
import com.example.usStore.service.facade.UsStoreFacade;

/**
 * @author Juergen Hoeller
 * @since 01.12.2003
 * @modified by Changsup Park
 * @modified by Jieun Lee
 */
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
	
	@ModelAttribute("universityKinds")
	public List<String> referenceData() throws Exception {
		List<String> universityKinds = new ArrayList<String>();
		universityKinds.add("동덕여자대학교");
		universityKinds.add("성신여자대학교");
		universityKinds.add("카이스트");
		return universityKinds;	
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
	public String showForm() {
		return formViewName;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String onSubmit(
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("accountForm") AccountForm accountForm,
			BindingResult result) throws Exception {

		validator.validate(accountForm, result);
		System.out.println("onSubmit");
		if (result.hasErrors())
			return formViewName;
		
		System.out.println();
		//대학교 이름과 도로명 주소 맵핑
		if(accountForm.getAccount().getUniversity().equals("동덕여자대학교")) {
			accountForm.getAccount().setUniversity("서울특별시 성북구 월곡2동 화랑로13길 60");
		}else if(accountForm.getAccount().getUniversity().equals("성신여자대학교")) {
			accountForm.getAccount().setUniversity("서울특별시 성북구 돈암동 보문로34다길 2");
		}else if(accountForm.getAccount().getUniversity().equals("카이스트")) {
			accountForm.getAccount().setUniversity("대전광역시 유성구 어은동 대학로 291");
		}
		
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
